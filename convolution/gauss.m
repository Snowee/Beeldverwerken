function G = gauss(S)
% create appropriate ranges for x and y
M = 2*S;
N = 2*S;
x = -M : M ;
y = -N : N ;
% create a sampling grid
[X , Y ] = meshgrid (x , y );
% determine the scale
sigma = S ;
% calculate the Gaussian function
G = (1/((sqrt(2*pi)*sigma)^2))*exp(-(X.^2+Y.^2)/(2*(sigma^2)))