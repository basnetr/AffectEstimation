tic
addpath('svr_lbptop_support_files');

disp('Preparing Train Data')
fTrainAV = fopen('za_Audio_Train.txt','r'); %fTrainV = fopen('FinalVideoTrain.txt'); 

c = 0;
tlineAV = fgetl(fTrainAV); %tlineV = fgetl(fTrainV);

%Getting Train Features
while ischar(tlineAV)
	c = c + 1;
    %tlineAV = 'AudioFeatures/P23/Audio2720Feature.mat 0.23151 0.18404 0.16969 0.068476';
    fileInfoAV = strsplit(['D:/LinuxCaffeCode/CaffeRegressionRECOLA/AudioExtractionVFinal/e3_SVR/' tlineAV]);
    matfilenameAV = strjoin(fileInfoAV(1));
    ratingAV = str2double(fileInfoAV(2)) ;
    
    %D:/LinuxCaffeCode/CaffeRegressionRECOLA/AudioExtractionVFinal/e3_SVR/AudioFeatures/P23/Audio2720Feature.mat
%     fileInfoV = strsplit(tlineV);
%     matfilenameV = strjoin(fileInfoV(1));
%     ratingV = str2double(fileInfoV(2)); 
    
    fAV = load(matfilenameAV);
    prdAV = fAV.predicted_value;
    featureAV = fAV.feature_array;
    actAV = ratingAV; %fAV.actual_value;
    
%     fV = load(matfilenameV);
%     prdV = fV.predicted_value;
%     featureV = fV.feature_array;
%     actV = fV.actual_value;
    
%     featureAV = [featureAV, featureV];
    trainDataX(c,:) = featureAV;
    trainDatay(c) = actAV; %or actA same 
    
    tlineAV = fgetl(fTrainAV); %tlineV = fgetl(fTrainV);
end
fclose(fTrainAV); %fclose(fTrainV);


disp('Preparing Model')
size(trainDataX)
size(trainDatay')
%Obtaining the model
model = giveSVRmodel(double(trainDataX), double(trainDatay'));

disp('Preparing Test Data')
fTestAV = fopen('zb_Audio_Test.txt'); %fTestV = fopen('FinalVideoTest.txt');

c = 0;
tlineAV = fgetl(fTestAV); %tlineV = fgetl(fTestV);

%Getting Test Features
while ischar(tlineAV)
	c = c + 1;
    fileInfoAV = strsplit(['D:/LinuxCaffeCode/CaffeRegressionRECOLA/AudioExtractionVFinal/e3_SVR/' tlineAV]);
    matfilenameAV = strjoin(fileInfoAV(1));
    ratingAV = str2double(fileInfoAV(2));
    
%     fileInfoV = strsplit(tlineV);
%     matfilenameV = strjoin(fileInfoV(1));
%     ratingV = str2double(fileInfoV(2)); 
    
    fAV = load(matfilenameAV);
    prdAV = fAV.predicted_value;
    featureAV = fAV.feature_array;
    actAV = ratingAV; % fAV.actual_value;
    
%     fV = load(matfilenameV);
%     prdV = fV.predicted_value;
%     featureV = fV.feature_array;
%     actV = fV.actual_value;
    
%     featureAV = [featureAV, featureV];
    testDataX(c,:) = featureAV;
    testDatay(c) = actAV; %or actA same 
    
    tlineAV = fgetl(fTestAV); %tlineV = fgetl(fTestV);
end
fclose(fTestAV); %fclose(fTestV);



disp('Predicting...')
testData.X = double(testDataX);    testData.y = double(testDatay');

[testData, junk1, junk2] = scaleSVM(testData, testData, testData, 0, 1); %Normalizing

[valence_predicted, accuracy, prob_estimates] = svmpredict(testData.y, testData.X, model);
toc
    %total_predicted = cat(1,total_predicted,valence_predicted);
    %actual_value = cat(1,actual_value,testData.y);


    smooth_degree = 0.05;
    valence_predicted = smooth(valence_predicted,smooth_degree,'rloess');
    
    actual = testData.y;
predictedAV = valence_predicted;

q_AV = corrcoef(actual,predictedAV);
q_AV = q_AV(1,2);
m = mean(actual);
m_AV = mean(predictedAV);
v = var(actual);
v_AV = var(predictedAV);

ccc_AV = 2 * q_AV * v * v_AV / ( v^2 + v_AV ^ 2 + ( m - m_AV ) ^ 2 );

q = q_AV
ccc = ccc_AV
    
mse = mean((actual-predictedAV).^2)

% mse_av = 0;
% for i = 1:length(valence_predicted)
%     mse_av = mse_av + abs(valence_predicted(i)-testData.y(i))^2;
% end
% mse_av
plot(valence_predicted)
hold on
plot(testData.y,'r')

predicted = predictedAV;
save('audio.mat','actual','predicted')

rmpath('svr_lbptop_support_files');

