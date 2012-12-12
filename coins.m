image = im2double(imread('eight.tif'))

binary = image< isodata('eight.tif')

se = zeros(7,7);
se (1 ,1)=1;

C = imdilate(binary,se);

oimshow(image,binary,C)