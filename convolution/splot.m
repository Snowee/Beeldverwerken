G = imread('cameraman.tif');
H = imfilter (G, gauss(10), 'conv', 'replicate');
I = imfilter (G , gauss1 ( 10 )'*gauss1(10)  , 'conv' , 'replicate' );
subplot(2, 1, 1), imshow(H);
subplot(2, 1, 2), imshow(I);