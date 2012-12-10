function [Lines] = houghlines ( im , h , thresh )
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
nrho = size(h,1);
ntheta = size(h,2);

% g = zeros(nrho,ntheta);
% 
% g(h>=thresh) = 1;

% [BW,nregions] = bwlabel(g);
G = gauss1(3);
h = imfilter(h,G,'conv','replicate');

se = strel('disk',8);
maxima = (h > thresh) & (imdilate(h,se) == h);
[maxrow,maxcolumn] = find(maxima);

for n = 1:size(maxrow,1)
%     mask = BW == n ; % Form a mask for each region .
%     region = mask .* h ; % Point - wise multiply mask by Hough Transform
%     % to give you an image with just one region of
%     % the Hough Transform .
%    	[maxval,Y] = max(region);
    row = maxrow(n);
%     [maxval1,X] = max(maxval);
    column = maxcolumn(n);
    XY = [column;row];
    theta(n) = ((XY(1,1)*pi)/(ntheta));
    rho(n) = ((XY(2,1)*2*rhomax)/(nrho))-rhomax;
end
for i= 1:size(rho,2)
    [x1,y1,x2,y2] = thetarho2endpoints(theta(i),rho(i),rows,cols);
    XX(1:2,i) = [x1;x2];
    YY(1:2,i) = [y1;y2];
end
XXYY = [XX;YY];
imshow(im,[]);
Lines = [];

EdgeIm = edge( im, 'canny', 0.1 );
[y,x] = find(EdgeIm);
points = [x,y];

LTP1=[];
for i = 1:size(XXYY,2)
%    line(XXYY(1:2,i),XXYY(3:4,i));
   XYline1(1:3,i) = [XXYY(1,i);XXYY(3,i);1];
   XYline2(1:3,i) = [XXYY(2,i);XXYY(4,i);1];
   c = cross(XYline1(1:3,i),XYline2(1:3,i));
   c = c/sqrt(c(1)^2 + c(2)^2);
   Lines = [Lines, c];
   PoL = points_of_line(points, c,5);
   LTP = line_through_points(PoL);
   LTP1 = [LTP1,LTP];
%    lines(1,i) = lines(1,i)/sqrt(lines(1,i)^2 + lines(2,i)^2);
%    lines(2,i) = lines(2,i)/sqrt(lines(1,i)^2 + lines(2,i)^2);
%    lines(3,i) = lines(3,i)/sqrt(lines(1,i)^2 + lines(2,i)^2);
end
LTP1;
Lines; 
size(PoL, 1)
size(points, 1);

