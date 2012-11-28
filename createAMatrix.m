function Amatrix = createAMatrix(xyz, xy)
X = xyz (: , 1);
Y = xyz (: , 2);
Z = xyz (: , 3);
% we cannot use x' and y' in Matlab because ' means transposed
x = xy (: , 1);
y = xy (: , 2);

o = ones ( size ( x ));
z = zeros ( size ( x ));
Aoddrows = [X , Y , Z , o , z , z , z , z , -x .* X , -x .* Y , -x .* Z , -x ];
Aevenrows = [z , z , z , z , X , Y , Z , o , -y .* X , -y .* Y , -y .* Z , -y ];
Amatrix = [ Aoddrows ; Aevenrows ];