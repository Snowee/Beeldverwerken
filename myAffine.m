function r = myAffine ( image , x1 , y1 , x2 , y2 , x3 , y3 , M , N , method )
image = im2double(image);
Imagesize = size(image);
xsize = Imagesize(1,1);
ysize = Imagesize(1,2);
r = zeros (N , M ); % allocate new image of correct size
% calculate X ( insert code for this )
A = [1, 1, 1; 1, N, 1; M, N, 1]';
B = [x1, x2, x3; y1, y2, y3];
X = B/A

% [C, Y] = meshgrid(1:xsize, 1:ysize);
% indices = [C(:), Y(:)];
% indices = indices';
% indexAppend = ones(1,length(indices));
% 
% indices = [indices;indexAppend];
% 
% AffineIndices = X * indices
% 
% for i = 1:length(AffineIndices)
%    if AffineIndices(2, i) <= ysize && AffineIndices(1, i) <= xsize
%        color(i) = pixelValue(image, AffineIndices(1, i), AffineIndices(2,i), method);
%    else
%        color(i) = 0;
%    end
% end
% r = reshape(color, xsize,ysize);

for xa = 1: M
    for ya = 1: N
% calculate x and y ( insert code for this )

        As = X * [xa;ya;1];
        x = As(1);
        y = As(2);
        if y <= ysize && x <= xsize
            r ( ya , xa ) = pixelValue ( image , x , y , method );
        else
            r( ya, xa ) = 0;
        end
    end
end
imshow(r)

%myAffine(image,10,100,100,10,190,110,500,500,'linear')