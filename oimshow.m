function oimshow(im,ov1,ov2,ov3)
% make an overlay image
switch nargin
 case 1
  ov1=0.*im;
  ov2=0.*im;
  ov3=0.*im;
 case 2
  ov2=0.*im;
  ov3=0.*im;
 case 3
  ov3=0.*im;
end
R = im;
G = im;
B = im;
mx = max(max(im));
if mx==0 
  mx=1;
end

R(ov1) = mx;       G(ov1) = 0;         B(ov1) = 0;
R(ov2 & ~ov1) = 0; G(ov2 & ~ov1) = mx; B(ov2 & ~ov1) = 0;
R(ov3 & ~ov2 & ~ov1 ) = 0; G(ov3 & ~ov2 & ~ov1 ) = 0; B(ov3 & ~ov2 & ~ov1 ) = mx;


%R = max( mx.*ov1, R );
%G = max( mx.*(ov2 & ~ov1) , G );
%B = max( mx.*(ov3 & ~ov2 & ~ov1), B );
RGB(:,:,1)=R;
RGB(:,:,2)=G;
RGB(:,:,3)=B;
imshow(RGB);
