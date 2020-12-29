function junk = aa_generateAudioVideoTrain(originalListTxtFile, selectedIndexArray)

	fidav = fopen(originalListTxtFile,'r');
	i = 1;
	tline{i} = fgets(fidav); %gets keeps newline too
	while ischar(tline{i})
	    i = i + 1;  
	    tline{i} = fgets(fidav); %gets newline too
	end
	fclose(fidav);

	fidavt = fopen('za_AudioVideo_Train.txt','w');
	for x = selectedIndexArray
	    fprintf(fidavt,tline{x});
	end
	fclose(fidavt);
	disp('Generated Train List: za_AudioVideo_Train.txt')

end

