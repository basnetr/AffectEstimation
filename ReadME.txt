Directories begining with prefixes a, b, c and d perform preprocessing on the dataset in folder 'database'
Directory with prefix e contains files for implementation of CNNs in Caffe and extraction of features.
Directory with prefix f extracts handcrafted features from input data.
Directory with prefix g used handcrafted features and features from CNN to predict arousal and valence scores and compare the performance.

e: For CNN Training and Testing: The prototxt file contains the architecture and setting parameters for training. Training is run by using startTrain.sh For prediction and output generation 'z_PredictionAudio.ipynb' is used.

f: For Extracting Features: extract_LBPTOP_main.m extract_MFCC_main.m extract_GaborEnergy_main.m

extract_LBPTOP_main.m: Features are extracted from a list of images [28x28], a list needs to be created containing names of all image files. From the list the feature data is stored as mat files in LBPTOP_Features/PXX folder and a file containing list of the mat filenames is also generated.

extract_MFCC_main.m This also takes a text file containing all audio input segmensts from tha audio text file containing names of all audio files, and stores the extracted features as mat files and stores them in FCC_Features/PXX folder and a file containing list of the mat filenames is also generated.

extract_GaborEnergy_main.m This is same as LBPTOP_main.m Output features are stored in GaborEnergy_Features/PXX folder and a file containing list of the mat filenames is also generated.

Training testing SVR: We separate the data as training and testing data.

g: Mutual Information is extracted from training data using 'test_Index_Extract_v.m' for video features and 'test_Index_Extract.m' for audio features. Obtained indexes are saved as 'mRMRindexVideo.mat' and 'mRMRindex.mat'

xa_trainTestSVR_AV_main.m SVR Training and Testing is done using this file by concatenating different features and output values MSE,CC, CCC etc are calculated.
