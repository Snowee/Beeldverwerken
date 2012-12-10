function master3()
im = im2double(rgb2gray(imread('szeliski.png')));

subplot(1,2,1);
[h,EdgeIm] = hough(im, .5, 800, 600);
subplot(1,2,2);
houghlines(im, h, 40, EdgeIm);


end

