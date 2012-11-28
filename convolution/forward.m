function  out = forward()
data = importdata('binaryLenses.txt');

X = data(:, 2:end-3);
Y = data(:, end-2:end);
W1 = X\Y