Group {

white = Region[1];
gray = Region[2];
csf = Region[3];
bone = Region[4];
skin = Region[5];
air = Region[6];
gel1 = Region[77];
gel2 = Region[78];
elec1 = Region[149];
elec2 = Region[150];
usedElec1 = Region[221];
usedElec2 = Region[222];
DomainC = Region[{white, gray, csf, bone, skin, air, gel1, gel2, elec1, elec2}];
AllDomain = Region[{white, gray, csf, bone, skin, air, gel1, gel2, elec1, elec2, usedElec1, usedElec2}];

}

Function {

sigma[white] = 0.126;
sigma[gray] = 0.276;
sigma[csf] = 1.65;
sigma[bone] = 0.01;
sigma[skin] = 0.465;
sigma[air] = 2.5e-14;
sigma[gel1] = 0.3;
sigma[gel2] = 0.3;
sigma[elec1] = 59000000;
sigma[elec2] = 59000000;
du_dn1[] = 3.8171;
du_dn2[] = -3.9459;
}

Jacobian {
  { Name Vol ;
    Case {
      { Region All ; Jacobian Vol ; }
    }
  }
  { Name Sur ;
    Case {
      { Region All ; Jacobian Sur ; }
    }
  }
}

Integration {
  { Name GradGrad ;
    Case { {Type Gauss ;
            Case { { GeoElement Triangle    ; NumberOfPoints  3 ; }
                   { GeoElement Quadrangle  ; NumberOfPoints  4 ; }
                   { GeoElement Tetrahedron ; NumberOfPoints  4 ; }
                   { GeoElement Hexahedron  ; NumberOfPoints  6 ; }
                   { GeoElement Prism       ; NumberOfPoints  9 ; } }
           }
         }
  }
}

FunctionSpace {
  { Name Hgrad_v_Ele; Type Form0;
    BasisFunction {
      // v = v  s   ,  for all nodes
      //      n  n
      { Name sn; NameOfCoef vn; Function BF_Node;
        Support AllDomain; Entity NodesOf[ All ]; }
    }
  }
}

Formulation {
  { Name Electrostatics_v; Type FemEquation;
    Quantity {
      { Name v; Type Local; NameOfSpace Hgrad_v_Ele; }
    }
    Equation {
      Galerkin { [ sigma[] * Dof{d v} , {d v} ]; In DomainC; 
                 Jacobian Vol; Integration GradGrad; }

      Galerkin{ [ -du_dn1[], {v} ]; In usedElec1;
                 Jacobian Sur; Integration GradGrad;}
      Galerkin{ [ -du_dn2[], {v} ]; In usedElec2;
                 Jacobian Sur; Integration GradGrad;}
    }
  }
}

Resolution {
  { Name EleSta_v;
    System {
      { Name Sys_Ele; NameOfFormulation Electrostatics_v; }
    }
    Operation { 
      Generate[Sys_Ele]; Solve[Sys_Ele]; SaveSolution[Sys_Ele];
    }
  }
}

PostProcessing {
  { Name EleSta_v; NameOfFormulation Electrostatics_v;
    Quantity {
      { Name v; 
        Value { 
          Local { [ {v} ]; In AllDomain; Jacobian Vol; } 
        }
      }
      { Name e; 
        Value { 
          Local { [ -{d v} ]; In AllDomain; Jacobian Vol; }
        }
      }
    }
  }
}
PostOperation {

{ Name Map; NameOfPostProcessing EleSta_v;
   Operation {
     Print [ e, OnElementsOf DomainC, Smoothing, File "MNI152_T1_1mm_MNI152leadField_e71.pos", Format NodeTable ];
   }
}

}
