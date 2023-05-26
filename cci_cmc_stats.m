function cci_cmc_stats(file_name)

data = readtable(file_name);

% split data into stroke & control
s_data = data(contains(data.subject, 's'), :);
c_data = data(contains(data.subject, 'c'), :);


var_list = {'cci_mean' 'c_ipsi_bicep_alpha_area'    'c_ipsi_bicep_beta_area' ...
	'c_ipsi_bicep_low_gamma_area'    'c_ipsi_bicep_high_gamma_area' ...
	'c_contra_bicep_alpha_area'    'c_contra_bicep_beta_area'    ...
	'c_contra_bicep_low_gamma_area'    'c_contra_bicep_high_gamma_area' ...
	'c_ipsi_tricep_alpha_area'    'c_ipsi_tricep_beta_area' ...
	'c_ipsi_tricep_low_gamma_area'    'c_ipsi_tricep_high_gamma_area' ...
	'c_contra_tricep_alpha_area'    'c_contra_tricep_beta_area' ...
	'c_contra_tricep_low_gamma_area'    'c_contra_tricep_high_gamma_area' ...
	'bicep_tricep_alpha_area'    'bicep_tricep_beta_area' ...
	'bicep_tricep_low_gamma_area'    'bicep_tricep_high_gamma_area'};

out_tbl = cell2table(var_list', 'VariableNames', {'measure'});

% ranksum test for all variables between groups
for v_cnt = 1:height(out_tbl)
	var = out_tbl.measure{v_cnt};
	out_tbl.ranksum_p(v_cnt) = ranksum(s_data.(var), c_data.(var));
end

% correlation between cci & each coherence
for r_cnt = 1:height(out_tbl)
	var = out_tbl.measure{r_cnt};
	[spearman_rho, spearman_p] = corr(data.cci_mean, data.(var), 'type', 'Spearman', 'rows', 'all');
	out_tbl.spearman_rho(r_cnt) = spearman_rho;
	out_tbl.spearman_p(r_cnt) = spearman_p;
end

% save 
[pname, ~, ~] = fileparts(file_name);

fname = ['isometric_ext_stats_' datestr(now, 'yyyymmdd') '.csv']; %#ok<TNOW1,DATST> 
path_filename = fullfile(pname, fname);
writetable(out_tbl, path_filename);

return
end