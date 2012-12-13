image = im2double(imread('potatoes12.png'));

binaryPotatoes = image>0.3;
% figure
% imshow(binaryPotatoes)

% OPEN ---> Close
erodedPotatoes = imerode(binaryPotatoes,strel('square',3));
openedPotatoes = imdilate(erodedPotatoes,strel('square',3));
dilateOpen = imdilate(openedPotatoes,strel('square',3));
openClosed = imerode(dilateOpen,strel('square',3));
figure
imshow(openClosed)

border = zeros ( size ( openClosed ) );
border (1 ,:) = 1;
border ( end ,:) = 1;
border (: ,1) = 1;
border (: , end ) = 1;

[Row, Column] = find(openClosed == border & openClosed ~=0);
mask = zeros(size(openClosed));
BorderCoords = [Row,Column];
for i = 1:size(BorderCoords,1)
    mask(BorderCoords(i,1),BorderCoords(i,2)) = 1;
end
% figure
% imshow(mask)
figure
borderPotatoe = imreconstruct(mask, openClosed)
imshow(borderPotatoe)
% figure
% imshow(openClosed(openClosed == border & openClosed ~=0))