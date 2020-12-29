tic
addpath('svr_lbptop_support_files');

disp('Preparing Train Data')
fTrainAV = fopen('za_Gabor_Train.txt','r');

c = 0;
tlineAV = fgetl(fTrainAV);

%Getting Train Features
while ischar(tlineAV)
	c = c + 1;
    %tlineAV = '%GaborEnergy_Features/P23/gaborFeatureFrame280.mat 0.11675 0.13674 0.18649 0.072348';
    fileInfoAV = strsplit(['../../g_Extract_Other_Features/' tlineAV]);
    matfilenameAV = strjoin(fileInfoAV(1));
    ratingAV = str2double(fileInfoAV(2)) ;
    
    fAV = load(matfilenameAV);
    featureAV = fAV.ge;
    actAV = ratingAV;
    
    trainDataX(c,:) = featureAV;
    trainDatay(c) = actAV;
    
    tlineAV = fgetl(fTrainAV);
end
fclose(fTrainAV);

disp('Preparing Model')
size(trainDataX)
size(trainDatay')
%Obtaining the model
model = giveSVRmodel(double(trainDataX), double(trainDatay'));

disp('Preparing Test Data')
fTestAV = fopen('zb_Gabor_Test.txt'); 

c = 0;
tlineAV = fgetl(fTestAV); %tlineV = fgetl(fTestV);

%Getting Test Features
while ischar(tlineAV)
	c = c + 1;
    fileInfoAV = strsplit(['../../g_Extract_Other_Features/' tlineAV]);
    matfilenameAV = strjoin(fileInfoAV(1));
    ratingAV = str2double(fileInfoAV(2)); 
    
    fAV = load(matfilenameAV);
    featureAV = fAV.ge;
    actAV = ratingAV;    

    testDataX(c,:) = featureAV;
    testDatay(c) = actAV;
    
    tlineAV = fgetl(fTestAV);
end
fclose(fTestAV);



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

SMOOTH_RESULT_GABOR = [mse.^0.5 q ccc]

predicted = predictedAV;
save('gabor.mat','actual','predicted')

%RAW CALCULATION
actual = testData.y; predictedAV = valence_predictedRAW;

q_AV = corrcoef(actual,predictedAV); q_AV = q_AV(1,2);
m = mean(actual); m_AV = mean(predictedAV);
v = var(actual); v_AV = var(predictedAV);

ccc_AV = 2 * q_AV * v * v_AV / ( v^2 + v_AV ^ 2 + ( m - m_AV ) ^ 2 );
mse = mean((actual-predictedAV).^2); q = q_AV; ccc = ccc_AV;
%plot(valence_predicted); hold on; plot(testData.y,'r');

RAW_RESULT_GABOR = [mse.^0.5 q ccc]

predicted = predictedAV;
save('gaborraw.mat','actual','predicted')

rmpath('svr_lbptop_support_files');

