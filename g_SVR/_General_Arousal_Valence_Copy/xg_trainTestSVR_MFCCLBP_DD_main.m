clc
clear all
tic
addpath('svr_lbptop_support_files');

disp('Preparing Train Data')
fTrainM = fopen('za_MFCC_Train.txt','r'); fTrainL = fopen('za_LBP_Train.txt','r'); 

c = 0;
tlineM = fgetl(fTrainM); tlineL = fgetl(fTrainL);

%Getting Train Features
while ischar(tlineM)
	c = c + 1;
    %tlineM = '%MFCC_Features/P23/MFCCFeatureAudio280.mat 0.11675 0.13674 0.18649 0.072348';
    fileInfoM = strsplit(['../../g_Extract_Other_Features/' tlineM]);
    matfilenameM = strjoin(fileInfoM(1));
    ratingM = str2double(fileInfoM(2));
    
    fM = load(matfilenameM);
    featureM = fM.mfcc';
    actM = ratingM;
    
    %-------------------LBP----------------------------------
    fileInfoL = strsplit(['../../g_Extract_Other_Features/' tlineL]);
    matfilenameL = strjoin(fileInfoL(1));
    ratingL = str2double(fileInfoL(2)) ;
    
    fL = load(matfilenameL);
    featureL = [fL.XT fL.XY fL.YT];
    actL = ratingL;
    
    featureD = getDelta(featureM);
    featureDD= getDelta(featureD);
	featureML = [featureM, featureD, featureDD, featureL];

    trainDataX(c,:) = featureML;
    trainDatay(c) = actM; %or actA same 
    
    tlineM = fgetl(fTrainM); tlineL = fgetl(fTrainL);
end
fclose(fTrainM); fclose(fTrainL);


disp('Preparing Model')
size(trainDataX)
size(trainDatay')
%Obtaining the model
model = giveSVRmodel(double(trainDataX), double(trainDatay'));

disp('Preparing Test Data')
fTestM = fopen('zb_MFCC_Test.txt'); fTestL = fopen('zb_LBP_Test.txt');

c = 0;
tlineM = fgetl(fTestM); tlineL = fgetl(fTestL);

%Getting Test Features
while ischar(tlineM)  
    c = c + 1;
    %tlineM = '%MFCC_Features/P23/MFCCFeatureAudio280.mat 0.11675 0.13674 0.18649 0.072348';
    fileInfoM = strsplit(['../../g_Extract_Other_Features/' tlineM]);
    matfilenameM = strjoin(fileInfoM(1));
    ratingM = str2double(fileInfoM(2));
    
    fM = load(matfilenameM);
    featureM = fM.mfcc';
    featureD = getDelta(featureM);
    featureDD= getDelta(featureD);
    actM = ratingM;

    
    %-------------------LBP----------------------------------
    fileInfoL = strsplit(['../../g_Extract_Other_Features/' tlineL]);
    matfilenameL = strjoin(fileInfoL(1));
    ratingL = str2double(fileInfoL(2)) ;
    
    fL = load(matfilenameL);
    featureL = [fL.XT fL.XY fL.YT];
    actL = ratingL;
    
	featureML = [featureM, featureD, featureDD, featureL];
    
    testDataX(c,:) = featureML;
    testDatay(c) = actM; %or actA same 
    
    tlineM = fgetl(fTestM); tlineL = fgetl(fTestL);
end
fclose(fTestM); fclose(fTestL);

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

SMOOTH_RESULT_MFCCLBPDD = [mse.^0.5 q ccc]

predicted = predictedAV;
save('mfccddlbp.mat','actual','predicted')

%RAW CALCULATION
actual = testData.y; predictedAV = valence_predictedRAW;

q_AV = corrcoef(actual,predictedAV); q_AV = q_AV(1,2);
m = mean(actual); m_AV = mean(predictedAV);
v = var(actual); v_AV = var(predictedAV);

ccc_AV = 2 * q_AV * v * v_AV / ( v^2 + v_AV ^ 2 + ( m - m_AV ) ^ 2 );
mse = mean((actual-predictedAV).^2); q = q_AV; ccc = ccc_AV;
%plot(valence_predicted); hold on; plot(testData.y,'r');

RAW_RESULT_MFCCLBPDD = [mse.^0.5 q ccc]

predicted = predictedAV;
save('mfccddlbpraw.mat','actual','predicted')

rmpath('svr_lbptop_support_files');

