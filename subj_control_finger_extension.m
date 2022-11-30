


% read in file, parse for the info
keywords = {'begin_t' 'end_t' 'begin_angle' 'end_angle' 'flexor_auc' 'extensor_auc' ...
	'antagonist_agonist_ratio' 'analysis_by' 'analysis_date'};

defaults = {[], [], [], [], [], [], [], '', ''};


file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/s3101uemp/week04/20221122_0006_finger_extension_cocontraction_info.txt';
paramscell = readparamfile(file_name, keywords, defaults);
s1.begin_t       = paramscell{1};
s1.end_t         = paramscell{2};
s1.begin_angle     = paramscell{3};
s1.end_angle       = paramscell{4};
s1.flexor_auc         = paramscell{5};
s1.extensor_auc     = paramscell{6};
s1.antagonist_agonist_ratio     = paramscell{7};		
s1.analysis_by   = paramscell{8};
s1.analysis_date = paramscell{9};


file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/s3103uemp/week01/20221116_0006_finger_extension_cocontraction_info.txt';
paramscell = readparamfile(file_name, keywords, defaults);
s2.begin_t       = paramscell{1};
s2.end_t         = paramscell{2};
s2.begin_angle     = paramscell{3};
s2.end_angle       = paramscell{4};
s2.flexor         = paramscell{5};
s2.extensor     = paramscell{6};
s2.antagonist_agonist_ratio     = paramscell{7};		
s2.analysis_by   = paramscell{8};
s2.analysis_date = paramscell{9};

file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/c2795tdvg/session02/20221117_0004_finger_extension_cocontraction_info.txt';
paramscell = readparamfile(file_name, keywords, defaults);
c1.begin_t       = paramscell{1};
c1.end_t         = paramscell{2};
c1.begin_angle     = paramscell{3};
c1.end_angle       = paramscell{4};
c1.flexor_auc         = paramscell{5};
c1.extensor_auc     = paramscell{6};
c1.antagonist_agonist_ratio     = paramscell{7};		
c1.analysis_by   = paramscell{8};
c1.analysis_date = paramscell{9};


file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/c2798tdvg/session01/20221117_0005_finger_extension_cocontraction_info.txt';
paramscell = readparamfile(file_name, keywords, defaults);
c2.begin_t       = paramscell{1};
c2.end_t         = paramscell{2};
c2.begin_angle     = paramscell{3};
c2.end_angle       = paramscell{4};
c2.flexor         = paramscell{5};
c2.extensor     = paramscell{6};
c2.antagonist_agonist_ratio     = paramscell{7};		
c2.analysis_by   = paramscell{8};
c2.analysis_date = paramscell{9};


figure
h_ax = axes;
hold on
% s1  
s1 = plot_subj_values(s1, 1);
% s2 
s2 = plot_subj_values(s2, 2);
% c1  
c1 = plot_subj_values(c1, 3);
% c2 
c2 = plot_subj_values(c2, 4);
title( 'Finger Extension cocontraction')
ylabel('Flexor AUC / Extensor AUC')
xlabel('Subject')
h_ax.XTick = 1:4;
h_ax.XTickLabel = {'s3101 week04' 's3103 week01' 'c2795 sess2' 'c2798 sess1'};

%  cci stats
x_vector = [c1.antagonist_agonist_ratio'; 
			c2.antagonist_agonist_ratio';
			s1.antagonist_agonist_ratio';
			s2.antagonist_agonist_ratio']; 
grp = [repmat({'c2795'},1,length(c1.antagonist_agonist_ratio)) ...
	   repmat({'c2798'},1,length(c2.antagonist_agonist_ratio)) ...
	   repmat({'s3101'},1,length(s1.antagonist_agonist_ratio)) ...
	   repmat({'s3103'},1,length(s2.antagonist_agonist_ratio)) ]';
% [p, anovatab, stats] = kruskalwallis(x_vector, grp)
[p, anovatab, stats] = anova1(x_vector, grp)
figure
comp = multcompare(stats)


% angle
figure
h_ax = axes;
hold on
s1 = plot_subj_angles(s1, 1);
s2 = plot_subj_angles(s2, 2);
c1 = plot_subj_angles(c1, 3);
c2 = plot_subj_angles(c2, 4);
title( 'Finger Extension Angles')
ylabel('Digit 2 MCP Angle (°)')
xlabel('Subject')
h_ax.XTick = 1:4;
h_ax.XTickLabel = {'s3101 week04' 's3103 week01' 'c2795 sess2' 'c2798 sess1'};
%  angle stats
x_vector = [c1.angle_excursion'; 
			c2.angle_excursion';
			s1.angle_excursion';
			s2.angle_excursion']; 
grp = [repmat({'c2795'},1,length(c1.angle_excursion)) ...
	   repmat({'c2798'},1,length(c2.angle_excursion)) ...
	   repmat({'s3101'},1,length(s1.angle_excursion)) ...
	   repmat({'s3103'},1,length(s2.angle_excursion)) ]';
% [p, anovatab, stats] = kruskalwallis(x_vector, grp)
[p, anovatab, stats] = anova1(x_vector, grp)
figure
comp = multcompare(stats)

% angle vs cci
figure
h_ax = axes;
hold on
scatterplot_labeled(c1.angle_excursion, c1.antagonist_agonist_ratio);
scatterplot_labeled(c2.angle_excursion, c2.antagonist_agonist_ratio);
scatterplot_labeled(s1.angle_excursion, s1.antagonist_agonist_ratio);
xlabel('Angle excursion (°)')
ylabel('CCI')
legend({'c2795', 'c2798', 's3101'})
title('Finger extension - CCI vs Angle')
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