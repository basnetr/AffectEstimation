clc
clear all
close all

addpath('Gabor_Image_Features_Support_Files');

height = 128;
width = 128;
disp(datetime('now'));
%For 31, With Comments Time: 294 secs = 5mins, With Comments Disabled: 245 secs
for videoNum = [1]
	tic
	outputLoc = ['GaborEnergy_Features/P' num2str(videoNum)];
	mkdir(outputLoc);

	fid = fopen(strcat('List_',num2str(videoNum),'_Video.txt')); %Reading Frame List File
	tline = fgetl(fid);
	while ischar(tline)
	    C = strsplit(tline,' ');
	    videoFrameLoc = strjoin(C(1)); %'Video/P16/Frame1000.jpg'
	    videoFrame = imread(videoFrameLoc); %Reads Grayscale Automatically
	    [gaborSquareEnergy, gaborMeanAmplitude ]= phasesym(videoFrame);
	    ge = gaborSquareEnergy;        

	    C = strsplit(strjoin(C(1)),'/');
	    C = strrep(strrep(strjoin(C(3)),'Frame',''),'.jpg','');
	    featureFilename = [outputLoc '/gaborFeatureFrame' C '.mat'];
	    save(featureFilename,'ge');
	    tline = fgetl(fid);
	end 
	fclose(fid);
	toc
end
rmpath('Gabor_Image_Features_Support_Files');