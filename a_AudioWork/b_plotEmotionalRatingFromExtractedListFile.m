clear all;
close all;
clc;
%hold all
videoNum = [1]

fidA = fopen(strcat('ExtractedAudioSegments/List_P',num2str(videoNum),'.txt'));

i = 0;
tlineA = fgetl(fidA);

while ischar(tlineA) %tline example = 'P31/Audio3240.mat 0.0077 -0.34' <audiosegname><space><val_rating><space><aro_rating> 'index start at 0
    i = i + 1;
    CA = strsplit(tlineA,' ');
    valence(i) = str2double(strjoin(CA(1)));
    arousal(i) = str2double(strjoin(CA(2)));
    frameNum(i) = i;
    tlineA = fgetl(fidA);
end
i
fclose(fidA);

plot(1:i,valence,'b')
grid on
hold on
plot(1:i,arousal,'r')
