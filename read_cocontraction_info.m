function read_cocontraction_info(app)

% get experiment type
if app.BendOnlyButton.Value == 1
	exp_type = 'bend';
elseif app.ExtendOnlyButton.Value == 1
	exp_type = 'extend';
elseif app.BendExtendButton.Value == 1
	exp_type = 'bend_extend';
elseif app.IsometricBicepButton.Value == 1
	exp_type = 'isometric_bicep';
elseif app.IsometricTricepButton.Value == 1
	exp_type = 'isometric_tricep';
elseif app.FingerExtendButton.Value == 1
	exp_type = 'finger_extend';
else
	error('save_cocontraction_info.m - did not find experiment type')
end


% get default save path
analysis_path = get_save_path(app, false);
if analysis_path ~= 0

	cocon_filename_txt = [exp_type '_cocontraction_info'];

	file_list = regexpdir(analysis_path, ['(.*_' cocon_filename_txt '\.txt)$'], false); % do not look recursively
	if length(file_list) < 1
		disp(['found no *' cocon_filename_txt '.txt files.'])
		return;
	end
	if length(file_list) > 1
		disp(['found more than 1 ' cocon_filename_txt '.txt files.'])
		return;
	end

	file_name = file_list{1};

	if exist(file_name, 'file') ~= 2
		return
	end


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


end % analysis path exists
return
end