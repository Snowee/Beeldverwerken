function [Train, Test, X, XTest, meanIm] = dataSplit(data)
load(data);
for i = 1:size(images,2)
   sizes = size(images{i}.img,2)*size(images{i}.img,1);
   images{i}.img = reshape(images{i}.img, sizes,1);
end

Train = images(1:300);
Test = images(301:550);

TrainMean = zeros(16800,1);
for i = 1:300
    TrainMean = TrainMean + Train{1,i}.img;
end
meanIm = TrainMean ./ 300;


% allTrain =[];
% x = zeros(16800,300);
% for i = 1:size(train,2)
%     allTrain = [allTrain,train{1,i}.img];
% end
% meanIm = mean(Train.img,2)
X = zeros(16800,300);
XTest = zeros(16800,250);
for i = 1:size(Train,2)
    X(:,i) = Train{1,i}.img - meanIm;
end

for i = 1:size(Test,2)
    XTest(:,i) = Test{1,i}.img -meanIm;
end

end