


% read in file, parse for the info
keywords = {'begin_t' 'end_t' 'begin_angle' 'end_angle' 'bicep_auc' 'tricep_auc' ...
	'antagonist_agonist_ratio' 'analysis_by' 'analysis_date'};

defaults = {[], [], [], [], [], [], [], '', ''};



file_name = '/Users/peggy/Library/CloudStorage/Box-Box/myopro_merit/analysis/emg/s3101uemp/Session05/20221027_0005_isometric_tricep_cocontraction_info.txt';
paramscell = readparamfile(file_name, keywords, defaults);
s1.begin_t       = paramscell{1};
s1.end_t         = paramscell{2};
s1.begin_angle     = paramscell{3};
s1.end_angle       = paramscell{4};
s1.bicep_auc         = paramscell{5};
s1.tricep_auc     = paramscell{6};
s1.antagonist_agonist_ratio     = paramscell{7};		
s1.analysis_by   = paramscell{8};
s1.analysis_date = paramscell{9};


file_name = '/Users/peggy/Library/CloudStorage/Box-Box/myopro_merit/analysis/emg/s3101uemp/week04/20221122_0007_isometric_tricep_cocontraction_info.txt';
paramscell = readparamfile(file_name, keywords, defaults);
s2.begin_t       = paramscell{1};
s2.end_t         = paramscell{2};
s2.begin_angle     = paramscell{3};
s2.end_angle       = paramscell{4};
s2.bicep_auc         = paramscell{5};
s2.tricep_auc     = paramscell{6};
s2.antagonist_agonist_ratio     = paramscell{7};		
s2.analysis_by   = paramscell{8};
s2.analysis_date = paramscell{9};


figure
h_ax = axes;
hold on
% s1  
s1 = plot_subj_values(s1, 1);
% s2 
s2 = plot_subj_values(s2, 2);


title( 's3101 - Isometric Extension')
ylabel('Bicep AUC / Tricep AUC')
xlabel('Session')
h_ax.XTick = 1:2;
h_ax.XTickLabel = {'Before Session05' 'After Session09'};


[h, p] = ttest2(s1.antagonist_agonist_ratio, s2.antagonist_agonist_ratio)

% --------------------------------
function subj_struct = plot_subj_values(subj_struct, x_col)

plot(x_col*ones(1,length(subj_struct.antagonist_agonist_ratio)),subj_struct.antagonist_agonist_ratio, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
m1 = mean(subj_struct.antagonist_agonist_ratio);
sd1 = std(subj_struct.antagonist_agonist_ratio);
line(x_col-1+[0.75 1.25], [m1 m1])
line(x_col-1+[0.75 1.25], [m1+sd1 m1+sd1], 'Linestyle', '--')
line(x_col-1+[0.75 1.25], [m1-sd1 m1-sd1], 'Linestyle', '--')

return
end