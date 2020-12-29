clc
clear all
close all
format short

originalListTxtFile = 'ListAudioVideo_1_Arousal.txt';

%generating Train List - AV
selectedIndexArray = [1:1];

save('selectedIndexArray.mat','selectedIndexArray');

aa_generateAudioVideoTrain(originalListTxtFile, selectedIndexArray)
%Generates za_AudioVideo_Train.txt - Training Data Audio Video

selectedIndexArray = [1:1];

ab_generateAudioVideoTest(originalListTxtFile, selectedIndexArray)
%generating zb_AudioVideo_Test.txt - Testing Data Audio Video

ac_generateTrainFiles_lbp_video_mfcc_audio_mfcclbp_gabor()
%generating Train List - LBP - Video - MFCC - Audio - (MFCC+LBP) - GaborEnergy

ad_generateTestFiles_lbp_video_mfcc_audio_mfcclbp_gabor()
%generating Test List - LBP - Video - MFCC - Audio - (MFCC+LBP) - GaborEnergy


clc; clear all; close all; xa_trainTestSVR_AV_main()
%Training and Predicting - Audio Video 

clc; clear all; close all; xb_trainTestSVR_V_main()
%Training and Predicting - Video
 
clc; clear all; close all; xc_trainTestSVR_LBPTOP_main()
%Training and Predicting - LBPTOP

clc; clear all; close all; xd_trainTestSVR_MFCC_main()
%Training and Predicting - MFCC

%clc; clear all; close all; xe_trainTestSVR_A_main() 
%Training and Predicting - A

clc; clear all; close all; xf_trainTestSVR_MFCCLBP_main()
%Training and Predicting - MFCC+LBP
 
clc; clear all; close all; xg_trainTestSVR_MFCCLBP_DD_main()
%Training and Predicting - MFCC(D,DD)+LBP

clc; clear all; close all; xh_trainTestSVR_GaborEnergy_main()
%Training and Predicting - GaborEnergy
 
%Plotting all Predictions
clc; clear all; close all; load('selectedIndexArray.mat'); ya_plotAll()
