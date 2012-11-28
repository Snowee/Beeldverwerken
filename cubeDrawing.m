function cubeDrawing()
image = imread('calibrationpoints.jpg');
imshow(image)
load('calibrationpoints.mat')

projectionMatrix = estimateProjectionMatrix(xy, XYZ)


end

