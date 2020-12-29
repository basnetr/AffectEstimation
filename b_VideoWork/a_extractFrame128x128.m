clear all
close all
%Total Time Per Video: 6531.89
clc
tic
warning ('off','all');
format long

SIZE = 128;
faceDetector = vision.CascadeObjectDetector();

%For SEMAINE video and ratings must be saved and moved to directory just after number and renamed as User or Operator and ValenceR2 and ArousalR2

for videoNum = [1]

    subject = 'User'; %'User'; %'Operator'
    
    inputVideoLoc = ['../database/' num2str(videoNum) '/' subject '.avi'];
    outputFrameLoc = ['ExtractedVideoFrames/P' num2str(videoNum)]; mkdir(outputFrameLoc)

    valenceFilename = ['../database/' num2str(videoNum) '/ValenceR2.txt'];
    arousalFilename = ['../database/' num2str(videoNum) '/ArousalR2.txt'];
    
    [vframe_sec, VR2] = getSemaineEmotionalRating(valenceFilename);
    [frame_sec, AR2] = getSemaineEmotionalRating(arousalFilename);

    %frame_sec = round((frame_sec*100))/100; %Rounding to two decimals

    %Preparing to read frame
    videoFileReader = vision.VideoFileReader(inputVideoLoc);

    disp(['Total Rating Count of ' num2str(videoNum) ' = ' num2str(length(frame_sec))]);
    outputFile = ['ExtractedVideoFrames/List_' num2str(videoNum) '_Video.txt'];
    fid = fopen(outputFile,'w'); %overwrites

    for i = 1:length(frame_sec)    
            videoFrame = step(videoFileReader);                 %Reading Frame
            %size(videoFrame)
        
            bbox = step(faceDetector, videoFrame);              %Detecting Face
            nbbox = extendBox(bbox);                            %Extending face a bit

            if ~(isempty(nbbox))                                %If frame/face detected
                videoFrame = imcrop(videoFrame,nbbox);          %Cropping Face
                videoFrame = imresize(videoFrame,[SIZE SIZE]);  %Resizing Image
                videoFrame = rgb2gray(videoFrame);              %Converting to grayscale
                outFrameName = sprintf([outputFrameLoc '/Frame%s.jpg'],num2str(frame_sec(i)*1000));
                imwrite(videoFrame,fullfile(outFrameName)); %Frame Written
                fprintf(fid,[outFrameName,' ', num2str(VR2(i)),' ', num2str(AR2(i)),'\n']);  
            else
                disp(['Couldnt detect face for : ' 'Video P ' num2str(videoNum) ', Frame ' num2str(i)]);
            end 
    end
    fclose(fid);
    toc
end