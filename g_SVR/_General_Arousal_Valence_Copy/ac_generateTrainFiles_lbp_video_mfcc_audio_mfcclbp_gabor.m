
	fidav = fopen('za_AudioVideo_Train.txt','r');

	fidv = fopen('za_Video_Train.txt','w');
	fidlbp = fopen('za_LBP_Train.txt','w');
	fidmfcc = fopen('za_MFCC_Train.txt','w');
	fida = fopen('za_Audio_Train.txt','w');
	fidgabor = fopen('za_Gabor_Train.txt','w'); %GaborEnergy_Features/P23/gaborFeatureFrame280.mat

	tline = fgets(fidav); %gets keeps newline too
	while ischar(tline) %AudioVideoFeatures[ValenceOrArousal]/P23/AudioVideo2720Feature.mat 0.23151 0.18404 0.16969 0.068476
		
		tlinev = strrep(tline,'AudioVideo','Video');
		tlinea = strrep(tline,'AudioVideo','Audio');

		tline = strrep(tline,'Arousal',''); %Cause whatever Arousal or Valence Features of LBP, MFCC, Gabor are same
		tline = strrep(tline,'Valence','');

	    tlinelbp = strrep(tline,'AudioVideoFeatures','LBPTOP_Features');
	    tlinelbp = strrep(tlinelbp,'AudioVideo','lbpFeatureFrame');
	    tlinelbp = strrep(tlinelbp,'Feature.mat','.mat');

	    tlinemfcc = strrep(tline,'AudioVideoFeatures','MFCC_Features'); %MFCC_Features/P23/MFCCFeatureAudio280.mat
	    tlinemfcc = strrep(tlinemfcc,'AudioVideo','MFCCFeatureAudio');
	    tlinemfcc = strrep(tlinemfcc,'Feature.mat','.mat');

	    tlinegabor = strrep(tline,'AudioVideoFeatures','GaborEnergy_Features'); %GaborEnergy_Features/P23/gaborFeatureFrame280.mat
	    tlinegabor = strrep(tlinegabor,'AudioVideo','gaborFeatureFrame');
	    tlinegabor = strrep(tlinegabor,'Feature.mat','.mat');

	    fprintf(fidv,tlinev);
	    fprintf(fidlbp,tlinelbp);
	    fprintf(fidmfcc,tlinemfcc);
	    fprintf(fida,tlinea);
	    fprintf(fidgabor,tlinegabor);

	    tline = fgets(fidav); %gets newline too
	end
	
	fclose(fidav);
	fclose(fidv);
	fclose(fidlbp);
	fclose(fidmfcc);
	fclose(fida);
	fclose(fidgabor);
	disp('Generated: za_Video_Train.txt & za_LBP_Train.txt & za_MFCC_Train.txt & za_Audio_Train.txt & za_Gabor_Train.txt')


