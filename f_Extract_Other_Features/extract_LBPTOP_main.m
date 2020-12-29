clc
clear all
close all

addpath('extract_lbptop_support_files');
%For Vid31: 345 secs = 6 mins to 980 secs
disp(datetime('now'));
for videoNum = [1]
    tic
    height = 128;
    width = 128;

    %Initializations for LBPTOP %We are not doing VLBP we are doing LBPTOP
    FxRadius = 1; %Radii Parameter along X axis
    FyRadius = 1; %Radii Parameter along Y axis
    TInterval = 2; %Radii Parameter along T axis
    TimeLength = 2; %Bordering Parts in time which wont be computed for features
    BorderLength = 1; %Bordering Parts in space which wont be computed for features
    bBilinearInterpolation = 1; %Use Bilinear Interpolation (0,1)
    Bincount = 59; %Only for Uniform Pattern, 8 Neighbors
    NeighborPoints = [8 8 8]; % XY, XT, and YT planes, respectively
    %Uniform patterns for neighboring points with 8 and Bincount = 59
    U8File = importdata('UniformLBP8.txt');
    BinNum = U8File(1, 1);
    nDim = U8File(1, 2); %dimensionality of uniform patterns
    Code = U8File(2 : end, :);
    clear U8File;

    outputLoc = ['LBPTOP_Features/P' num2str(videoNum)];
    mkdir(outputLoc);

    fidFrameNum = fopen(strcat('List_',num2str(videoNum),'_Video.txt')); %Reading Frame List File
    i = 0;

    for k = 1:5
        tline{k} = fgetl(fidFrameNum);
    end
    while ischar(tline{5})
        
        VolData = zeros(height, width, 5);
        for k = 1:5
            C = strsplit(tline{k},' ');
            videoFrameLoc = strjoin(C(1)); %'Video/P31/Frame1000.jpg'
            videoFrame = imread(videoFrameLoc); %Reads Grayscale Automatically
            VolData(:, :, k) = videoFrame;
            if k == 3
                C = strsplit(strjoin(C(1)),'/');
                C = strrep(strrep(strjoin(C(3)),'Frame',''),'.jpg','');
                %frameNum = str2num(C);           
                featureFilename = [outputLoc '/lbpFeatureFrame' C '.mat'];
            end 
        end

        
        Histogram = LBPTOP(VolData, FxRadius, FyRadius, TInterval, NeighborPoints, TimeLength, BorderLength, bBilinearInterpolation, Bincount, Code);
        %Histogram = Histogram';
        XY = Histogram(1,:); %Column Vector 59x1
        XT = Histogram(2,:); 
        YT = Histogram(3,:);
        %size(XY)
        %size(XT)
        %size(YT)
        save(featureFilename,'XY','XT','YT');
        %featureFilename
        tline{1} = tline{2};
        tline{2} = tline{3};
        tline{3} = tline{4};
        tline{4} = tline{5};
        tline{5} = fgetl(fidFrameNum);
    end
    fclose(fidFrameNum);
    toc
end
rmpath('extract_lbptop_support_files');