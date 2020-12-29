clear all;
close all;
clc;
%hold all
videoNum = [1]

fidA = fopen(strcat('../database/',num2str(videoNum),'/ArousalR2.txt'));
fidV = fopen(strcat('../database/',num2str(videoNum),'/ValenceR2.txt'));

i = 0;
tlineA = fgetl(fidA);
tlineV = fgetl(fidV);

while ischar(tlineA) %tline example = 'ExtractedRawAudio/P16/Audio1000.mat 0 0'
    i = i + 1;
    CA = strsplit(tlineA,' ');
    CV = strsplit(tlineV,' ');

    valence(i) = str2double(strjoin(CV(2)));
    arousal(i) = str2double(strjoin(CA(2)));
    frameNum(i) = str2double(strjoin(CA(1)));
    
    tlineA = fgetl(fidA);
	tlineV = fgetl(fidV);
end
i
fclose(fidA);
fclose(fidV);

plot(1:i,valence,'b')
grid on
hold on
plot(1:i,arousal,'r')
