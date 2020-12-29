tic
addpath('svr_lbptop_support_files');

disp('Preparing Train Data')
fTrainAV = fopen('za_LBP_Train.txt','r'); %fTrainV = fopen('FinalVideoTrain.txt'); 

c = 0;
tlineAV = fgetl(fTrainAV); %tlineV = fgetl(fTrainV);

%Getting Train Features
while ischar(tlineAV)
	c = c + 1;
    %tlineAV = 'LBPTOP_Features/P64/lbpFeatureFrame26600.mat 0.11675 0.13674 0.18649 0.072348';
    fileInfoAV = strsplit(['../../g_Extract_Other_Features/' tlineAV]);
    matfilenameAV = strjoin(fileInfoAV(1));
    ratingAV = str2double(fileInfoAV(2)) ;
    
%     fileInfoV = strsplit(tlineV);
%     matfilenameV = strjoin(fileInfoV(1));
%     ratingV = str2double(fileInfoV(2)); 
    
    fAV = load(matfilenameAV);
    %prdAV = fAV.predicted_value;
    featureAV = [fAV.XT fAV.XY fAV.YT];
    actAV = ratingAV;
    
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
fTestAV = fopen('zb_LBP_Test.txt'); %fTestV = fopen('FinalVideoTest.txt');

c = 0;
tlineAV = fgetl(fTestAV); %tlineV = fgetl(fTestV);

%Getting Test Features
while ischar(tlineAV)
	c = c + 1;
    fileInfoAV = strsplit(['../../g_Extract_Other_Features/' tlineAV]);
    matfilenameAV = strjoin(fileInfoAV(1));
    ratingAV = str2double(fileInfoAV(2));
    
%     fileInfoV = strsplit(tlineV);
%     matfilenameV = strjoin(fileInfoV(1));
%     ratingV = str2double(fileInfoV(2)); 
    
    fAV = load(matfilenameAV);
    %prdAV = fAV.predicted_value;
    featureAV = [fAV.XT fAV.XY fAV.YT];
    actAV = ratingAV;
    
%     fAV = load(matfilenameAV);
%     prdAV = fAV.predicted_value;
%     featureAV = fAV.feature_array;
%     actAV = fAV.actual_value;
    
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
valence_predictedRAW = valence_predicted;
valence_predicted = smooth(valence_predicted,smooth_degree,'rloess');

%SMOOTH CALCULATION
actual = testData.y; predictedAV = valence_predicted;

q_AV = corrcoef(actual,predictedAV); q_AV = q_AV(1,2);
m = mean(actual); m_AV = mean(predictedAV);
v = var(actual); v_AV = var(predictedAV);

ccc_AV = 2 * q_AV * v * v_AV / ( v^2 + v_AV ^ 2 + ( m - m_AV ) ^ 2 );
mse = mean((actual-predictedAV).^2); q = q_AV; ccc = ccc_AV;
plot(valence_predicted); hold on; plot(testData.y,'r');

SMOOTH_RESULT_LBP = [mse.^0.5 q ccc]

predicted = predictedAV;
save('lbp.mat','actual','predicted')

%RAW CALCULATION
actual = testData.y; predictedAV = valence_predictedRAW;

q_AV = corrcoef(actual,predictedAV); q_AV = q_AV(1,2);
m = mean(actual); m_AV = mean(predictedAV);
v = var(actual); v_AV = var(predictedAV);

ccc_AV = 2 * q_AV * v * v_AV / ( v^2 + v_AV ^ 2 + ( m - m_AV ) ^ 2 );
mse = mean((actual-predictedAV).^2); q = q_AV; ccc = ccc_AV;
%plot(valence_predicted); hold on; plot(testData.y,'r');

RAW_RESULT_LBP = [mse.^0.5 q ccc]

predicted = predictedAV;
save('lbpraw.mat','actual','predicted')

rmpath('svr_lbptop_support_files');

