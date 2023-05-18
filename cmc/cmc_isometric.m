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
[B_eeg, A_eeg] = butter(5, [low, high], 'bandpass' );

% filter the data
c3_filt = filtfilt(B_eeg, A_eeg, double(data.data(c3_chan_num,:)));

keyboard
