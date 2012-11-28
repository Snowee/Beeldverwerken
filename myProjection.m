function projection = myProjection ( image , x1 , y1 , x2 , y2 , ...
x3 , y3 , x4 , y4 , m , n , method )
projection = zeros (n , m ); % allocate new image of correct size
% calculate projection matrix
image = im2double(image);
xy = [x1,x2,x3,x4;y1,y2,y3,y4];
uv = [1, 1, m, m; 1, n, 1, n];

Size = size(image);
xsize = Size(1,1);
ysize = Size(1,2);

projMatrix = createProjectionMatrix( xy',uv');
projMatrix = inv(projMatrix);
for xIndex = 1: m
    for yIndex = 1: n
        % calculate x and y
        projIndices = projMatrix * [xIndex;yIndex;1];
        x = projIndices(1)/projIndices(3);
        y = projIndices(2)/projIndices(3);
        projection ( yIndex, xIndex ) = pixelValue ( image , x , y , method );
    end
end
imshow(projection)