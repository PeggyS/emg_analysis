function read_resting_emg_info(app)

% get default save path
analysis_path = get_save_path(app, false);
if analysis_path ~= 0
	file_list = regexpdir(analysis_path,'(^.*_resting_emg\.txt)$', false);
	if length(file_list) < 1
		disp('found no *_resting_emg.txt files.')
		return;
	end

	for f_cnt = 1:length(file_list)
		file_name = file_list{f_cnt};

		if exist(file_name, 'file') ~= 2
			return
		end

		% get muscle from file name
		[~, fname, ~] = fileparts(file_name);
		muscle = strrep(fname, '_resting_emg', '');

		% read in file, parse for the info
		keywords = {'begin_t' 'end_t' 'rms_value' 'analysis_by' 'analysis_date'};

		defaults = {[], [], [], '', ''};

		try
			paramscell = readparamfile(file_name, keywords, defaults);
		catch ME
			% keyboard
			rethrow(ME)
		end

		app.resting_emg.(muscle).begin_t       = paramscell{1};
		app.resting_emg.(muscle).end_t         = paramscell{2};
		app.resting_emg.(muscle).rms_value     = paramscell{3};
		app.resting_emg.(muscle).analysis_by   = paramscell{4};
		app.resting_emg.(muscle).analysis_date = paramscell{5};

	end
end % analysis path exists
return
end