
	fidav = fopen('zb_AudioVideo_Test.txt','r');
	fidv = fopen('zb_Video_Test.txt','w');
	fidlbp = fopen('zb_LBP_Test.txt','w');
	fidmfcc = fopen('zb_MFCC_Test.txt','w');
	fida = fopen('zb_Audio_Test.txt','w');
	fidgabor = fopen('zb_Gabor_Test.txt','w');

	tline = fgets(fidav); %gets keeps newline too
	while ischar(tline)
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
	disp('Generated: zb_Video_Test.txt & zb_LBP_Test.txt & zb_MFCC_Test.txt & zb_Audio_Test.txt & zb_Gabor_Test.txt')