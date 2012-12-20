% Function for applying PCA to a robot positioning task
% Takes a trainingset, testset, matrix of all train images minus the mean
% image, matrix of all test images minus the mean image, the mean image and
% the number of dimensions used for PCA.
% Returns an eigenvector matrix E, The gTest
function [  E, gTest, g, gComp, bestMatch, accuracy ] = PCA( train, test, X, XTest, MeanIm, d )
[V,D] = eigs( X'*X, d );

E = X*V*inv(D);
for i = 1:size(E,2)
    E(:,i) = E(:,i)./norm( E(:,i) );
end


%--------------------------------------------------
%- Code to plot d eigenvalues:
%--------------------------------------------------
% figure
% for i = 1:size(train,2)/6
%     eigenvalues(i) = D(i,i)
% end
% plot(eigenvalues)
% Plot first ten eigenvectors
% figure
% for i = 1:10
%     subplot( 2, 5, i )
%     imshow( reshape( E(:,i), 112, [] ), [] )
% end
% -------------------------------------------------
 
%-----------------------------------------------------------------
%- Code to print an original image and estimate by d eigenvectors
%-----------------------------------------------------------------
% figure
% subplot(2,1,1);
% imshow( reshape( X(:,1) + MeanIm, 112, 150 ) )
% subplot( 2, 1, 2 );
% imshow( reshape( EG(:,1) + MeanIm, 112, 150 ) )
%-----------------------------------------------------------------

% Compute the vectors of the components of X and XTest in eigenspace g and
% gTest consist of 300 and 250 vectors with each d elements
g = E'*X;
gTest = E'*XTest; 

% Make the correlation between all g vectors and all gTest vectors
gComp = zeros(size(train,2),size(test,2));
for j = 1:size( gTest, 2 )
    for i = 1:size( g, 2 )
        gComp(i,j) = dot( g(:,i), gTest(:,j) );
    end
end

% Find all the rows that are a best match to a testimage.
bestMatch = zeros(1,size(XTest,2));
for i = 1:size(gComp,2)
    [row, column] = find(gComp == max(gComp(:,i)));
    bestMatch(1,i) = row;
end

% Get all positions of the best match images
matchedPositions = zeros(size(bestMatch,2),2);
for i = 1:size(bestMatch,2)
    matchedPositions(i,:) = train{bestMatch(1,i)}.position;    
end

% Get all positions of the test images
testPositions = zeros(size(test,2),2);
for i = 1:size(test,2)
    testPositions(i,:) = test{i}.position;
end

% Initialize a counter for the accuracy
accuracyCounter = 0;

% Calculate the Euclidean distance between each testposition and
% matchedposition. If the Euclidean distance is less than 150 add 1
% to the accuracy counter
for i = 1:size(testPositions,1)
   xDifference = (matchedPositions(i,1)-testPositions(i,1))^2;
   yDifference = (matchedPositions(i,2)-testPositions(i,2))^2;
   euclideanDistance = sqrt(xDifference + yDifference);
   
   if euclideanDistance < 150
       accuracyCounter = accuracyCounter + 1;
   end
end
% Calculate the accuracy of the robot positioning task with d dimensions
accuracy = accuracyCounter/size(test,2);

%-----------------------------------------------------------------
%- Code for plotting all testpositions and all matched positions
%-----------------------------------------------------------------
% Xtest = testPositions(:,1);
% Ytest = testPositions(:,2);
% 
% size(matchedPositions,1)
% Xtrain = matchedPositions(:,1);
% Ytrain = matchedPositions(:,2);
% train = plot(Xtrain,Ytrain,'o');
% hold on
% test = plot(Xtest,Ytest,'o');
% set(test,'Color', 'red');
% hold off
%-----------------------------------------------------------------
end
