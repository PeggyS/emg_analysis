function read_mvc_info(app)

% get default save path
analysis_path = get_save_path(app, false);
if analysis_path ~= 0
	file_list = regexpdir(analysis_path,'(.*_mvcs\.txt)$');
	if length(file_list) < 1
		disp('found no *_mvcs.txt files.')
		return;
	end

	for f_cnt = 1:length(file_list)
		file_name = file_list{f_cnt};

		if exist(file_name, 'file') ~= 2
			return
		end

		% get muscle from file name
		[~, fname, ~] = fileparts(file_name);
		muscle = strrep(fname, '_mvcs', '');

		% read in file, parse for the info
		keywords = {'begin_t' 'end_t' 'rms_value' 'analysis_by' 'analysis_date'};

		defaults = {[], [], [], '', ''};

		try
			paramscell = readparamfile(file_name, keywords, defaults);
		catch ME
			% keyboard
			rethrow(ME)
		end

		app.mvcs.(muscle).begin_t       = paramscell{1};
		app.mvcs.(muscle).end_t         = paramscell{2};
		app.mvcs.(muscle).rms_value     = paramscell{3};
		app.mvcs.(muscle).analysis_by   = paramscell{4};
		app.mvcs.(muscle).analysis_date = paramscell{5};

	end
end % analysis path exists
return
end