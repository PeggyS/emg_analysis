


% read in file, parse for the info
keywords = {'begin_t' 'end_t' 'begin_angle' 'end_angle' 'bicep_auc' 'tricep_auc' ...
	'antagonist_agonist_ratio' 'analysis_by' 'analysis_date'};

defaults = {[], [], [], [], [], [], [], '', ''};


%/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/s3101uemp/week04/20221122_0004_extend_cocontraction_info.txt
file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/s3101uemp/week01/20220927_0005_extend_cocontraction_info.txt';
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


file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/s3101uemp/week04/20221122_0004_extend_cocontraction_info_last10trials.txt';
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
title( 's3101 - Extension Movement')
ylabel('Bicep AUC / Tricep AUC')
xlabel('Session')
h_ax.XTick = 1:2;
h_ax.XTickLabel = {'Before Session01' 'After Session09'};
disp('all angle movements')
disp('ttest2:')
[h, p] = ttest2(s1.antagonist_agonist_ratio, s2.antagonist_agonist_ratio)
% p= 0.0566

disp('vartest2:')
[h,p] = vartest2(s1.antagonist_agonist_ratio, s2.antagonist_agonist_ratio)
% p = 0.0345


figure
h_ax = axes;
hold on
s1 = plot_subj_angles(s1, 1);
s2 = plot_subj_angles(s2, 2);
title( 's3101 - Extension Movement')
ylabel('Elbow Angle Excursion (°)')
xlabel('Session')
h_ax.XTick = 1:2;
h_ax.XTickLabel = {'Before Session01' 'After Session09'};

disp('ttest2:')
[h, p] = ttest2(s1.angle_excursion, s2.angle_excursion)
% p= 1.6187e-08

disp('vartest2:')
[h,p] = vartest2(s1.angle_excursion, s2.angle_excursion)
% p = 0.0267

figure
x = s1.angle_excursion;
y = s1.antagonist_agonist_ratio;
scatterplot_labeled(x, y)
hold on
x = s2.angle_excursion;
y = s2.antagonist_agonist_ratio;
h_line = scatterplot_labeled(x, y)
ylabel('CCI')
xlabel('Angle Excursion (°)')
% correlation
disp('after session09 cci-angle correlation')
[r,p]=corr(s2.angle_excursion', s2.antagonist_agonist_ratio')
% r = 0.1311
% p = 0.7181

% exclude values when elbow angle excursion was > 0
figure
h_ax = axes;
hold on
% s1  
s1 = plot_subj_values(s1, 1, 'exclude');
% s2 
s2 = plot_subj_values(s2, 2, 'exclude');
title( 's3101 - Extension Movement - exclude incorrect movement')
ylabel('Bicep AUC / Tricep AUC')
xlabel('Session')
h_ax.XTick = 1:2;
h_ax.XTickLabel = {'Before Session01' 'After Session09'};

disp('excluding incorrect direction of elbow movement')
disp('ttest2:')
[h, p] = ttest2(s1.antagonist_agonist_ratio(s1.angle_excursion<=0), ...
	s2.antagonist_agonist_ratio(s2.angle_excursion<=0))
% p= 1.3575e-04

disp('vartest2:')
[h,p] = vartest2(s1.antagonist_agonist_ratio(s1.angle_excursion<=0), ...
	s2.antagonist_agonist_ratio(s2.angle_excursion<=0))
% p = 0.0258



% --------------------------------
function subj_struct = plot_subj_values(subj_struct, x_col, exc_str)

if exist('exc_str', 'var') && contains(exc_str, 'exclude') == 1
	angle_excursion = subj_struct.end_angle - subj_struct.begin_angle;
	msk = find(angle_excursion <= 0);
	data = subj_struct.antagonist_agonist_ratio(msk);
else
	data = subj_struct.antagonist_agonist_ratio;
end
plot(x_col*ones(1,length(data)),data, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
m1 = mean(data);
sd1 = std(data);
line(x_col-1+[0.75 1.25], [m1 m1])
line(x_col-1+[0.75 1.25], [m1+sd1 m1+sd1], 'Linestyle', '--')
line(x_col-1+[0.75 1.25], [m1-sd1 m1-sd1], 'Linestyle', '--')

return
end

function subj_struct = plot_subj_angles(subj_struct, x_col)
subj_struct.angle_excursion = subj_struct.end_angle - subj_struct.begin_angle;
plot(x_col*ones(1,length(subj_struct.angle_excursion)),subj_struct.angle_excursion, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
m1 = mean(subj_struct.angle_excursion);
sd1 = std(subj_struct.angle_excursion);
line(x_col-1+[0.75 1.25], [m1 m1])
line(x_col-1+[0.75 1.25], [m1+sd1 m1+sd1], 'Linestyle', '--')
line(x_col-1+[0.75 1.25], [m1-sd1 m1-sd1], 'Linestyle', '--')

return
end