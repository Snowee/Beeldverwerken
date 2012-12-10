function [Train, Test] = dataSplit(data)
load(data);
for i = 1:size(images,2)
   sizes = size(images{i}.img,2)*size(images{i}.img,1);
   images{i}.img = reshape(images{i}.img, sizes,1);
end

allTrain =[];
x = zeros(16800,300);
for i = 1:size(train,2)
    allTrain = [allTrain,train{1,i}.img];
end
meanIm = mean(allTrain,2);

for i = 1:size(allTrain,2)
    X(:,i) = allTrain(:,i) - meanIm;
end

Train = images(1:300);
Test = images(301:550);
end