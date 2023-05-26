function cocontraction_data = comb_read_cocontraction_info(file_name)

cocontraction_data = struct();

if exist(file_name, 'file') ~= 2
	disp(['invalid file: ' file_name])
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

cocontraction_data.begin_t       = paramscell{1};
cocontraction_data.end_t         = paramscell{2};
cocontraction_data.begin_angle     = paramscell{3};
cocontraction_data.end_angle       = paramscell{4};
cocontraction_data.bicep_auc         = paramscell{5};
cocontraction_data.tricep_auc     = paramscell{6};
cocontraction_data.antagonist_agonist_ratio     = paramscell{7};
cocontraction_data.analysis_by   = paramscell{8};
cocontraction_data.analysis_date = paramscell{9};

return
end