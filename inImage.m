function number = inImage( Size, x, y  )
xsize = Size(1,1);
ysize = Size(1,2);
if x > xsize | y > ysize
   number =0;
else
   number =1;
end
if x < 1 | y < 1
    number = 0;
else
    number = 1;
end
if ceil(x) > xsize | ceil(y) > ysize
    number = 0;
else
    number = 1;
end