function cmc_isometric(filename)

if nargin < 1
	% request eeg file to process
	disp('Choose a BrainVision .vhdr file')
	[fname, pname] = uigetfile('*.vhdr', 'Choose a BrainVision .vhdr file');
	if isequal(fname, 0) || isequal(pname,0)
		disp('User pressed cancel')
		return
	else
		filename = fullfile(pname, fname);
		disp(['Processing ', filename])
	end
end

% read in the data
[pname, fname, ext] = fileparts(filename);
[data, ~] = pop_loadbv(pname, [fname ext]);
% time = (1:length(data.data)) / data.srate;
n_chans = 31;

% find the chan numbers for C3, C4, and Cz, bicep, and tricep
c3_chan_num = []; c4_chan_num = []; cz_chan_num = []; bicep_chan_num = []; tricep_chan_num = [];
for ch_cnt = 1:length(data.chanlocs)
	switch lower(data.chanlocs(ch_cnt).labels)
		case 'c3'
			c3_chan_num = ch_cnt;
		case 'c4'
			c4_chan_num = ch_cnt;
		case 'cz'
			cz_chan_num = ch_cnt;
		case 'bicep'
			bicep_chan_num = ch_cnt;
		case 'tricep'
			tricep_chan_num = ch_cnt;
	end
end
if isempty(c3_chan_num)
	keyboard
end
if isempty(c4_chan_num)
	keyboard
end
if isempty(cz_chan_num)
	keyboard
end
if isempty(bicep_chan_num)
	keyboard
end
if isempty(tricep_chan_num)
	keyboard
end

% downsample to 1kHz
data.srate_down = 1000;
factor = data.srate / data.srate_down;
if abs(factor-fix(factor)) > eps
    fprintf('cmc_isometric.m sampling rate, %g, cannot be downsampled to 1kHz\n', data.srate);
	return
end

fprintf('down sampling by a factor of %d\n', factor)
data.downsamp = zeros(size(data.data,1), data.pnts/factor);
for c_cnt = [1:n_chans, bicep_chan_num, tricep_chan_num]
	data.downsamp(c_cnt, :) = decimate(double(data.data(c_cnt,:)), factor);
end

time = (1:length(data.downsamp)) / data.srate_down;

% filter values
Setup.EMGcutOffLowHz=5;
Setup.EMGcutOffHighHz=499;
Setup.EEGcutOffLowHz=0.5;
Setup.EEGcutOffHighHz=100;

low = Setup.EMGcutOffLowHz / (data.srate/2);
high = Setup.EMGcutOffHighHz / (data.srate/2);
[B_emg, A_emg] = butter(5, [low, high], 'bandpass' );

low = Setup.EEGcutOffLowHz / (data.srate/2);
high = Setup.EEGcutOffHighHz / (data.srate/2);
[B_eeg, A_eeg] = butter(4, [low, high], 'bandpass' );

% filter the data
% c3_filt = filtfilt(B_eeg, A_eeg, double(data.data(c3_chan_num,:)));

fprintf('filtering ...\n')
eeg_hp = zeros(n_chans, data.pnts/factor);
eeg_filt = zeros(n_chans, data.pnts/factor);
for c_cnt = 1:n_chans
	eeg_hp(c_cnt, :) = hpfilt(data.downsamp(c_cnt,:)', 4, Setup.EEGcutOffLowHz, data.srate_down)';
	eeg_filt(c_cnt, :) = lpfilt(eeg_hp(c_cnt, :), 4, Setup.EEGcutOffHighHz, data.srate_down)';
end

c3_hp = hpfilt(data.downsamp(c3_chan_num,:)', 4, Setup.EEGcutOffLowHz, data.srate_down);
c3_filt = lpfilt(c3_hp, 4, Setup.EEGcutOffHighHz, data.srate_down);

c4_hp = hpfilt(data.downsamp(c4_chan_num,:)', 4, Setup.EEGcutOffLowHz, data.srate_down);
c4_filt = lpfilt(c4_hp, 4, Setup.EEGcutOffHighHz, data.srate_down);

cz_hp = hpfilt(data.downsamp(cz_chan_num,:)', 4, Setup.EEGcutOffLowHz, data.srate_down);
cz_filt = lpfilt(cz_hp, 4, Setup.EEGcutOffHighHz, data.srate_down);

% common average reference
F_all = ones(n_chans)*(-1/(n_chans-1)) + eye(n_chans)*(1+1/(n_chans-1)); %CAR matrix
c3_car = F_all(c3_chan_num, :) * eeg_filt;
c4_car = F_all(c4_chan_num, :) * eeg_filt;

c3_cz = c3_filt - cz_filt;
c4_cz = c4_filt - cz_filt;

bicep_hp = hpfilt(data.downsamp(bicep_chan_num,:)', 4, Setup.EMGcutOffLowHz, data.srate_down);
bicep_filt = lpfilt(bicep_hp, 4, Setup.EMGcutOffHighHz, data.srate_down);

tricep_hp = hpfilt(data.downsamp(tricep_chan_num,:)', 4, Setup.EMGcutOffLowHz, data.srate_down);
tricep_filt = lpfilt(tricep_hp, 4, Setup.EMGcutOffHighHz, data.srate_down);

% plot eeg
figure
subplot(4,1,1)
plot(time, c3_filt)
ylabel('C3')
subplot(4,1,2)
plot(time, c3_cz, time, c3_car)
ylabel('C3-Cz & c3-car')
subplot(4,1,3)
plot(time, c4_filt)
ylabel('C4')
subplot(4,1,4)
plot(time, c4_cz, time, c4_car)
ylabel('C4-Cz & C4-car')
xlabel('time')

% plot emg & eeg
figure
h_ax(1) = subplot(4,1,1);
plot(time, c3_car)
title('EEG')
ylabel('C3-car')
h_ax(2) = subplot(4,1,2);
plot(time, c4_car)
ylabel('C4-car')

h_ax(3) = subplot(4,1,3);
plot(time, bicep_filt)
title('EMG')
ylabel('Bicep')
h_ax(4) = subplot(4,1,4);
plot(time, tricep_filt)
ylabel('Tricep')

xlabel('Time')

linkaxes(h_ax, 'x')

% add event times to emg
for e_cnt = 1:length(data.event)
	if strcmpi(data.event(e_cnt).code, 'rest')
		t = data.event(e_cnt).latency / data.srate;
		line(h_ax(3), [t t], h_ax(3).YLim, 'Color', [0.9 0 0])
		line(h_ax(4), [t t], h_ax(4).YLim, 'Color', [0.9 0 0])
	elseif strcmpi(data.event(e_cnt).code, 'extend')
		t = data.event(e_cnt).latency / data.srate;
		line(h_ax(3), [t t], h_ax(3).YLim, 'Color', [0 0.9 0])
		line(h_ax(4), [t t], h_ax(4).YLim, 'Color', [0 0.9 0])
		add_cmc_patch(h_ax, t+1, t+5)
	end
		
end



keyboard
