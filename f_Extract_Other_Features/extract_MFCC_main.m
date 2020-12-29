clc
clear all
close all
sr =  44100; %Sampling Rate
%For 31: 21 secs sometimes 128
disp(datetime('now'));
for videoNum = [1];
    tic
    outputLoc = ['MFCC_Features/P' num2str(videoNum)];
    mkdir(outputLoc);

    fid = fopen(strcat('List_',num2str(videoNum),'_Audio.txt')); %Reading Frame List File
    tline = fgetl(fid);
    while ischar(tline)
            C = strsplit(tline,' ');
            audioLoc = strjoin(C(1)); %'Audio/P16/Audio1000.mat'
            aud = load(audioLoc);
            d = aud.samples;
            [mfcc,aspc] = melfcc(d*3.3752, sr, 'maxfreq', 8000, 'numcep', 20, 'nbands', 22, 'fbtype', 'fcmel', ...
                'dcttype', 1, 'usecmp', 1, 'wintime', 0.06, 'hoptime', 0.06, 'preemph', 0, 'dither', 1);
            
            C = strsplit(audioLoc,'/');
            C = strrep(strrep(strjoin(C(3)),'Audio',''),'.mat','');        
            featureFilename = [outputLoc '/MFCCFeatureAudio' C '.mat'];
            %'MFCC_Features/P23/MFCCFeatureAudio1000.mat'
            save(featureFilename,'mfcc');
            tline = fgetl(fid);
    end
    fclose(fid);
    toc
end