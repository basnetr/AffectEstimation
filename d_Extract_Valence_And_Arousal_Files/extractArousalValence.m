clc
clear all
close all

%Video Arousal
for videoNum = [1]
    tic
    inputFile = ['List_' num2str(videoNum) '_Video.txt'];
    fidin = fopen(inputFile,'r');
    outputFile = ['List_' num2str(videoNum) '_Video_Arousal.txt'];
    fidout = fopen(outputFile,'w'); %overwrites

    tline = fgetl(fidin); % Video/P31/Frame3240.jpg 0.0077 -0.34
    while ischar(tline)
        C = strsplit(tline,' ');        
        fprintf(fidout,[strjoin(C(1)),' ', strjoin(C(3)),'\n']);  
        tline = fgetl(fidin);
    end 
    fclose(fidout);
    fclose(fidin);
    toc
end

clear all
close all

%Video Valence
for videoNum = [1]
    tic
    inputFile = ['List_' num2str(videoNum) '_Video.txt'];
    fidin = fopen(inputFile,'r');
    outputFile = ['List_' num2str(videoNum) '_Video_Valence.txt'];
    fidout = fopen(outputFile,'w'); %overwrites

    tline = fgetl(fidin); % Video/P31/Frame3240.jpg 0.0077 -0.34
    while ischar(tline)
        C = strsplit(tline,' '); 
        fprintf(fidout,[strjoin(C(1)),' ', strjoin(C(2)),'\n']);  
        tline = fgetl(fidin);
    end 
    fclose(fidout);
    fclose(fidin);
    toc
end


%Audio Arousal
clear all
close all
for videoNum = [1]
    tic
    inputFile = ['List_' num2str(videoNum) '_Audio.txt'];
    fidin = fopen(inputFile,'r');
    outputFile = ['List_' num2str(videoNum) '_Audio_Arousal.txt'];
    fidout = fopen(outputFile,'w'); %overwrites

    tline = fgetl(fidin);
    while ischar(tline)
        C = strsplit(tline,' ');        
        fprintf(fidout,[strjoin(C(1)),' ', strjoin(C(3)),'\n']);  
        tline = fgetl(fidin);
    end 
    fclose(fidout);
    fclose(fidin);
    toc
end

%Audio Valence
clear all
close all
for videoNum = [1]
    tic
    inputFile = ['List_' num2str(videoNum) '_Audio.txt'];
    fidin = fopen(inputFile,'r');
    outputFile = ['List_' num2str(videoNum) '_Audio_Valence.txt'];
    fidout = fopen(outputFile,'w'); %overwrites

    tline = fgetl(fidin);
    while ischar(tline)
        C = strsplit(tline,' '); 
        fprintf(fidout,[strjoin(C(1)),' ', strjoin(C(2)),'\n']);  
        tline = fgetl(fidin);
    end 
    fclose(fidout);
    fclose(fidin);
    toc
end
