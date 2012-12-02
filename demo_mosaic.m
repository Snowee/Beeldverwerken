% script to demonstrate image mosaic
% by handpicking 4 matching points
% in the order topleft - topright - bottomright - bottomleft
f1 = imread('nachtwacht1.jpg');
f2 = imread('nachtwacht2.jpg');

% Apply RANSAC & SIFT to the images, returns a tform stuct to T
T = RANSAC(f1,f2);

% Former code for handpicking corresponding points
% [xy, xaya] = pickmatchingpoints(f1, f2, 4, 1)
% T = maketform('projective',xy', xaya')

% Former code for making projection matrix with own function
% T = maketform('projective',createProjectionMatrix(xy', xaya'))

% Transform image f1 with the transformation matrix
[x y] = tformfwd(T,[1 size(f1,2)], [1 size(f1,1)]);

% Print the images
xdata = [min(1,x(1)) max(size(f2,2),x(2))];
ydata = [min(1,y(1)) max(size(f2,1),y(2))];
f12 = imtransform(f1,T,'Xdata',xdata,'YData',ydata);
f22 = imtransform(f2, maketform('affine', [1 0 0; 0 1 0; 0 0 1]), 'Xdata',xdata,'YData',ydata);
subplot(1,1,1);
imshow(max(f12,f22));