function [data lamda] = PCAnew( X,start,end1)
%http://holehouse.org/mlclass/14_Dimensionality_Reduction.html  you should normally do mean normalization and feature scaling on your data before PCA
%for mfcc X must be 12*something
X=zscore(X);
%X=X./max(max(X));
covarience=cov(X'); %convert something*12 to 12*12

%covarience=pca(zscore(X));
%sample=X';

[V lamda]=eigs(covarience,5); %V is 12*2 returns 5 largest eigen values

data=V'*X(:,start:end1); %data will be 2*(end1-start+1) 




