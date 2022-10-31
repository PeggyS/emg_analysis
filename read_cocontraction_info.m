function read_cocontraction_info(app)

% get default save path
analysis_path = get_save_path(app, false);
if analysis_path ~= 0
	file_list = regexpdir(analysis_path,'(.*_cocontraction\.txt)$');
	if length(file_list) < 1
		disp('found no *_cocontraction.txt files.')
		return;
	end

	for f_cnt = 1:length(file_list)
		file_name = file_list{f_cnt};

		if exist(file_name, 'file') ~= 2
			return
		end

		% get muscle from file name
		[~, fname, ~] = fileparts(file_name);
		muscle = strrep(fname, '_cocontraction', '');

		% read in file, parse for the info
		keywords = {'begin_t' 'end_t' 'begin_angle' 'end_angle' 'bicep_auc' 'tricep_auc' ...
			'antagonist_agonist_ratio' 'analysis_by' 'analysis_date'};

		defaults = {[], [], [], [], [], [], [], '', ''};

		try
			paramscell = readparamfile(file_name, keywords, defaults);
		catch ME
			% keyboard
			rethrow(ME)
		end

		app.cocontraction_data.begin_t       = paramscell{1};
		app.cocontraction_data.end_t         = paramscell{2};
		app.cocontraction_data.begin_angle     = paramscell{3};
		app.cocontraction_data.end_angle       = paramscell{4};
		app.cocontraction_data.bicep_auc         = paramscell{5};
		app.cocontraction_data.tricep_auc     = paramscell{6};
		app.cocontraction_data.antagonist_agonist_ratio     = paramscell{7};		
		app.cocontraction_data.analysis_by   = paramscell{8};
		app.cocontraction_data.analysis_date = paramscell{9};

	end
end % analysis path exists
return
end