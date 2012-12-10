function master1()
im = im2double(rgb2gray(imread('shapes.png')));
subplot(1,2,1);
[h,EdgeIm] = hough(im, .1, 800, 800);
subplot(1,2,2);
houghlines(im, h, 32, EdgeIm);

end