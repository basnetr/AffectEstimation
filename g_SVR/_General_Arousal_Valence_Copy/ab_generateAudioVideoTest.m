function junk = ab_generateAudioVideoTest(originalListTxtFile, selectedIndexArray)

	fidav = fopen(originalListTxtFile,'r');
	i = 1;
	tline{i} = fgets(fidav); %gets keeps newline too
	while ischar(tline{i})
	    i = i + 1;  
	    tline{i} = fgets(fidav); %gets newline too
	end
	fclose(fidav);

	fidavt = fopen('zb_AudioVideo_Test.txt','w');
	for x = selectedIndexArray
	    fprintf(fidavt,tline{x});
	end
	fclose(fidavt);
	disp('Generated Test List: zb_AudioVideo_Test.txt')

end

