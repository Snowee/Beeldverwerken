function l = line_through_points(points)
points = points(:,1:2)
C = mean(points);


for i = 1:size(points,1)
   Pi = points(i,1:2);
   Pi1(:,i) = Pi - C;
end

Cov = (Pi1*Pi1')/size(points,1);

[V,D] = eig(Cov);

U = V(:,1);

minPoint = points(1,1:2);
maxPoint = points(end,1:2);

Unorm = sqrt(sum(U.^2));

beginPoint = C' + U * sqrt(sum(minPoint.^2))/Unorm;
endPoint = C' - U * sqrt(sum(maxPoint.^2))/Unorm;

Xs = [beginPoint(1,1);endPoint(1,1)];
Ys = [beginPoint(2,1);endPoint(2,1)];
line(Xs,Ys)
l = 4;
end