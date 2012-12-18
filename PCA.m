function [  E, gTest, g, gComp, bestMatch ] = PCA( train, test, X, XTest, MeanIm, d, testim )
load omni.mat
[V,D] = eigs( X'*X, d );

E = X*V*inv(D);
for i = 1:size(E,2)
    E(:,i) = E(:,i)./norm( E(:,i) );
end

g = E'*X;

EG = E*g;

% Plot first ten eigenvectors
% figure
% for i = 1:10
%     subplot( 2, 5, i )
%     imshow( reshape( E(:,i), 112, [] ), [] )
% end
 
% Print original image and estimate by eigenvectors
% figure
% subplot(2,1,1);
% imshow( reshape( X(:,1) + MeanIm, 112, 150 ) )
% subplot( 2, 1, 2 );
% imshow( reshape( EG(:,1) + MeanIm, 112, 150 ) )

gTest = E'*XTest; 
% gTestIm = gTest(:,testim);


for j = 1:size( gTest, 2 )
    for i = 1:size( g, 2 )
    % gDiff(:,i) = g(:,i)-gTestIm;
    % gSum(1,i) = sum(gDiff(:,i));
    gComp(i,j) = dot( g(:,i), gTest(:,j) );
    end
end
bestMatch = zeros(1,size(XTest,2));
for i = 1:size(gComp,2)
    [row, column] = find(gComp == max(gComp(:,i)));
    bestMatch(1,i) = row;
end

for i = 1:size(bestMatch,2)
   MatchedPositions(i,:) = train{bestMatch(1,i)}.position;    
end

for i = 1:size(test,2)
    testPositions(i,:) = test{i}.position;
end



% Xtest = testPositions(:,1);
% Ytest = testPositions(:,2);
% 
% size(MatchedPositions,1)
% Xtrain = MatchedPositions(:,1);
% Ytrain = MatchedPositions(:,2);
% train = plot(Xtrain,Ytrain,'o');
% hold on
% test = plot(Xtest,Ytest,'o');
% set(test,'Color', 'red');
% hold off


% gComp
% end
% [ row, column ] = find( gComp == max( gComp ) );
% match = column;
% end