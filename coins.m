image = im2double(imread('eight.tif'));

binary = image< isodata('eight.tif');

se = zeros(7,7);
se (1 ,1)=1;

C = imdilate(binary,se);

figure
oimshow(image,binary,C);


figure
subplot(2,3,1)
imshow(binary)
N = [0,3,15,30,60];
for i = 2:5
    subplot(2,3,i);
    C=imdilate(binary,strel('square',N(i)));
    imshow(C)
end
figure
subplot(2,3,1)
imshow(binary)
for i = 2:5
    subplot(2,3,i);
    C=imdilate(binary,strel('square',N(i)));
    D=imerode(C,strel('square',N(i)));
    imshow(D)
    oimshow(zeros(size(binary)),binary,D)
end
