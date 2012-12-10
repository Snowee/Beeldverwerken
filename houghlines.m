function [lines] = houghlines ( im , h , thresh, EdgeIm )
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
% 

rows = size( im, 1 );
cols = size( im, 2 );
rhomax = sqrt ( rows ^2 + cols ^2);
nrho = size(h,1);
ntheta = size(h,2);

% Old code for making a binary matrix and finding the regions of an image
% g = zeros(nrho,ntheta);
% g(h>=thresh) = 1;
% [BW,nregions] = bwlabel(g);

% Make a Gaussian filter in 1D to smooth the image over rho only
G = gauss1(3);
h = imfilter(h,G,'conv','replicate');

% Dilate the Hough Transform and check where the dilated equals the orignal
% Hough Transform
se = strel('disk',8);
maxima = (h > thresh) & (imdilate(h,se) == h);
% Find the coordinates of these maxima
[maxrow,maxcolumn] = find(maxima);

for n = 1:size(maxrow,1)
%     Old code for finding the maximum of each region
%     mask = BW == n ; % Form a mask for each region .
%     region = mask .* h ; % Point - wise multiply mask by Hough Transform
%     % to give you an image with just one region of
%     % the Hough Transform .
%     [maxval,Y] = max(region);
%     [maxval1,X] = max(maxval);

    % Get the row and column values of the maxima and calculate rho and
    % theta with these coordinates
    row = maxrow(n);
    column = maxcolumn(n);
    XY = [column;row];
    theta(n) = ((XY(1,1)*pi)/(ntheta));
    rho(n) = ((XY(2,1)*2*rhomax)/(nrho))-rhomax;
end

% Finding the endpoints using rho and theta
for i= 1:size(rho,2)
    [x1,y1,x2,y2] = thetarho2endpoints(theta(i),rho(i),rows,cols);
    XX(1:2,i) = [x1;x2];
    YY(1:2,i) = [y1;y2];
end
% Combine the endpoints in XXYY
XXYY = [XX;YY];
imshow(im,[]);
Lines = [];

% Get the edge points again
[y,x] = find(EdgeIm);
points = [x,y];

lines=[];
for i = 1:size(XXYY,2)
%  Used to plot all the lines  
   line(XXYY(1:2,i),XXYY(3:4,i));
   % The homogeneous coordinates of both points
   XYline1(1:3,i) = [XXYY(1,i);XXYY(3,i);1];
   XYline2(1:3,i) = [XXYY(2,i);XXYY(4,i);1];
   % Cross product to find the corresponding line
   c = cross(XYline1(1:3,i),XYline2(1:3,i));
   % Normalize the line
   c = c/sqrt(c(1)^2 + c(2)^2);
   % Add found line to existing Lines
   Lines = [Lines, c];
   % Get the Points of Line per line
   PoL = points_of_line(points, c,1);
   % And try to fit a line through these points
   LTP = line_through_points(PoL);
   % Add those lines to lines
   lines = [lines,LTP];

   % Used to plot all found points by points_of_line
   for j = 1:size(PoL)
        im(magic(5));
        hold on;
        plot(PoL(j,1), PoL(j, 2),'r.','MarkerSize',10);
        hold off;
   end

end

end

