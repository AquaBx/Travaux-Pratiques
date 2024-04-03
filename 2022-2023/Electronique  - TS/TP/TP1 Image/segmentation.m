function [ ID ] = segmentation( stats )

% prend en argument les propriétés renvoyés par la fonction regionprops et
% renvoie les indices des pixels correspondant à la région contenant au
% moins N pixels et dont le centre se situe ....
N= 40;
X=256;
Y=256;
centroids = cat(1, stats.Centroid);
areas = cat(1, stats.Area);

region_id=(areas>N)&(centroids(:,1)>X)&(centroids(:,2)>Y);

ID = stats(region_id).PixelIdxList;

end


