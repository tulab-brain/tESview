function [ef_all,ef_mag] = ef_calculator(subj,simTag,recipe)
% EF superposition with generated leadfield
% subj: the directory of roast leadfield results and the filename of the input subject
% simTag: simulation tag of leadfield generation 
% recipe: {electrode name,injected current};
% e.g.{'C3',2,'F3',-0.5,'Cz',-0.5,'T7',-0.5,'P3',-0.5}


% loading files and leadfield

[dirname,baseFilename,ext] = fileparts(subj);
if strcmp(ext,'.gz')
    baseFilename=strrep(baseFilename,'.nii',[]);
end

hdrFilename = dir([dirname filesep baseFilename '*_header.mat']);   % read simulation paths of the retained subjects
hdrFile = [dirname filesep hdrFilename(1).name];
masksFilename = dir([dirname filesep baseFilename '*_masks.nii']);
masksname = [dirname filesep masksFilename(1).name];
masks = load_untouch_nii(masksname);
meshFile = [dirname filesep baseFilename '_' simTag '.mat'];
leadFieldFile = [dirname filesep baseFilename '_' simTag '_roastResult.mat'];
load(meshFile,'node','elem','face');
load(leadFieldFile,'A_all');
load(hdrFile,'hdrInfo');

fid = fopen('./elec72.loc'); C = textscan(fid,'%d %f %f %s'); fclose(fid);
allelec = C{4}; for i=1:length(allelec), allelec{i} = strrep(allelec{i},'.',''); end
elecName = (recipe(1:2:end-1))';
injectCurrent = cell2mat((recipe(2:2:end))');
I_opt=zeros(size(A_all,3),1);
for j=1:length(elecName)
    f=@(x)ismember(x,elecName(j));
    elec_id=find(cellfun(f,allelec));
    I_opt(elec_id)=injectCurrent(j);
end

% 
indBrain = elem((elem(:,5)==1 | elem(:,5)==2),1:4); indBrain = unique(indBrain(:));
A = A_all(indBrain,:,:);
nodeV = zeros(size(node,1),3);
for i=1:3, nodeV(:,i) = node(:,i)/hdrInfo.pixdim(i); end


isNaNinA = isnan(sum(sum(A,3),2)); % make sure no NaN is in matrix A or in locs
if any(isNaNinA), A = A(~isNaNinA,:,:); end


[xi,yi,zi] = ndgrid(1:hdrInfo.dim(1),1:hdrInfo.dim(2),1:hdrInfo.dim(3));
ef_all = zeros([hdrInfo.dim 3]);
isNaNinA = isnan(sum(sum(A_all,3),2)); % handle NaN properly
xopt = zeros(sum(~isNaNinA),4);
xopt(:,1) = find(~isNaNinA);
for i=1:size(A_all,2), xopt(:,i+1) = squeeze(A_all(~isNaNinA,i,:))*I_opt; end


F = TriScatteredInterp(nodeV(~isNaNinA,1:3), xopt(:,2));
ef_all(:,:,:,1) = F(xi,yi,zi);
F = TriScatteredInterp(nodeV(~isNaNinA,1:3), xopt(:,3));
ef_all(:,:,:,2) = F(xi,yi,zi);
F = TriScatteredInterp(nodeV(~isNaNinA,1:3), xopt(:,4));
ef_all(:,:,:,3) = F(xi,yi,zi);
ef_mag = sqrt(sum(ef_all.^2,4));


allMask = masks.img;
brain = (allMask==1 | allMask==2);
nan_mask_brain = nan(size(brain));
nan_mask_brain(find(brain)) = 1;
for i=1:size(ef_all,4), ef_all(:,:,:,i) = ef_all(:,:,:,i).*nan_mask_brain; end
ef_mag = ef_mag.*nan_mask_brain;

