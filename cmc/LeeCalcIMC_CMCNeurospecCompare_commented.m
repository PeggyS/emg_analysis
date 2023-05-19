%The filtered signals were then full-wave rectified, as is often recommended for 
% preparing EMG signals for correlation and coherence analysis (Boonstra and Breakspear 2012;
% Farina et al. 2013; Ward et al. 2013) and normalized to unit variance (z-score).

close all
clear all

Setup.Subject='c2795'
Setup.Name='0002'
Setup.DoAllTimeFlag=1;
Setup.RectifyFlag=1;
Setup.Decimation=10;%how much to downsample raw data. This example data file was collected at 10000 
% so I downsampled by 10 to get to 1000
Setup.RMSFlag=0;
Setup.Hz60NotchFlag=1;

% s3103 week01 0007 = isometric extension
% dat=load('C:\Grants\AhlamCDA2\ResubmissionJune2022\ResubmissionDec2022\Data\REdownload\s3103uemp\week01\0007.mat');
% dat = load('/Users/peggy/Documents/BrainLab/myopro_merit/analysis/eeg/s3103uemp/week01/0007.mat')
% [dat.EEG, com] = pop_loadbv('/Users/peggy/Documents/BrainLab/myopro_merit/data/emg-nirs-eeg/s3103uemp/week01', ...
% 	'20221116_0007.vhdr');
[dat.EEG, com] = pop_loadbv('/Users/peggy/Library/CloudStorage/Box-Box/myopro_merit/data/emg-nirs-eeg/s3103uemp/week01', ...
	'20221116_0007.vhdr');
% savepath='C:\Grants\AhlamCDA2\ResubmissionJune2022\ResubmissionDec2022\Data\REdownload\s3103uemp\week01\0007_processedCompare';

% c2795 session session01 0002 = isometric extension, subset of channels
% were gelled. From my notes, Cz was not gelled. Looking at the data in
% EEGLAB, Cz looks like noise.
% [dat.EEG, com] = pop_loadbv('/Users/peggy/Documents/BrainLab/myopro_merit/data/emg-nirs-eeg/c2795tdvg/Session01/', ...
% 	'20221107_0002.vhdr')
%dat=load('C:\Grants\AhlamCDA2\ResubmissionJune2022\ResubmissionDec2022\Data\REdownload\c2795tdvg\Session01\0002.mat');
%savepath='C:\Grants\AhlamCDA2\ResubmissionJune2022\ResubmissionDec2022\Data\REdownload\c2795tdvg\Session01\0002_processedCompare'; % I Output path
% savepath = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/eeg/c2795/Session01/';


Setup.NSampRate=dat.EEG.srate/Setup.Decimation;
% for c2795
Setup.C3=5; % These I got from the loaded  mat file and just manually typed them here
Setup.C4=15;
Setup.Cz=14; 

% for s3103 week01
Setup.C3 = 5;
Setup.C4 = 14;
Setup.Cz = 13;

Setup.NFFT=10;%power of 2 defining the number of samples to include in FFT

%% Defining bands of interest
%this section defines boarders of FFT bands to use, calculates frequency
%intervals for your given sampling rate and FFT size, then makes output
%matrices of indices into the FFT output that make up the different bands (iFFTmatrix) and the actual 
% band boarders acievable with that FFT configuration (BPmatrix) 
Setup.BPmatrixGoal=[ 5.8 14.6; 15.6 35.1; 36.1 54.6]; %these are the boarders of the three frequency 
% bands of interest (alpha beta gamma) set to roughly coincide with the specific FFT boarders
freq = (Setup.NSampRate/2)*linspace(0,1,(2^Setup.NFFT)/2+1);%frequency of the FFT samples
freq=freq(2:end);
Setup.BPmatrix=zeros(size(Setup.BPmatrixGoal));
Setup.iFFTmatrix=zeros(size(Setup.BPmatrix));
for  i=1:size(Setup.BPmatrix,1)
    for j=1:size(Setup.BPmatrix,2)
        [m, Setup.iFFTmatrix(i,j)]=min(abs(freq-Setup.BPmatrixGoal(i,j)));
        Setup.BPmatrix(i,j)=freq(Setup.iFFTmatrix(i,j));
    end
end

Setup.HzInt=mean(diff(freq))% gets size of frequency bins.

%% Read data into appropriate EMG and EEG variables...Check to make sure numbers are what is in your specific data files.
RawEMG=dat.EEG.data(64:65,round(1:Setup.Decimation:end));%May need to verify this is where 
% biceps and triceps are in each file.
RawEEG=dat.EEG.data(1:31,round(1:Setup.Decimation:end));%May need to verify this is where 
% EEG chnnels are in each file.

Setup.EMGcutOffLowHz=5;
Setup.EMGcutOffHighHz=499;
Setup.EEGcutOffLowHz=0.5;
Setup.EEGcutOffHighHz=100;
Setup.HzCutoff=55; % prior reviewer didnt like plots going abouve this.
RawDataTimeAxis=[1:length(RawEMG)]/Setup.NSampRate;%dat.EEG.times;%
  
%% This section bandpass and notch filters the EMG and EEG data
%EMG
RawEMGNDC=zeros(size(RawEMG));% EMGNDC means filtered version with 'No DC'
numEMGSignals=size(RawEMG,1);
cutOffLow = Setup.EMGcutOffLowHz/(Setup.NSampRate/2);
cutOffHigh = Setup.EMGcutOffHighHz/(Setup.NSampRate/2);
[B,A] = butter(5,[cutOffLow,cutOffHigh],'bandpass' );
if Setup.Hz60NotchFlag
    d = designfilt('bandstopiir','FilterOrder',2, ...
        'HalfPowerFrequency1',59,'HalfPowerFrequency2',61, ...
        'DesignMethod','butter','SampleRate',Setup.NSampRate);
end
for ch=1:numEMGSignals
    RawEMGNDC(ch,:) = filtfilt(B,A,double(RawEMG(ch,:)));%bandpass filter signal without adding delay
    if Setup.Hz60NotchFlag
        RawEMGNDC(ch,:) = filtfilt(d,double(RawEMGNDC(ch,:)));%bandpass filter signal without adding delay
    end
    
end

%EEG
RawEEGNDC=zeros(size(RawEEG));% EEGNDC means filtered version with 'No DC'
numEEGSignals=size(RawEEG,1);
cutOffLow = Setup.EEGcutOffLowHz/(Setup.NSampRate/2);
cutOffHigh = Setup.EEGcutOffHighHz/(Setup.NSampRate/2);
[B,A] = butter(5,[cutOffLow,cutOffHigh],'bandpass' );
for ch=1:numEEGSignals%% filter and plot a sparse version of the voltage traces so not too much memory is used on the plot
    RawEEGNDC(ch,:) = filtfilt(B,A,double(RawEEG(ch,:)));%bandpass filter signal without adding delay
	if ch==1
		figure
		subplot(2,1,1)
		plot(RawDataTimeAxis, RawEEG(ch,:))
		ylabel('raw data')
		title('eeg chan 1')

		subplot(2,1,2)
		plot(RawDataTimeAxis, RawEEGNDC(ch,:))
		ylabel('bandpass filtered')
		xlabel('Time')

		figure
		subplot(3,1,1)
		plot(RawDataTimeAxis, RawEEG(ch,:))
		ylabel('raw data')
		title('eeg chan 1')

		hp = hpfilt(double(RawEEG(ch,:))', 5, Setup.EEGcutOffLowHz, Setup.NSampRate);
		subplot(3,1,2)
		plot(RawDataTimeAxis, hp)
		ylabel('high pass filter')

		lp = lpfilt(hp, 5, Setup.EEGcutOffHighHz, Setup.NSampRate);
		subplot(3,1,3)
		plot(RawDataTimeAxis, lp)
		ylabel('high then low pass filter')
		xlabel('Time')
	end
    if Setup.Hz60NotchFlag
        RawEEGNDC(ch,:) = filtfilt(d,double(RawEEGNDC(ch,:)));%bandpass filter signal without adding delay
    end
end

%% Plot filtered EMGs
ccode=['-k';'-r';'-b';'-g']; % color code for different emg channels
Setup.Yspacing=14*nanmean(nanstd(RawEMGNDC'));
plotheight=Setup.Yspacing*[1:numEMGSignals];
fraw5_1000=figure('Name',[Setup.Subject '_' Setup.Name]);

set(fraw5_1000,'OuterPosition',[0 0 1400 850]);

for ch=1:numEMGSignals
    
    plot(RawEMGNDC(ch,:)/ Setup.Yspacing +ch, ccode(ch,:));
     hold on
end
%% plot filtered EEG

Setup.Yspacing=14*nanmean(nanstd(RawEEGNDC'));
plotheight=Setup.Yspacing*[1:numEEGSignals];
fraw5_1000=figure('Name',[Setup.Subject '_' Setup.Name]);

set(fraw5_1000,'OuterPosition',[0 0 1400 850]);

for ch=1:numEEGSignals
    
    plot(RawEEGNDC(ch,:)/ Setup.Yspacing +ch, 'k-');
    hold on
end

%% Calc C3 and C4 relative to CZ
C3Cz=RawEEGNDC(Setup.C3,:)-RawEEGNDC(Setup.Cz,:);
C4Cz=RawEEGNDC(Setup.C4,:)-RawEEGNDC(Setup.Cz,:);

%% Calc C3 and C4 relative to a Common Average Reference (CAR)
% this section calculates the CAR common average reference matrix to apply to EEG
[F_all]=ones(size(RawEEG,1))*(-1/(size(RawEEG,1)-1)) + eye(size(RawEEG,1))*(1+1/(size(RawEEG,1)-1)); %CAR matrix

C3CAR=F_all(Setup.C3,:)*RawEEGNDC;
C4CAR=F_all(Setup.C4,:)*RawEEGNDC;

%% plot no ref vs Cz ref, vs CAR ref to compare and choose a noise reduction option 
fprocessed=figure
plot(RawEEGNDC(Setup.C3,:)/ Setup.Yspacing ,'k-')
hold on
plot(C3Cz/ Setup.Yspacing + 1,'k-')
hold on
plot(C3CAR/ Setup.Yspacing + 2,'k-')
plot(RawEEGNDC(Setup.C4,:)/ Setup.Yspacing +5,'k-')
hold on
plot(C4Cz/ Setup.Yspacing + 6,'k-')
hold on
plot(C4CAR/ Setup.Yspacing + 7,'k-')

ylabel('C3, C3-CZ, C3-CAR, C4, C4-CZ, C4-CAR')

if Setup.DoAllTimeFlag==0 % this is a hold over from my first method of marking contraction segments...just leave flag as 0 for now
    %  EMGCenters=[]
    %    keepgoingflag=1;
    %     disp ('click EMG centers on upper plot. Hit below 1 to end')
    %    while keepgoingflag
    %
    %        [x1, y1]=ginput(1);
    %        if y1>1
    %            EMGCenters=[EMGCenters x1];
    %        else
    %            keepgoingflag=0;
    %        end
    %
    %    end
    %
    %     RestCenters=[]
    %    keepgoingflag=1;
    %  disp ('click Rest centers on upper plot. Hit below 1 to end')
    %    while keepgoingflag
    %
    %        [x1, y1]=ginput(1);
    %        if y1>1
    %            RestCenters=[RestCenters x1];
    %        else
    %            keepgoingflag=0;
    %        end
    %
    %    end
    %
    % % if strcmp(Setup.Name,'0001')
    % %     % for S3101 0001
    % %     EMGCenters=[13268 53076 91327]
    % %     RestCenters=[3698 29540 70434]
    % % elseif strcmp(Setup.Name,'0005')
    % %     %for S3101 0005
    % %     EMGCenters=[20141 62533 86252 108019 131184 156160 182060 204363 226725 248768 269466 289205 309307 328537 348912 371382 394545 416627 438925 459211]
    % %     RestCenters=[5988 44498 74494 97970 119204 143756 169605 194063 238604 259156 279760 299182 319455 338180 360283 404735 427478 469959]
    % % end
    % Results.EMGCenters=EMGCenters;
    % Results.RestCenters=RestCenters;
    % plot([1;1]*EMGCenters, 1:size(RawEMGNDC,1)*ones(1,length(EMGCenters)),'*c')
    % plot([1;1]*EMGCenters-Setup.NFFT/2, 1:size(RawEMGNDC,1)*ones(1,length(EMGCenters)),'.c')
    % plot([1;1]*EMGCenters+Setup.NFFT/2, 1:size(RawEMGNDC,1)*ones(1,length(EMGCenters)),'.c')
    %
    % plot([1;1]*RestCenters, 1:size(RawEMGNDC,1)*ones(1,length(RestCenters)),'*g')
    % plot([1;1]*RestCenters-Setup.NFFT/2, 1:size(RawEMGNDC,1)*ones(1,length(RestCenters)),'.g')
    % plot([1;1]*RestCenters+Setup.NFFT/2, 1:size(RawEMGNDC,1)*ones(1,length(RestCenters)),'.g')
    %
    % saveas(fraw5_1000,[savepath 'Intervals']);
else
    %% manually uncomment which ever referencing option you want to use based on how well 
	% noise is removed by the referencing option in the above plot. probably best to keep 
	% choice consistent across subjects.
    % use for Cz referencing  
    C3=C3Cz;%C3CAR;%
    C4=C4Cz;%C4CAR;
%      % use for Common Average referencing 
%     C3=C3CAR;%
%     C4=C4CAR;
%     % use if raw signals are clean and no referencing is needed
%     C3=RawEEGNDC(Setup.C3,:);
%     C4=RawEEGNDC(Setup.C4,:);
    Setup.ref='Z' % so you have a record of what referencing was used
   
  %% this calls functions from Neurospec2.0 (software used by other papers from likely reviewer). 
  % Make sure neurospec folder/subfolder are in your path
  % These get default calculations for combinations of 'C3', 'C4' 'b' (biceps) and 't' (triceps)
  % outputs are 'f' frequency domain results; 't' time domain results, 'cl' confidence limit info; 
  % 'sc' spetral coefficients
    [All.f_C3b,All.t_C3b,All.cl_C3b,All.sc_C3b] = sp2a2_m1(0,C3',RawEMGNDC(1,:)',Setup.NSampRate,Setup.NFFT,'');
    [All.f_C3t,All.t_C3t,All.cl_C3t,All.sc_C3t] = sp2a2_m1(0,C3',RawEMGNDC(2,:)',Setup.NSampRate,Setup.NFFT,'');
    
    [All.f_C4b,All.t_C4b,All.cl_C4b,All.sc_C4b] = sp2a2_m1(0,C4',RawEMGNDC(1,:)',Setup.NSampRate,Setup.NFFT,'');
    [All.f_C4t,All.t_C4t,All.cl_C4t,All.sc_C4t] = sp2a2_m1(0,C4',RawEMGNDC(2,:)',Setup.NSampRate,Setup.NFFT,'');
    %
    [All.f_bt,All.t_bt,All.cl_bt,All.sc_bt] = sp2a2_m1(0,RawEMGNDC(2,:)',RawEMGNDC(1,:)',Setup.NSampRate,Setup.NFFT,'');
    
    % This section plots results

    %% here Im just using Neurospec2.0 premade plotting functions.
    % The sampling rate defines the nyquist frequency as 500 Hz.
    freq=500;     % Parameters for plotting
    lag_tot=500;
    lag_neg=250;
    ch_max=2*max([All.f_C3b(:,4);All.f_C3t(:,4);All.f_C4b(:,4);All.f_C4t(:,4)]);
    
    fcmcC3_b=figure(1001)
    All.cl_C3b.what='C3_B';
    psp2(All.f_C3b,All.t_C3b,All.cl_C3b,freq,lag_tot,lag_neg,ch_max)
    
    fcmcC4_b=figure(1002);
    All.cl_C4b.what='C4_B';
    psp2(All.f_C4b,All.t_C4b,All.cl_C4b,freq,lag_tot,lag_neg,ch_max);
    
    fcmcC3_t=figure(1003);
    All.cl_C3t.what='C3_t';
    psp2(All.f_C3t,All.t_C3t,All.cl_C3t,freq,lag_tot,lag_neg,ch_max);
    
    fcmcC4_t=figure(1004);
    All.cl_C4t.what='C4_t';
    psp2(All.f_C4t,All.t_C4t,All.cl_C4t,freq,lag_tot,lag_neg,ch_max);
    
    fimcbt=figure(1005);
    All.cl_bt.what='IMC b_t';
    psp2(All.f_bt,All.t_bt,All.cl_bt,freq,lag_tot,lag_neg,max(All.f_bt(:,4)));
    
    % now Im doinh my own plots of CMC and IMC to see if they match the
    % standard Neuroscep plots
        fCMC=figure(1000)
    subplot(3,1,1)
    
    plot(All.f_C3b(:,1),All.f_C3b(:,4),'k-');
    hold on
    plot(All.f_C3t(:,1),All.f_C3t(:,4),'r-');
    subplot(3,1,2)
    plot(All.f_C4b(:,1),All.f_C4b(:,4),'k-');
    hold on
    plot(All.f_C4t(:,1),All.f_C4t(:,4),'r-');
    
    subplot(3,1,3)
    plot(All.f_bt(:,1),All.f_bt(:,4),'k-');
    
    %% now identify contract and rest time points
    RMSint=[] % get root mean squared of filtered EMG data summed in timesegments that align with FFT windows
    istarts=[]
    k=1
    while k+2^Setup.NFFT-1<=length(RawEMGNDC(2,:))
        RMSint=[RMSint; sqrt(mean(abs(RawEMGNDC(2,k:k+2^Setup.NFFT-1)+RawEMGNDC(2,k:k+2^Setup.NFFT-1))))];
        istarts=[istarts; k];
        k=k+2^Setup.NFFT;
    end
    [sRMSint isRMSint]=sort(RMSint);
    figure(750); plot(sRMSint)
    keyboard % This is where I look at the magnitude of the RMS integrated data sorted to manually pick cutoffs. 
	% sine there was less contractio time points than relaxed timepoints I tended to pick points that are fairly 
	% liberal for counting as EMG
    irest=300 % maually put in here the cutoff points (index from x axis in plot) for largest rest value
    icont=308 % manually put in here the cutoff points (index from x axis in plot) for smallest contraction value
    ncont=length(icont:length(RMSint));%176 for 3103 007
    Setup.irest=irest; % this Setup structure gets saved so we have a record of what points we manually chose. 
    Setup.icont=icont;
    Setup.ncont=ncont;
    
    % now assembe new variables of indices of good rest & good contraction time points. 
    igoodrest=zeros(irest*2^Setup.NFFT,1);
    k=1
    for i=1:irest
        igoodrest(k:k-1+2^Setup.NFFT)=[istarts(isRMSint(i)):istarts(isRMSint(i))-1+ 2^Setup.NFFT];
        k=k+2^Setup.NFFT;
    end
    igoodrest=sort(igoodrest);
    
    igoodcont=zeros(length(icont:length(istarts))*2^Setup.NFFT,1);
    k=1
    for i=icont:length(istarts)
        igoodcont(k:k-1+ 2^Setup.NFFT)=[istarts(isRMSint(i)):istarts(isRMSint(i))-1+ 2^Setup.NFFT];
        k=k+2^Setup.NFFT;
    end
    igoodcont=sort(igoodcont);
    %store these time points for rest and contraction
      Setup.igoodcont=igoodcont;
      Setup.igoodrest=igoodrest;
    
    
    %varify by plotting color coded astrisks under EMG plots to show rest
    %vs contraction time points.
    figure(1)
    hold on
    plot(igoodcont,zeros(size(igoodcont))-.5,'r*');
    plot(igoodrest,zeros(size(igoodrest))-.4,'k*');
    
    
    %% Repeat above analysis with contration time points only
    
    [Cont.f_C3b_c,Cont.t_C3b_c,Cont.cl_C3b_c,Cont.sc_C3b_c] = sp2a2_m1(0,C3(igoodcont)',RawEMGNDC(1,igoodcont)',Setup.NSampRate,Setup.NFFT,'');
    [Cont.f_C3t_c,Cont.t_C3t_c,Cont.cl_C3t_c,Cont.sc_C3t_c] = sp2a2_m1(0,C3(igoodcont)',RawEMGNDC(2,igoodcont)',Setup.NSampRate,Setup.NFFT,'');
    
    [Cont.f_C4b_c,Cont.t_C4b_c,Cont.cl_C4b_c,Cont.sc_C4b_c] = sp2a2_m1(0,C4(igoodcont)',RawEMGNDC(1,igoodcont)',Setup.NSampRate,Setup.NFFT,'');
    [Cont.f_C4t_c,Cont.t_C4t_c,Cont.cl_C4t_c,Cont.sc_C4t_c] = sp2a2_m1(0,C4(igoodcont)',RawEMGNDC(2,igoodcont)',Setup.NSampRate,Setup.NFFT,'');
    
    
    [Cont.f_bt_c,Cont.t_bt_c,Cont.cl_bt_c,Cont.sc_bt_c] = sp2a2_m1(0,RawEMGNDC(2,igoodcont)',RawEMGNDC(1,igoodcont)',Setup.NSampRate,Setup.NFFT,'');
    
    fCMC_c=figure(2000)
    subplot(3,1,1)
    ccode=['k-';'r-';'b-';'g-']
    
    plot(Cont.f_C3b_c(:,1),Cont.f_C3b_c(:,4),'k-');
    hold on
    plot(Cont.f_C3t_c(:,1),Cont.f_C3t_c(:,4),'r-');
    subplot(3,1,2)
    plot(Cont.f_C4b_c(:,1),Cont.f_C4b_c(:,4),'k-');
    hold on
    plot(Cont.f_C4t_c(:,1),Cont.f_C4t_c(:,4),'r-');
    
    subplot(3,1,3)
    plot(Cont.f_bt_c(:,1),Cont.f_bt_c(:,4),'k-');
    
    % The sampling rate defines the nyquist frequency as 500 Hz.
    freq=500;     % Parameters for plotting
    lag_tot=500;
    lag_neg=250;
    ch_max_c=2*max([Cont.f_C3b_c(:,4);Cont.f_C3t_c(:,4);Cont.f_C4b_c(:,4);Cont.f_C4t_c(:,4)]);
    
    fcmcC3_b_c=figure(2001)
    Cont.cl_C3b_c.what='C3_B_c'; % c at end means contraction data used in analysis
    psp2(Cont.f_C3b_c,Cont.t_C3b_c,Cont.cl_C3b_c,freq,lag_tot,lag_neg,ch_max_c)
    
    fcmcC4_b_c=figure(2002);
    Cont.cl_C4b_c.what='C4_B_c';
    psp2(Cont.f_C4b_c,Cont.t_C4b_c,Cont.cl_C4b_c,freq,lag_tot,lag_neg,ch_max_c);
    
    fcmcC4_t_c=figure(2003);
    fcmcC4_t_c=figure(2004);
    Cont.cl_C4t_c.what='C4_t_c';
    psp2(Cont.f_C4t_c,Cont.t_C4t_c,Cont.cl_C4t_c,freq,lag_tot,lag_neg,ch_max_c);
    
    Cont.cl_C3t_c.what='C3_t_c';
    psp2(Cont.f_C3t_c,Cont.t_C3t_c,Cont.cl_C3t_c,freq,lag_tot,lag_neg,ch_max_c);
    
    fimcbt_c=figure(2005);
    Cont.cl_bt_c.what='IMC bt_c ';
    psp2(Cont.f_bt_c,Cont.t_bt_c,Cont.cl_bt_c,freq,lag_tot,lag_neg,max(Cont.f_bt_c(:,4)));
    
    %% now repeat with rest timepoints only
    
    
    
    [Rest.f_C3b_r,Rest.t_C3b_r,Rest.cl_C3b_r,Rest.sc_C3b_r] = sp2a2_m1(0,C3(igoodrest)',RawEMGNDC(1,igoodrest)',Setup.NSampRate,Setup.NFFT,'');
    [Rest.f_C3t_r,Rest.t_C3t_r,Rest.cl_C3t_r,Rest.sc_C3t_r] = sp2a2_m1(0,C3(igoodrest)',RawEMGNDC(2,igoodrest)',Setup.NSampRate,Setup.NFFT,'');
    
    [Rest.f_C4b_r,Rest.t_C4b_r,Rest.cl_C4b_r,Rest.sc_C4b_r] = sp2a2_m1(0,C4(igoodrest)',RawEMGNDC(1,igoodrest)',Setup.NSampRate,Setup.NFFT,'');
    [Rest.f_C4t_r,Rest.t_C4t_r,Rest.cl_C4t_r,Rest.sc_C4t_r] = sp2a2_m1(0,C4(igoodrest)',RawEMGNDC(2,igoodrest)',Setup.NSampRate,Setup.NFFT,'');
    %     [f_C4ff,All.t_C4ff,cl_C4ff,sc_C4ff] = sp2a2_m1(0,C4',RawEMGNDC(3,:)',Setup.NSampRate,10,'');
    %     [f_C4fe,All.t_C4fe,cl_C4fe,sc_C4fe] = sp2a2_m1(0,C4',RawEMGNDC(4,:)',Setup.NSampRate,10,'');
    %
    [Rest.f_bt_r,Rest.t_bt_r,Rest.cl_bt_r,Rest.sc_bt_r] = sp2a2_m1(0,RawEMGNDC(2,igoodrest)',RawEMGNDC(1,igoodrest)',Setup.NSampRate,Setup.NFFT,'');
    
    fCMC_r=figure(3000)
    subplot(3,1,1)
    ccode=['k-';'r-';'b-';'g-']
    
    plot(Rest.f_C3b_r(:,1),Rest.f_C3b_r(:,4),'k-');
    hold on
    plot(Rest.f_C3t_r(:,1),Rest.f_C3t_r(:,4),'r-');
    subplot(3,1,2)
    plot(Rest.f_C4b_r(:,1),Rest.f_C4b_r(:,4),'k-');
    hold on
    plot(Rest.f_C4t_r(:,1),Rest.f_C4t_r(:,4),'r-');
    
    subplot(3,1,3)
    plot(Rest.f_bt_r(:,1),Rest.f_bt_r(:,4),'k-');
    
    % The sampling rate defines the nyquist frequency as 500 Hz.
    freq=500;     % Parameters for plotting
    lag_tot=500;
    lag_neg=250;
    ch_max_r=2*max([Rest.f_C3b_r(:,4);Rest.f_C3t_r(:,4);Rest.f_C4b_r(:,4);Rest.f_C4t_r(:,4)]);
    
    fcmcC3_b_r=figure(3001)
    Rest.cl_C3b_r.what='C3_B_r'; % r at end means rest data used in analysis
    psp2(Rest.f_C3b_r,Rest.t_C3b_r,Rest.cl_C3b_r,freq,lag_tot,lag_neg,ch_max_r)
    
    fcmcC4_b_r=figure(3002);
    Rest.cl_C4b_r.what='C4_B_r';
    psp2(Rest.f_C4b_r,Rest.t_C4b_r,Rest.cl_C4b_r,freq,lag_tot,lag_neg,ch_max_r);
    
    fcmcC4_t_r=figure(3003);
    Rest.cl_C3t_r.what='C3_t_r';
    psp2(Rest.f_C3t_r,Rest.t_C3t_r,Rest.cl_C3t_r,freq,lag_tot,lag_neg,ch_max_r);
    
    fcmcC4_t_r=figure(3004);
    Rest.cl_C4t_r.what='C4_t_r';
    psp2(Rest.f_C4t_r,Rest.t_C4t_r,Rest.cl_C4t_r,freq,lag_tot,lag_neg,ch_max_r);
    
    fimcbt_r=figure(3005);
    Rest.cl_bt_r.what='IMC bt_r ';
    psp2(Rest.f_bt_r,Rest.t_bt_r,Rest.cl_bt_r,freq,lag_tot,lag_neg,max(Rest.f_bt_r(:,4)));
    
end
%% save out the analysis results from rest only, contraction only, and when calculated when all data is combined.
save([savepath],'All','Rest','Cont','Setup')
% 
%% old stuff I used to confirm Neuropec coherence results align with matlabs mscohere function. not actually needed for analysis so commented out.
%     fMCSIMC=figure(2000);
%     set(fMCSIMC,'OuterPosition',[0 0 1400 850]);ll'
%     %get size
%     i=round(length(RawEMGNDC)/2);
%     [msc f] = mscohere(RawEMGNDC(1,i-2^Setup.NFFT/2: i+2^Setup.NFFT/2-1),RawEMGNDC(2,i-2^Setup.NFFT/2: i+2^Setup.NFFT/2-1),[] ,[] ,[] ,Setup.NSampRate) ;
%     
%     n=floor(size(RawEMGNDC,2)/Setup.NFFT)-1;
%     j=find(f<=Setup.HzCutoff)
%     IMCMatrix=zeros(n,length(j));
%     CMCMatrixC3B=zeros(n,length(j));
%     CMCMatrixC3T=zeros(n,length(j));
%     CMCMatrixC4B=zeros(n,length(j));
%     CMCMatrixC4T=zeros(n,length(j));
%     RMSMatrixB=zeros(n,1);
%     RMSMatrixT=zeros(n,1);
%     
%     if Setup.RMSFlag
%         RawEMGNDC=sqrt(RawEMGNDC.*RawEMGNDC);
%     end
%     k=Setup.NFFT;
%     sampaxis=[];
%     for i=1:n
%         [msc f] = mscohere(RawEMGNDC(1,k-Setup.NFFT/2: k+Setup.NFFT/2-1),RawEMGNDC(2,k-Setup.NFFT/2: k+Setup.NFFT/2-1),[] ,[] ,[] ,Setup.NSampRate) ;
%         IMCMatrix(i,:)=msc(j);
%         
%         [msc f] = mscohere(RawEMGNDC(1,k-Setup.NFFT/2: k+Setup.NFFT/2-1),C3CAR(1,k-Setup.NFFT/2: k+Setup.NFFT/2-1),[] ,[] ,[] ,Setup.NSampRate) ;
%         CMCMatrixC3B(i,:)=msc(j);
%         
%         [msc f] = mscohere(RawEMGNDC(2,k-Setup.NFFT/2: k+Setup.NFFT/2-1),C3CAR(1,k-Setup.NFFT/2: k+Setup.NFFT/2-1),[] ,[] ,[] ,Setup.NSampRate) ;
%         CMCMatrixC3T(i,:)=msc(j);
%         
%         [msc f] = mscohere(RawEMGNDC(1,k-Setup.NFFT/2: k+Setup.NFFT/2-1),C4CAR(1,k-Setup.NFFT/2: k+Setup.NFFT/2-1),[] ,[] ,[] ,Setup.NSampRate) ;
%         CMCMatrixC4B(i,:)=msc(j);
%         
%         [msc f] = mscohere(RawEMGNDC(2,k-Setup.NFFT/2: k+Setup.NFFT/2-1),C4CAR(1,k-Setup.NFFT/2: k+Setup.NFFT/2-1),[] ,[] ,[] ,Setup.NSampRate) ;
%         CMCMatrixC4T(i,:)=msc(j);
%         
%         RMSMatrixB(i,1)=sum(RawEMGNDC(1,k-Setup.NFFT/2: k+Setup.NFFT/2-1));
%         RMSMatrixT(i,1)=sum(RawEMGNDC(2,k-Setup.NFFT/2: k+Setup.NFFT/2-1));
%         
%         sampaxis=[sampaxis k];
%         k=k+Setup.NFFT
%         
%         
%     end
%     ZIMCMatrix= IMCMatrix;
%     for i=j
%         ZIMCMatrix(:,i)=.5*log10((1+IMCMatrix(:,i))./(1-IMCMatrix(:,i)));
%     end
%     %pcolor(sampaxis, f,IMCMatrix)
%     icms=pcolor(IMCMatrix')
%     
%     icms.EdgeColor='none'
%     colorbar
%     figure
%     zicms=pcolor(ZIMCMatrix')
%     
%     zicms.EdgeColor='none'
%     colorbar
%     %s.CDataMapping='scaled'
%     fcmcC3T=figure('Name','CMCC3T');
%     cmcC3T=pcolor(CMCMatrixC3T')
%     cmcC3T.EdgeColor='none'
%     colorbar
%     
%     fcmcC4T=figure('Name','CMCC4T');
%     cmcC4T=pcolor(CMCMatrixC4T')
%     cmcC4T.EdgeColor='none'
%     colorbar
%     
%     fcmcC3B=figure('Name','CMCC3B');
%     cmcC3B=pcolor(CMCMatrixC3B')
%     cmcC3B.EdgeColor='none'
%     colorbar
%     
%     fcmcC4B=figure('Name','CMCC4B');
%     cmcC4B=pcolor(CMCMatrixC4B')
%     cmcC4B.EdgeColor='none'
%     colorbar
%     
% end
% Results.IMCMatrix=IMCMatrix;
% Results.CMCMatrixC3T=CMCMatrixC3T;
% Results.CMCMatrixC3B=CMCMatrixC3B;
% Results.CMCMatrixC4B=CMCMatrixC4B;
% Results.CMCMatrixC4T=CMCMatrixC4T;
% Results.RMSMatrixB=RMSMatrixB;
% Results.RMSMatrixT=RMSMatrixT;
% Results.f=f;
% Results.sampaxis=sampaxis;
% 
% save(savepath,'Setup', 'Results');