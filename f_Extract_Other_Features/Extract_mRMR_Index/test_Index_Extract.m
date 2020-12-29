clear all;close all;clc
tic
disp('Preparing Train Data')

fTrainAV = fopen('za_AudioVideo_Train_1.txt','r'); 
c = 0;
tlineAV = fgetl(fTrainAV);
%Getting Train Features
while ischar(tlineAV)
	c = c + 1;
    %tlineAV = 'AudioVideoFeatures/P64/AudioVideo26600Feature.mat 0.11675 0.13674 0.18649 0.072348';
    fileInfoAV = strsplit(['folder_for_svr' tlineAV]);
    matfilenameAV = strjoin(fileInfoAV(1));
    ratingAV = str2double(fileInfoAV(2)) ;
    
    fAV = load(matfilenameAV);
    prdAV = fAV.predicted_value;
    featureAV = fAV.feature_array;
    actAV = ratingAV; %fAV.actual_value;

    trainDataX(c,:) = featureAV;
    trainDatay(c) = actAV; %or actA same 
    
    tlineAV = fgetl(fTrainAV);
end
fclose(fTrainAV);
c

features_matrix = trainDataX;
features_matrix_cat = categorize_features_matrix(features_matrix);

rating_array = trainDatay;
rating_array_cat = categorize_rating_XX(rating_array);
    
addpath([pwd '\mi']);
mRMRindex = getmRMRIndex(trainDataX,trainDatay,256);
rmpath([pwd '\mi']);

save('mRMRindex.mat','mRMRindex')

toc

