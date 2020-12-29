function [time, Rating] = getSemaineEmotionalRating(emotionalFilename) %Maybe Valence CSV file or Arousal
  
    fid = fopen(emotionalFilename);
    tline = fgetl(fid);
    i = 1;
	while ischar(tline)
	    C = strsplit(tline,' ');
		time(i) = str2double(strjoin(C(1)));
		Rating(i) = str2double(strjoin(C(2)));
		i = i + 1;
	    tline = fgetl(fid);
	end
	fclose(fid);
    
end