function cci_cmc_stats(file_name)

data = readtable(file_name);

% split data into stroke & control
s_data = data(contains(data.subject, 's'), :);
c_data = data(contains(data.subject, 'c'), :);


% var_list = {'extension_move_cci_mean' 'c_ipsi_bicep_alpha_area'    'c_ipsi_bicep_beta_area' ...
% 	'c_ipsi_bicep_low_gamma_area'    'c_ipsi_bicep_high_gamma_area' ...
% 	'c_contra_bicep_alpha_area'    'c_contra_bicep_beta_area'    ...
% 	'c_contra_bicep_low_gamma_area'    'c_contra_bicep_high_gamma_area' ...
% 	'c_ipsi_tricep_alpha_area'    'c_ipsi_tricep_beta_area' ...
% 	'c_ipsi_tricep_low_gamma_area'    'c_ipsi_tricep_high_gamma_area' ...
% 	'c_contra_tricep_alpha_area'    'c_contra_tricep_beta_area' ...
% 	'c_contra_tricep_low_gamma_area'    'c_contra_tricep_high_gamma_area' ...
% 	'bicep_tricep_alpha_area'    'bicep_tricep_beta_area' ...
% 	'bicep_tricep_low_gamma_area'    'bicep_tricep_high_gamma_area'};
var_list = {'extension_move_cci_mean' 'c_ipsi_bicep_alpha_mean'    'c_ipsi_bicep_beta_mean' ...
	'c_ipsi_bicep_low_gamma_mean'    'c_ipsi_bicep_high_gamma_mean' ...
	'c_contra_bicep_alpha_mean'    'c_contra_bicep_beta_mean'    ...
	'c_contra_bicep_low_gamma_mean'    'c_contra_bicep_high_gamma_mean' ...
	'c_ipsi_tricep_alpha_mean'    'c_ipsi_tricep_beta_mean' ...
	'c_ipsi_tricep_low_gamma_mean'    'c_ipsi_tricep_high_gamma_mean' ...
	'c_contra_tricep_alpha_mean'    'c_contra_tricep_beta_mean' ...
	'c_contra_tricep_low_gamma_mean'    'c_contra_tricep_high_gamma_mean' ...
	'bicep_tricep_alpha_mean'    'bicep_tricep_beta_mean' ...
	'bicep_tricep_low_gamma_mean'    'bicep_tricep_high_gamma_mean'};

out_tbl = cell2table(var_list', 'VariableNames', {'measure'});

% ranksum test for all variables between groups
for v_cnt = 1:height(out_tbl)
	var = out_tbl.measure{v_cnt};
	out_tbl.ranksum_p(v_cnt) = ranksum(s_data.(var), c_data.(var));
end

% correlation between cci & each coherence
for r_cnt = 1:height(out_tbl)
	var = out_tbl.measure{r_cnt};
	[spearman_rho, spearman_p] = corr(data.extension_move_cci_mean, data.(var), 'type', 'Spearman', 'rows', 'complete');
	out_tbl.all_subjects_spearman_rho(r_cnt) = spearman_rho;
	out_tbl.all_subjects_spearman_p(r_cnt) = spearman_p;

	% for only stroke
	[spearman_rho, spearman_p] = corr(s_data.extension_move_cci_mean, s_data.(var), 'type', 'Spearman', 'rows', 'complete');
	out_tbl.stroke_spearman_rho(r_cnt) = spearman_rho;
	out_tbl.stroke_spearman_p(r_cnt) = spearman_p;

	% for only control
	[spearman_rho, spearman_p] = corr(c_data.extension_move_cci_mean, c_data.(var), 'type', 'Spearman', 'rows', 'complete');
	out_tbl.control_spearman_rho(r_cnt) = spearman_rho;
	out_tbl.control_spearman_p(r_cnt) = spearman_p;

end

% save 
[pname, ~, ~] = fileparts(file_name);

fname = ['extension_move_cci_isometric_cmc_stats' datestr(now, 'yyyymmdd') '.csv']; %#ok<TNOW1,DATST> 
path_filename = fullfile(pname, fname);
writetable(out_tbl, path_filename);

return
end