function color = pixelValue( image, x, y, method )
% pixel value at real coordinates

if inImage( size(image) ,x,y ) == 1
    Size = size(image);
    xsize = Size(1,1);
    ysize = Size(1,2);

    if x > xsize
        x = xsize;
    end
    if y > ysize
        y = ysize;
    end
    if x < 1
        color = 0;
        return ;
    end
    if y < 1
        color = 0;
        return ;
    end
    % do the interpolation
    switch ( method )
        case 'nearest'
            % Do nearest neighbour
            nearestX = floor(x + 0.5);
            nearestY = floor(y + 0.5);
            color = image(nearestX, nearestY);
            return ;
        case 'linear'
            % Do bilinear interpolation
            a = y - floor(y);
            b = x - floor(x);
            ul = image(floor(x), floor(y));
            ll = image(ceil(x), floor(y));
            ur = image(floor(x), ceil(y));
            lr = image(ceil(x), ceil(y));
            color = ((1-a)*(1-b)*ul)+((1-a)*b*ll)+(a*(1-b)*ur)+ a*b*lr;
            return ;
           
    end %end switch
else
    Size = size(image);
    xsize = Size(1,1);
    ysize = Size(1,2);

    if x > xsize
        x = xsize;
    end
    if y > ysize
        y = ysize;
    end
    if x < 1
        color = 0;
        return ;
    end
    if y < 1
        color = 0;
        return ;
    end
       
    switch ( method )
        case 'nearest'
            % Do nearest neighbour
            nearestX = floor(x + 0.5);
            nearestY = floor(y + 0.5);
            color = image(nearestX, nearestY);
            return ;
        case 'linear'
            % Do bilinear interpolation
            a = y - floor(y);
            b = x - floor(x);
            ul = image(floor(x), floor(y));
            ll = image(ceil(x), floor(y));
            ur = image(floor(x), ceil(y));
            lr = image(ceil(x), ceil(y));
            color = ((1-a)*(1-b)*ul)+((1-a)*b*ll)+(a*(1-b)*ur)+ a*b*lr;
            return ;
    end
end

