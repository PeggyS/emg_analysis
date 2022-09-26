function save_loc = get_save_path(app, create)

% create = true or false, to create the folder if it does not exist,
% default = true
if nargin < 2
	create = true;
end

[save_loc, ~, ~] = fileparts(app.FileNameLabel.Text);
% if the current directory has '/data/' in it then change it
% '/analysis/' to save the output there
if contains(save_loc, [filesep 'data' filesep], 'IgnoreCase', true)
	save_loc = strrep(lower(save_loc), [filesep 'data' filesep], [filesep 'analysis' filesep]);
	% replace 'emg-nirs-eeg' with 'emg'
	save_loc = strrep(save_loc, 'emg-nirs-eeg', 'emg');
	% ask to create the folder if it doesn't exist
	if ~exist(save_loc, 'dir') 
		if create == true
			ButtonName = questdlg(['Create new directory: ' save_loc ' ?'], ...
				'Create new directory', ...
				'Yes', 'No', 'Yes');
			if strcmp(ButtonName, 'Yes')
				[success, msg, msg_id] = mkdir(save_loc); %#ok<ASGLU>
			else
				disp('Choose where to save output')
				save_loc = uigetdir();
			end
		else
			% location exists, but don't create it
			save_loc = 0;
			return
		end
	end
end

return
end