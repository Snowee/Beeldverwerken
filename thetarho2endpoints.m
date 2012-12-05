function [x1, y1, x2, y2] = thetarho2endpoints(theta, rho, rows, cols)
if theta <= 1.66  & theta >= 1.48
    y1 = 0;
    y2 = rows;
    x1 = rho/sin(theta);
    x2 = (rho+y2*cos(theta))/sin(theta);
else
    
    x1 = 0;
    x2 = cols;
    y1 = -rho/cos(theta);
    y2 = (cols*sin(theta)-rho)/cos(theta);
end
end