close all;
clear all;
load('LungCut.mat');

figure(1);
subplot(2,2,1);
imshow(Im);
subplot(2,2,2);
hist(Im);

MinI1 = min(min(Im));
MaxI1 = max(max(Im));
I2 = (Im-MinI1)/(MaxI1-MinI1);


subplot(2,2,3);
imshow(I2);
subplot(2,2,4);
hist(I2);

seuil = SeuilOptimal(I2);
I3 = I2<seuil;

figure(2);
subplot(2,2,1);
imshow(I3);
subplot(2,2,2);
hist(I3);

I4 = imerode(imdilate(I3,strel('disk',2)),strel('disk',2));

subplot(2,2,3);
imshow(I4);
subplot(2,2,4);
hist(I4);

stats = regionprops(I4,"Centroid","Area","PixelIdxList");
list_indices= segmentation(stats);
I5 = Im>=0;
I5(list_indices) = 0;

figure(3);
subplot(2,1,1);
imshow(I5);

[X,Y] = point_ref(I5);
I6=regiongrowing(I5,X,Y);

figure(4);
subplot(2,1,2);
imshow(I6);
