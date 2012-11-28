function rotatedImage = rotateImage (image , angle , method )
image = im2double(image);
imageSize = size(image);
xsize = imageSize(1,1);
ysize = imageSize(1,2);

% Create the necessary rotation matrix
Heen = [1,0,(xsize/2);0,1,(ysize/2);0,0,1]
R = [cos(angle), -sin(angle), 0; sin(angle), cos(angle), 0; 0, 0, 1]
Terug = inv(Heen)%[1,0,-(ysize/2);0,1,-(xsize/2);0,0,1]
RBM = Heen * R * Terug

% Obtain indices needed for interpolation

[X, Y] = meshgrid(1:xsize, 1:ysize);
indices = [Y(:), X(:)];
indices = indices';
indexAppend = ones(1,length(indices));

indices = [indices;indexAppend];
% Obtain colors for the whole rotatedImage matrix
% using the specified interpolation method
rotatedIndices = RBM * indices;
for i = 1:length(rotatedIndices)
   if rotatedIndices(2, i) <= ysize && rotatedIndices(1, i) <= xsize
       color(i) = pixelValue(image, rotatedIndices(1, i), rotatedIndices(2,i), method);
   else
       color(i) = 0;
   end
end

rotatedImage = reshape(color,ysize,xsize);
imshow(rotatedImage);
end












