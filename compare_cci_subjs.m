function compare_cci_subjs

file_list = {'/Users/peggy/Documents/BrainLab/myopro_acute/Analysis/emg/c3004armp/session2/20230327_0004_bend_extend_cocontraction_info.txt' ...
	'/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/s3102uemp/week04/20221219_0004_bend_extend_cocontraction_info.txt' ...
	'/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/s3103uemp/week04/20230119_0004_bend_extend_cocontraction_info.txt'};

for f_cnt = 1:length(file_list)
	file_name = file_list{f_cnt};
	new_data = comb_read_cocontraction_info(file_name);

	tmp = regexp(file_name, '(s|c)\d{4}', 'match');
	new_data.subj = tmp{:};

	data(f_cnt) = new_data;

end

d1 = data(1).antagonist_agonist_ratio;
d2 = data(2).antagonist_agonist_ratio;
d3 = data(3).antagonist_agonist_ratio;
grp1 = repmat({data(1).subj}, 1, length(d1));
grp2 = repmat({data(2).subj}, 1, length(d2));
grp3 = repmat({data(3).subj}, 1, length(d3));

[p, tbl, stats] = anova1([d1 d2 d3], [grp1 grp2 grp3])
figure
[c,~,~,gnames] = multcompare(stats)

return
end
%{
A one-way ANOVA was performed to compare the CCI between subjects.


A one-way ANOVA revealed that there was a statistically significant difference between 
at least two subjects (F(2,54) = 39.2, p = 3e-11).


Test for multiple comparisons using tukey-kramer critical value found that the mean 
value of CCI was significantly different between each of the subjects (p <0.001).
%}

