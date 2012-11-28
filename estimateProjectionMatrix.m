function M = estimateProjectionMatrix(xy, xyz)
AMatrix = createAMatrix(xyz, xy)

[U, D, V] = svd(AMatrix);
m = V(:,end);
M = reshape(m, 4, 3)