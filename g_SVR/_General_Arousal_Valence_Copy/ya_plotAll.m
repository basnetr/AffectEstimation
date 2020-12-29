clc; clear all; close all;
%For Colors http://shirt-ediss.me/matlab-octave-more-colours/
plotav = 'y'; plotv = 'y'; plotlbp = 'n'; plotmfcc = 'n'; plotaud='n'; plotmfcclbp = 'n'; plotmfccddlbp = 'y'; plotgabor = 'y';
%plotav = 'n'; plotv = 'n'; plotlbp = 'n'; plotmfcc = 'n'; plotaud='n'; plotmfcclbp = 'n'; plotmfccddlbp = 'n'; plotgabor = 'n';

load('selectedIndexArray.mat')
av = load('audiovideo.mat');
v = load('video.mat');
lbp = load('lbp.mat');
mfcc = load('mfcc.mat');
%aud = load('audio.mat');
mfcclbp = load('mfcclbp.mat');
mfccddlbp = load('mfccddlbp.mat');
gabor = load('gabor.mat');

x = 1:length(av.actual);

intv = 15; i = 1;

p(i) = plot(x,av.actual,'r','LineWidth', 2); %Actual Plot
legend_text{i} = 'Ground Truth Valence Rating';

hold on
plot(selectedIndexArray, av.actual(selectedIndexArray),'*r'); %Training Portion Plot

if plotav == 'y'
	plot(x,av.predicted,'b','LineWidth', 2); %Audio Video Prediction Plot
	i = i + 1;
	p(i) = plot(x(1:intv:end), av.predicted(1:intv:end),'*','color','b','LineWidth', 2,'MarkerSize',10);
    legend_text{i} = 'CNN Features - AudioVisual';
end

if plotv == 'y'
	darkgreen = [0 0.8 0];
	plot(x,v.predicted,'color',darkgreen,'LineWidth', 2); %Video Plot
	i = i + 1;
	p(i) = plot(x(4:intv:end), v.predicted(4:intv:end),'^','color',darkgreen,'LineWidth', 2,'MarkerSize',10);
    legend_text{i} = 'CNN Features - Visual';
end

if plotlbp == 'y'  
    yellowish = [240 165 22] ./ 255;
	plot(x,lbp.predicted,'color',yellowish,'LineWidth', 2); %MFCC + LBP PLOT
    i = i + 1;
	p(i) = plot(x(1:intv:end), lbp.predicted(1:intv:end),'s','color',yellowish,'LineWidth', 2,'MarkerSize',10);
    legend_text{i} = 'LBPTOP';
end

if plotmfcc == 'y'
	orange = [1 .5 0];
	plot(x,mfcc.predicted,'color',orange);
end

if plotaud == 'y'
	%pinkish = [252 36 220] ./ 255;
	%plot(x,aud.predicted,'color',pinkish);
end

if plotmfcclbp == 'y'    
    purple = [0.5 0 0.9]; 
	plot(x,mfcclbp.predicted,'color',purple,'LineWidth', 2); %LBP Plot
    i = i + 1;
	p(i) = plot(x(6:intv:end), mfcclbp.predicted(6:intv:end),'*','color',purple,'LineWidth', 2,'MarkerSize',10);
    legend_text{i} = 'Predicted Valence - MFCC+LBPTOP';
end

if plotmfccddlbp == 'y'
    i = i + 1;
    pink = [145 9 43] ./ 255; %[200 74 91] ./ 255; 
	p(i) = plot(x,mfccddlbp.predicted,'--','color',pink,'LineWidth', 2); %LBP Plot
	%p(i) = plot(x(4:intv:end), mfccddlbp.predicted(4:intv:end),'p','color',pink,'LineWidth', 2,'MarkerSize',10);
    legend_text{i} = 'MFCC (with \delta and \delta\delta) + LBPTOP';
end

if plotgabor == 'y'
    i = i + 1;
	greenish = [7 53 74] ./ 255; %greenish = [8 233 157] ./ 255;
	p(i) = plot(x,gabor.predicted,':','color',greenish,'LineWidth', 2);
	%p(i) = plot(x(1:intv:end), gabor.predicted(1:intv:end),'d','color',greenish,'LineWidth', 2,'MarkerSize',10);
    legend_text{i} = 'Gabor Energy';
end

%For Audio Video
mse_AV = mean((av.actual-av.predicted).^2);
q_AV = corrcoef(av.actual,av.predicted); q_AV = q_AV(1,2);
m = mean(av.actual); vr = var(av.actual);
m_AV = mean(av.predicted); v_AV = var(av.predicted);
ccc_AV = 2 * q_AV * vr * v_AV / ( vr^2 + v_AV ^ 2 + ( m - m_AV ) ^ 2 );

%For Video
mse_v = mean((v.actual-v.predicted).^2);
q_v = corrcoef(v.actual,v.predicted); q_v = q_v(1,2);
m = mean(v.actual); vr = var(v.actual);
m_v = mean(v.predicted); v_v = var(v.predicted);
ccc_v = 2 * q_v * vr * v_v / ( vr^2 + v_v ^ 2 + ( m - m_v ) ^ 2 );

%For LBP
mse_lbp = mean((lbp.actual-lbp.predicted).^2);
q_lbp = corrcoef(lbp.actual,lbp.predicted); q_lbp = q_lbp(1,2);
m = mean(lbp.actual); vr = var(lbp.actual);
m_lbp = mean(lbp.predicted); v_lbp = var(lbp.predicted);
ccc_lbp = 2 * q_lbp * vr * v_lbp / ( vr^2 + v_lbp ^ 2 + ( m - m_lbp ) ^ 2 );

%For MFCC
mse_mfcc = mean((mfcc.actual-mfcc.predicted).^2);
q_mfcc = corrcoef(mfcc.actual,mfcc.predicted); q_mfcc = q_mfcc(1,2);
m = mean(mfcc.actual); vr = var(mfcc.actual);
m_mfcc = mean(mfcc.predicted); v_mfcc = var(mfcc.predicted);
ccc_mfcc = 2 * q_mfcc * vr * v_mfcc / ( vr^2 + v_mfcc ^ 2 + ( m - m_mfcc ) ^ 2 );

%For Audio
%mse_aud = mean((aud.actual-aud.predicted).^2);
%q_aud = corrcoef(aud.actual,aud.predicted); q_aud = q_aud(1,2);
%m = mean(aud.actual); vr = var(aud.actual);
%m_aud = mean(aud.predicted); v_aud = var(aud.predicted);
%ccc_aud = 2 * q_aud * vr * v_aud / ( vr^2 + v_aud ^ 2 + ( m - m_aud ) ^ 2 );

%For MFCC + LBP
mse_mfcclbp = mean((mfcclbp.actual-mfcclbp.predicted).^2);
q_mfcclbp = corrcoef(mfcclbp.actual,mfcclbp.predicted); q_mfcclbp = q_mfcclbp(1,2);
m = mean(mfcclbp.actual); vr = var(mfcclbp.actual);
m_mfcclbp = mean(mfcclbp.predicted); v_mfcclbp = var(mfcclbp.predicted);
ccc_mfcclbp = 2 * q_mfcclbp * vr * v_mfcclbp / ( vr^2 + v_mfcclbp ^ 2 + ( m - m_mfcclbp ) ^ 2 );

%For MFCCDD + LBP
mse_mfccddlbp = mean((mfccddlbp.actual-mfccddlbp.predicted).^2);
q_mfccddlbp = corrcoef(mfccddlbp.actual,mfccddlbp.predicted); q_mfccddlbp = q_mfccddlbp(1,2);
m = mean(mfccddlbp.actual); vr = var(mfccddlbp.actual);
m_mfccddlbp = mean(mfccddlbp.predicted); v_mfccddlbp = var(mfccddlbp.predicted);
ccc_mfccddlbp = 2 * q_mfccddlbp * vr * v_mfccddlbp / ( vr^2 + v_mfccddlbp ^ 2 + ( m - m_mfccddlbp ) ^ 2 );


%For GaborEnergy
mse_gabor = mean((gabor.actual-gabor.predicted).^2);
q_gabor = corrcoef(gabor.actual,gabor.predicted); q_gabor = q_gabor(1,2);
m = mean(gabor.actual); vr = var(gabor.actual);
m_gabor = mean(gabor.predicted); v_gabor = var(gabor.predicted);
ccc_gabor = 2 * q_gabor * vr * v_gabor / ( vr^2 + v_gabor ^ 2 + ( m - m_gabor ) ^ 2 );

% mse = [mse_AV mse_v mse_lbp mse_mfcc mse_mfcclbp mse_mfccddlbp mse_gabor]
% rmse = [mse_AV mse_v mse_lbp mse_mfcc mse_mfcclbp mse_mfccddlbp mse_gabor].^(0.5)
% q = [q_AV q_v q_lbp q_mfcc q_mfcclbp q_mfccddlbp q_gabor]
% ccc = [ccc_AV ccc_v ccc_lbp ccc_mfcc ccc_mfcclbp ccc_mfccddlbp ccc_gabor]
% disp('AudioVideo----Video------LBP-------MFCC-----MFCCLBP---MFCCDDLBP---GaborEnergy')
disp('----------------------------------Valence-----------------------------------')
disp(sprintf(['LEN-' num2str(length(selectedIndexArray)) '\tAudVid\t\tVideo\t\tLBP \t\tMFCC\t\tMFCCDDLBP\tGaborEnergy']))
disp(' ')
%mse = [mse_AV mse_v mse_lbp mse_mfcc mse_mfccddlbp mse_gabor];
%disp([sprintf('MSE:\t') num2str(mse, '\t\t%.4f')])
%disp(' ')
rmse = [mse_AV mse_v mse_lbp mse_mfcc mse_mfccddlbp mse_gabor].^(0.5);
disp([sprintf('RMSE:\t') num2str(rmse, '\t\t%.4f')])
disp(' ')
q = [q_AV q_v q_lbp q_mfcc q_mfccddlbp q_gabor];
disp([sprintf('CC :\t') num2str(q, '\t\t%.4f')])
disp(' ')
ccc = [ccc_AV ccc_v ccc_lbp ccc_mfcc ccc_mfccddlbp ccc_gabor];
disp([sprintf('CCC:\t') num2str(ccc, '\t\t%.4f')])


legend(p, legend_text)
ylabel('Valence Rating')
xlabel('Sequence of Sampled Frames')
%ylim([0 0.35])