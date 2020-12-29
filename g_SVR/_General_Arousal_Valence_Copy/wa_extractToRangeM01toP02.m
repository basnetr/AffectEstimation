function junk = wa_extractToRangeM01toP02(originalListTxtFile)

	%originalListTxtFile = 'ListAudioVideo_64.txt'

	fidav = fopen(originalListTxtFile,'r');

	k = 0;
	tline = fgets(fidav); %gets keeps newline too
	while ischar(tline)
		%tline = AudioVideoFeatures/P23/AudioVideo299920Feature.mat 0.062454 0.25048 0.29004 0.068038

		C = strsplit(tline,' ');
		CX = str2double(strjoin(C(2)));
    	if CX => -0.1 && CX <= 0.2
    		k = k + 1;
    		tlineN{k} = tline;
    	end

	    tline = fgets(fidav); %gets newline too
	end
	fclose(fidav);

	fidavt = fopen(['new' originalListTxtFile],'w');
	for x = 1:k
	    fprintf(fidavt,tlineN{x});
	end
	fclose(fidavt);
	disp(['Generated Train List: new' originalListTxtFile])

end