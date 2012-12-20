% Function for preprocessing the dataset with robot positioning images
% Takes a dataset
% Returns a trainingset, testset, matrix of train images minus mean image,
% matrix of test images minus mean image an the mean image
function [Train, Test, X, XTest, meanIm] = dataSplit(data)
% Load the dataset, creating struct: images
load(data);

% Reshaping all images in the dataset to vectors
for i = 1:size(images,2)
   sizes = size(images{i}.img,2)*size(images{i}.img,1);
   images{i}.img = reshape(images{i}.img, sizes,1);
end

% Divide the dataset into training and testset
Train = images(1:300);
Test = images(301:550);

% Calculate the mean image meanIm of the trainingset
TrainMean = zeros(16800,1);
for i = 1:300
    TrainMean = TrainMean + Train{1,i}.img;
end
meanIm = TrainMean ./ 300;

% Create the matrices with the training images minus the mean image and the
% test images minus the mean image
X = zeros(16800,300);
XTest = zeros(16800,250);
for i = 1:size(Train,2)
    X(:,i) = Train{1,i}.img - meanIm;
end

for i = 1:size(Test,2)
    XTest(:,i) = Test{1,i}.img -meanIm;
end

end