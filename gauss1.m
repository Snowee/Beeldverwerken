function G = gauss1(S)
% create appropriate ranges for x and y
M = 2*S;
N = 2*S;
X = -M : M ;
% create a sampling grid
% determine the scale
sigma = S ;
% calculate the Gaussian function
G = (1/(sqrt(2*pi)*sigma))*exp(-(X.^2)/(2*(sigma^2)));