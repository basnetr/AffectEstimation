%Reads Full Audio File, CSV File, Valance Rating File, Arousal Rating File and Then Extracts Audio Segments
%Edit: Reads Arousal Too
%Outputs Extracted Audio(name is the ending time in ms), Very Raw All Possible Audio Segments in Voiced Region
%And a List File List_Num.txt <audiosegname><space><val_rating><space><aro_rating>
%Rater 2 Ratings of Valence and Arousal Taken
%Total Time: Approximately 40 secs per subject
clc
clear all
close all

for videoNum = [1]
    subject = 'User'; %'User'; %'Operator'
    tic
    audioWordlevelTranscript = ['../database/' num2str(videoNum) '/wordLevelTranscript']; %Audio Voice Transcript File
    audioFile = ['../database/' num2str(videoNum) '/' subject '.wav'];
    valenceFilename = ['../database/' num2str(videoNum) '/ValenceR2.txt'];
    arousalFilename = ['../database/' num2str(videoNum) '/ArousalR2.txt'];

    outLocAudio = ['ExtractedAudioSegments/P' num2str(videoNum)];
    mkdir(outLocAudio)
    outListFile = ['ExtractedAudioSegments/List_P' num2str(videoNum) '.txt'];

    [vframe_sec, VR2] = getSemaineEmotionalRating(valenceFilename);
    [frame_sec, AR2] = getSemaineEmotionalRating(arousalFilename);

    frame_sec = round((frame_sec.*100))./100; %Just Rounding to two decimal places just in case

    [starttime, endtime] = getStartAndEndTimeSemaine(audioWordlevelTranscript); %Gets Array of Voiced Start and End Time In Seconds, after making(start and end time only) multiples of 0.04
    %Voiced Regions are not yet segmented into small pieces of desired length
    [x,Fs] = audioread(audioFile); %Reading the Audio File

    fileID = fopen(outListFile,'w'); %overwrites %In this file we are writing the name of extracted audio segments acc to time in ms and valence ratings

    segmentLength = 0.06; %in seconds
    for i = 1:length(endtime)-1 %Total Number of Voiced Regions

            for k = starttime(i)+0.08:0.04:endtime(i) %k is like the tend for each 40ms frame we want to obtain
                %+0.08 depending on the segment length we want so that the first frame wont start from like negative time, must be multiple of 0.04 beacuse we want to extract frame at every 0.04s 

                tend = round((k*100))/100; %Rounding to two decimals
                tstart = round(((tend - segmentLength)*100))/100; %60ms frame 20 ms overlap at 40ms each

                index = find(frame_sec==tend,1); %Index For Rating

                %crop audio from k-0.04 to k+0.04 and rating will be R2(index)

                [samples_temp, frameRate] = getAudio((tstart*1000)+1, tend*1000, x, Fs); %gets audio between two ms time period

                %Downsampling from 48000 to 44100
                samples = resample(samples_temp,44100,48000); %New  Fs = 44100;
                %--------------------------------

                outputFilename = [outLocAudio '/Audio' int2str(tend*1000) '.mat']; %Saves filename as MidPoint Time in ms
                save(outputFilename,'samples'); %Write the audio file 
                fprintf(fileID,['P' num2str(videoNum) '/Audio' int2str(tend*1000) '.mat',' ', num2str(VR2(index)),' ', num2str(AR2(index)),'\n']); 
            end    
    end
    fclose(fileID);
    toc
end