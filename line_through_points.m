% Function to fit a line through found points with points_of_line
function l = line_through_points(points)
% Get the coordinates non homogeneous
points = points(:,1:2);

%Calculate the centroid of the points
C = mean(points);

% Calculate the Pi'(not transpose) using the points and centroid
for i = 1:size(points,1)
   Pi = points(i,:);
   Pi1(:,i) = Pi - C;
end

% Make the covariance matrix
Cov = (Pi1*Pi1')/size(points,1);
% Get the eigenvectors and eigenvalues
[V,D] = eig(Cov);
% Make U the first column of the eigenvector matrix
U = V(:,1);

% Get the coordinate pair with the smallest x coordinate
% and with the biggest x coordinate
minPoint = points(1,1:2);
maxPoint = points(end,1:2);

% Calculate the norm of U (eigenvector)
Unorm = sqrt(sum(U.^2));

% Find the beginpoint and endpoint of the line that has to be made
beginPoint = C' - U * sqrt(sum(minPoint.^2))/Unorm;
endPoint = C' + U * sqrt(sum(maxPoint.^2))/Unorm;

% Get the Xs and Ys of these begin and endpoints
Xs = [beginPoint(2,1);endPoint(2,1)];
Ys = [beginPoint(1,1);endPoint(1,1)];

% Make the points homogeneous
for i = 1:size(Xs)
    Xs(i, 3) = 1;
    Ys(i,3) = 1;
end
% Make the line between the points using the cross product
l = cross(Xs,Ys);


end