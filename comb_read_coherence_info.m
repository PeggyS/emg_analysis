function coherence_data = comb_read_coherence_info(file_name)

coherence_data = struct();

if exist(file_name, 'file') ~= 2
	disp(['invalid file: ' file_name])
	return
end


% read in file, parse for the info
keywords = {'c3_bicep_alpha_area' 'c3_bicep_beta_area' 'c3_bicep_low_gamma_area' ...
	'c3_bicep_high_gamma_area' 'c4_bicep_alpha_area' 'c4_bicep_beta_area' ...
	'c4_bicep_low_gamma_area' 'c4_bicep_high_gamma_area' 'c3_tricep_alpha_area' ...
	'c3_tricep_beta_area' 'c3_tricep_low_gamma_area' 'c3_tricep_high_gamma_area' ...
	'c4_tricep_alpha_area' 'c4_tricep_beta_area' 'c4_tricep_low_gamma_area' ...
	'c4_tricep_high_gamma_area' 'bicep_tricep_alpha_area' 'bicep_tricep_beta_area' ...
	'bicep_tricep_low_gamma_area' 'bicep_tricep_high_gamma_area' };

defaults = {[], [], [], [], [], [], [], [], [], [], ...
			[], [], [], [], [], [], [], [], [], []};

try
	paramscell = readparamfile(file_name, keywords, defaults);
catch ME
	% keyboard
	rethrow(ME)
end


coherence_data.c3_bicep_alpha_area       = paramscell{1};
coherence_data.c3_bicep_beta_area       = paramscell{2};
coherence_data.c3_bicep_low_gamma_area       = paramscell{3};
coherence_data.c3_bicep_high_gamma_area       = paramscell{4};
coherence_data.c4_bicep_alpha_area       = paramscell{5};
coherence_data.c4_bicep_beta_area       = paramscell{6};
coherence_data.c4_bicep_low_gamma_area       = paramscell{7};
coherence_data.c4_bicep_high_gamma_area       = paramscell{8};
coherence_data.c3_tricep_alpha_area       = paramscell{9};
coherence_data.c3_tricep_beta_area       = paramscell{10};
coherence_data.c3_tricep_low_gamma_area       = paramscell{11};
coherence_data.c3_tricep_high_gamma_area       = paramscell{12};
coherence_data.c4_tricep_alpha_area       = paramscell{13};
coherence_data.c4_tricep_beta_area       = paramscell{14};
coherence_data.c4_tricep_low_gamma_area       = paramscell{15};
coherence_data.c4_tricep_high_gamma_area       = paramscell{16};
coherence_data.bicep_tricep_alpha_area       = paramscell{17};
coherence_data.bicep_tricep_beta_area       = paramscell{18};
coherence_data.bicep_tricep_low_gamma_area       = paramscell{19};
coherence_data.bicep_tricep_high_gamma_area       = paramscell{20};


return
end