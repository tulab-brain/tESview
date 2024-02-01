function showimg

mydata=get(gcf,'UserData');


h(1)=subplot(2,2,1);d(1,:)=[1 3]; 
imagesc(squeeze(mydata.ef_mag(:,mydata.pos(2),:))');
hold on;
rngx=1:5:size(mydata.xi,1); rngy=mydata.pos(2); rngz=1:5:size(mydata.xi,3);
quiver3(mydata.xi(rngx,rngy,rngz),mydata.zi(rngx,rngy,rngz),mydata.yi(rngx,rngy,rngz),...
    mydata.ef_all(rngx,rngy,rngz,1),mydata.ef_all(rngx,rngy,rngz,3),mydata.ef_all(rngx,rngy,rngz,2),2,'color','k'); %,0.08,'nointerp');
hold off;

h(2)=subplot(2,2,2);d(2,:)=[2 3]; 
imagesc(squeeze(mydata.ef_mag(mydata.pos(1),:,:))'); 
hold on;
rngx=mydata.pos(1); rngy=1:5:size(mydata.xi,2); rngz=1:5:size(mydata.xi,3);
quiver3(mydata.yi(rngx,rngy,rngz),mydata.zi(rngx,rngy,rngz),mydata.xi(rngx,rngy,rngz),...
    mydata.ef_all(rngx,rngy,rngz,2),mydata.ef_all(rngx,rngy,rngz,3),mydata.ef_all(rngx,rngy,rngz,1),2,'color','k'); %,0.08,'nointerp');
hold off; 

h(3)=subplot(2,2,3);d(3,:)=[1 2]; 
imagesc(squeeze(mydata.ef_mag(:,:,mydata.pos(3)))'); 
hold on;
rngx=1:5:size(mydata.xi,1); rngy=1:5:size(mydata.xi,2); rngz=mydata.pos(3);
quiver3(mydata.xi(rngx,rngy,rngz),mydata.yi(rngx,rngy,rngz),mydata.zi(rngx,rngy,rngz),...
    mydata.ef_all(rngx,rngy,rngz,1),mydata.ef_all(rngx,rngy,rngz,2),mydata.ef_all(rngx,rngy,rngz,3),2,'color','k'); %,0.08,'nointerp');
hold off;


val = mydata.ef_mag(mydata.pos(1),mydata.pos(2),mydata.pos(3));
for i=1:3
    subplot(2,2,i);hold on;
    plot(mydata.pos(d(i,1)),mydata.pos(d(i,2)),'o','color',ones(1,3)*0.4,'linewidth',3,'markersize',12); 
    hold off;
    axis xy; axis equal; axis tight; axis off; caxis(mydata.clim);
    title([num2str(mydata.pos(d(i,:))) ': ' num2str(val,'%.2f')]);
end

color=colormap(jet(2^11));color=[1 1 1;color];
colormap(color)

h(4) = subplot(2,2,4); axis off; caxis(mydata.clim);
h(5) = colorbar('west');
set(h(5),'YAxisLocation','right','FontSize',18);
title(h(5),mydata.label,'FontSize',18);
mydata.h=h;
set(gcf,'UserData',mydata);

end