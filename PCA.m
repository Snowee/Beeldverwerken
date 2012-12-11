function PCA(train, test, X, d)
[V,D] = eigs(X*X', d);
V

end