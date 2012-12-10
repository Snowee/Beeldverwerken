function master2()
im = im2double(rgb2gray(imread('box.png')));

subplot(1,2,1);
[h,EdgeIm] = hough(im, .5, 600, 800);
subplot(1,2,2);
houghlines(im, h, 50, EdgeIm);


end

