function [match,E,gTestIm,g] = PCA(train, test, MeanIm, X, d,testim)
[V,D] = eigs(X'*X, d);

E = X*V*inv(D);
for i = 1:size(E,2)
    E(:,i) = E(:,i)./norm(E(:,i));
end

g = E'*X;

EG = E*g;

figure
for i = 1:10
    subplot(2,5,i)
    imshow(reshape(E(:,i),112,[]),[])
end
 
figure
subplot(2,1,1);
imshow(reshape(X(:,1)+MeanIm,112,150))
subplot(2,1,2);
imshow(reshape(EG(:,1)+MeanIm,112,150))

gTest = E'*test; 

gTestIm = gTest(:,testim);

for i = 1:size(g,2)
    % gDiff(:,i) = g(:,i)-gTestIm;
    % gSum(1,i) = sum(gDiff(:,i));
    gComp(1,i) = dot(g(:,i),gTestIm);

end
[row,column] = find(gComp == max(gComp));
match = column;
end