function houghlines ( im , h , thresh )
% HOUGHLINES
%
% Function takes an image and its Hough transform , finds the
% significant lines and draws them over the image
%
% Usage : houghlines (im , h, thresh )
%
% arguments :
% im - The original image
% h - Its Hough Transform
% thresh - The threshold level to use in the Hough Transform
% to decide whether an edge is significant
rows = size( im, 1 );
cols = size( im, 2 );
rhomax = sqrt ( rows ^2 + cols ^2); 
g = zeros(size(h,1),size(h,2));
% h(h<thresh) = 0;
g(h>=thresh) = 1;
imshow(h,[])
[BW,nregions] = bwlabel(g)
BW
h
for n = 1: nregions
    mask = BW == n ; % Form a mask for each region .
    region = mask .* h ; % Point - wise multiply mask by Hough Transform
    % to give you an image with just one region of
    % the Hough Transform .
   	[maxval,Y] = max(region);
    row = max(Y);
    [maxval1,X] = max(maxval);
    column = max(X);
    XY = [column;row]
end