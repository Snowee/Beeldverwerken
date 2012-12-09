function l = line_through_points(points)

C = mean(points(:,1:2));

for i = 1:size(points,1)
   Pi = points(i,1:2);
   Pi1(:,i) = Pi - C
end

Cov = (Pi1*Pi1')/size(points,1)

[V,D] = eig(Cov)

U = V(:,size(V,2))
l=U

end