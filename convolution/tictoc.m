image = imread('cameraman.tif')
elapsedTime = 0;
for i = 2:15
    tic
    H = imfilter (image, gauss1 ( 10 )*gauss1(10)' , 'conv' , 'replicate' );
    elapsedTime(i) = elapsedTime(i-1) + toc;
end
subplot(2,1,1) = plot(elapsedTime)
elapsedTime = 0;
for i = 2:15
    tic
    H = imfilter (image, gauss( 10 ), 'conv' , 'replicate' );
    elapsedTime(i) = elapsedTime(i-1) + toc;
end
subplot(2,1,2) = plot(elapsedTime);