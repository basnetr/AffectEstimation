function [starttime, endtime] = getStartAndEndTimeSemaine(wordLevelTranscript)
    fid = fopen(wordLevelTranscript);
    i = 1;
    tline = fgetl(fid);
    while ischar(tline)
        if strcmp(tline,'.') 
             C = strsplit(ptline,' ');
             mendtime(i) = str2double(strjoin(C(2)));
             i = i + 1;
        elseif strcmp(tline(1:2),'--') 
             tline = fgetl(fid);
             C = strsplit(tline,' ');
             mstarttime(i) = str2double(strjoin(C(1)));
        end
        ptline = tline;
        tline = fgetl(fid);
    end
    starttime = floor(mstarttime./40).*40./1000;   %In Seconds
    endtime = ceil(mendtime./40).*40./1000;        %In Seconds
    %num2str([mstarttime' starttime' mendtime' endtime'])
    fclose(fid);
end