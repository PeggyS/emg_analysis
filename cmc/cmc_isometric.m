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
time = (1:length(data.data)) / data.srate;

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

c3_hp = hpfilt(double(data.data(c3_chan_num,:))', 4, Setup.EEGcutOffLowHz, data.srate);
c3_filt = lpfilt(c3_hp, 4, Setup.EEGcutOffHighHz, data.srate);

c4_hp = hpfilt(double(data.data(c4_chan_num,:))', 4, Setup.EEGcutOffLowHz, data.srate);
c4_filt = lpfilt(c4_hp, 4, Setup.EEGcutOffHighHz, data.srate);

cz_hp = hpfilt(double(data.data(cz_chan_num,:))', 4, Setup.EEGcutOffLowHz, data.srate);
cz_filt = lpfilt(cz_hp, 4, Setup.EEGcutOffHighHz, data.srate);

c3_cz = c3_filt - cz_filt;
c4_cz = c4_filt - cz_filt;

bicep_hp = hpfilt(double(data.data(bicep_chan_num,:))', 4, Setup.EMGcutOffLowHz, data.srate);
bicep_filt = lpfilt(bicep_hp, 4, Setup.EMGcutOffHighHz, data.srate);

tricep_hp = hpfilt(double(data.data(tricep_chan_num,:))', 4, Setup.EMGcutOffLowHz, data.srate);
tricep_filt = lpfilt(tricep_hp, 4, Setup.EMGcutOffHighHz, data.srate);

% plot eeg
figure
subplot(4,1,1)
plot(time, c3_filt)
ylabel('C3')
subplot(4,1,2)
plot(time, c3_cz)
ylabel('C3-Cz')
subplot(4,1,3)
plot(time, c4_filt)
ylabel('C4')
subplot(4,1,4)
plot(time, c4_cz)
ylabel('C4-Cz')
xlabel('time')

% plot emg
figure
h_ax1 = subplot(2,1,1);
plot(time, bicep_filt)
h_ax2 = subplot(2,1,2);
plot(time, tricep_filt)

% add event times to emg
for e_cnt = 1:length(data.event)
	if strcmpi(data.event(e_cnt).code, 'rest')
		t = data.event(e_cnt).latency / data.srate;
		line(h_ax1, [t t], h_ax1.YLim, 'Color', [0.9 0 0])
		line(h_ax2, [t t], h_ax2.YLim, 'Color', [0.9 0 0])
	elseif strcmpi(data.event(e_cnt).code, 'extend')
		t = data.event(e_cnt).latency / data.srate;
		line(h_ax1, [t t], h_ax1.YLim, 'Color', [0 0.9 0])
		line(h_ax2, [t t], h_ax2.YLim, 'Color', [0 0.9 0])
	end
		
end



keyboard
