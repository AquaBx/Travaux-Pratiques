function [X,Y] = point_ref( Im )

statsL=regionprops(bwconncomp(Im),'area','PixelIdxList');
areas = cat(1, statsL.Area);
[maxA ind]=sort(areas);
region_id=ind(end-1);
point=statsL(region_id).PixelIdxList(1);
X=mod(point,size(Im,1));
Y=((point-X)/size(Im,1))+1;
X=X+1;




end


