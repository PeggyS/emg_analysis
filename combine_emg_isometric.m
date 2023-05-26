function [cc_tbl, coh_tbl] = combine_emg_isometric(top_folder, aff_side_file)


cc_tbl = table(); % co-contraction table
coh_tbl = table(); % coherence table

% file containing affected/measured arm
side_tbl = readtable(aff_side_file);
side_tbl.subject = nominal(side_tbl.subject);

% from top folder, look up one level for 'affected_side.xlsx'

% start at top folder and look for the text files within the hierarchy
f_list = dir(top_folder);

% look for subject folders
for f_cnt = 1:length(f_list)
	tmp = regexp(f_list(f_cnt).name, '(s\d{4}uemp)|(c\d{4}armp)', 'match');
	if ~isempty(tmp)
		subj = tmp{1};
		s_cell = side_tbl.affected_side(side_tbl.subject== subj);
		if ~isempty(s_cell)
			side = s_cell{1};
		else
			side = 'right';
			beep
			fprintf('affected side not found for %s\nUsing right side.\n', subj)
		end
		% search for week# folders
		subj_folder = fullfile(top_folder, subj);
		w_list = dir(subj_folder);
		for w_cnt = 1:length(w_list)
			tmp = regexpi(w_list(w_cnt).name, '(week\d{2})|(session\d{1})', 'match');
			if ~isempty(tmp)
				week = tmp{1};

				% look for files: *._isometric_tricep_cocontraction_info.txt
				% and *.coherence.txt
				week_folder = fullfile(subj_folder, week);
				fc_list = dir(week_folder);
				for fc_cnt = 1:length(fc_list)
					tmp = regexp(fc_list(fc_cnt).name, ...
						'((isometric_tricep_cocontraction_info)|(coherence))\.txt', ...
						'match');
					if ~isempty(tmp)
						file_name = fullfile(week_folder, fc_list(fc_cnt).name);
						f_num = regexp(fc_list(fc_cnt).name, '_(?<f_num>\d{4})_', 'names');
						file_type = tmp{1};
						% found a file, read its info and add to table
						switch file_type
							case 'isometric_tricep_cocontraction_info.txt'
								cc_info = comb_read_cocontraction_info(file_name);
								cc_tbl = add_cc_info_to_table(cc_tbl, cc_info, subj, week, f_num.f_num);
							case 'coherence.txt'
								coh_info = comb_read_coherence_info(file_name);
								coh_tbl = add_coh_info_to_table(coh_tbl, coh_info, subj, week, f_num.f_num, side);
						end
					end
				end
			end
		end
	end
end


% combine coh_tbl and cc_tbl 

% save
fname = [top_folder filesep 'isometric_ext_cci_' datestr(now, 'yyyymmdd') '.csv']; %#ok<TNOW1,DATST> 
writetable(cc_tbl, fname);


fname = [top_folder filesep 'isometric_ext_cmc_imc_' datestr(now, 'yyyymmdd') '.csv']; %#ok<TNOW1,DATST> 
writetable(coh_tbl, fname);

return
end

% --------------------------------------------------------
function coh_tbl = add_coh_info_to_table(coh_tbl, coh_info, subject, week, f_num, side)

% keyboard
switch side
	case 'left'
		contra_fld_prefix = 'c4';
		ipsi_fld_prefix = 'c3';
	case 'right'
		contra_fld_prefix = 'c3';
		ipsi_fld_prefix = 'c4';
end
% change the coh_info struct fields from c3 & c4 to c_contra & c_ipsi
fld_names = fieldnames(coh_info);
for f_cnt = 1:length(fld_names)
	old_field = fld_names{f_cnt};
	new_field = old_field;
	new_field = strrep(new_field, ipsi_fld_prefix, 'c_ipsi');
	new_field = strrep(new_field, contra_fld_prefix, 'c_contra');
	new_struct.(new_field) = coh_info.(old_field);
end

tbl = struct2table(new_struct);
tbl.subject = subject;
tbl.session = week;
tbl.file_num = f_num;
tbl.side = {side};

if isempty(coh_tbl)
	coh_tbl = tbl;
else
	coh_tbl = vertcat(coh_tbl, tbl);
end

return
end


% ----------------------------------------------------------
function cc_tbl = add_cc_info_to_table(cc_tbl, cc_info, subj, session, f_num)

cci_mean = mean(cc_info.antagonist_agonist_ratio);
cci_sd = std(cc_info.antagonist_agonist_ratio);
cci_n = length(cc_info.antagonist_agonist_ratio);

tbl = table({subj}, {session}, {f_num}, cci_mean, cci_sd, cci_n, 'VariableNames', ...
	{'subject', 'session', 'file_num', 'cci_mean', 'cci_sd', 'cci_n'});

if isempty(cc_tbl)
	cc_tbl = tbl;
else
	cc_tbl = vertcat(cc_tbl, tbl);
end

return
end