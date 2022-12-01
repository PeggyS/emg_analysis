


% read in file, parse for the info
keywords = {'begin_t' 'end_t' 'begin_angle' 'end_angle' 'bicep_auc' 'tricep_auc' 'motion' ...
	'antagonist_agonist_ratio' 'analysis_by' 'analysis_date'};

defaults = {[], [], [], [], [], [], '', [], '', ''};



file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/c2797tdvg/session03/20221101_0004_bend_extend_cocontraction_info.txt';
paramscell = readparamfile(file_name, keywords, defaults);
c1.begin_t       = paramscell{1};
c1.end_t         = paramscell{2};
c1.begin_angle     = paramscell{3};
c1.end_angle       = paramscell{4};
c1.bicep_auc         = paramscell{5};
c1.tricep_auc     = paramscell{6};
c1.motion     = strsplit(paramscell{7});
c1.antagonist_agonist_ratio     = paramscell{8};		
c1.analysis_by   = paramscell{9};
c1.analysis_date = paramscell{10};

file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/c2798tdvg/Session01/20221117_0004_bend_extend_cocontraction_info.txt';
paramscell = readparamfile(file_name, keywords, defaults);
c2.begin_t       = paramscell{1};
c2.end_t         = paramscell{2};
c2.begin_angle     = paramscell{3};
c2.end_angle       = paramscell{4};
c2.bicep_auc         = paramscell{5};
c2.tricep_auc     = paramscell{6};
c2.motion     = strsplit(paramscell{7});
c2.antagonist_agonist_ratio     = paramscell{8};		
c2.analysis_by   = paramscell{8};
c2.analysis_date = paramscell{10};


file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/s3102uemp/session00a/20221107_0002_bend_extend_cocontraction_info.txt';
paramscell = readparamfile(file_name, keywords, defaults);
s1.begin_t       = paramscell{1};
s1.end_t         = paramscell{2};
s1.begin_angle     = paramscell{3};
s1.end_angle       = paramscell{4};
s1.bicep_auc         = paramscell{5};
s1.tricep_auc     = paramscell{6};
s1.motion     = strsplit(paramscell{7});
s1.antagonist_agonist_ratio     = paramscell{8};		
s1.analysis_by   = paramscell{9};
s1.analysis_date = paramscell{10};



file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/s3103uemp/week01/20221116_0005_bend_extend_cocontraction_info.txt';
paramscell = readparamfile(file_name, keywords, defaults);
s2.begin_t       = paramscell{1};
s2.end_t         = paramscell{2};
s2.begin_angle     = paramscell{3};
s2.end_angle       = paramscell{4};
s2.bicep_auc         = paramscell{5};
s2.tricep_auc     = paramscell{6};
s2.motion     = strsplit(paramscell{7});
s2.antagonist_agonist_ratio     = paramscell{8};		
s2.analysis_by   = paramscell{9};
s2.analysis_date = paramscell{10};

% bend and extend cocontraction
figure 
h_ax = axes;
hold on
% c1 bend 
plot_subj_values(c1, 'bend', 1);
% c1 extend
plot_subj_values(c1, 'extend', 2);
% c2 bend
plot_subj_values(c2, 'bend', 3);
% c2 extend
plot_subj_values(c2, 'extend', 4);
% s1 bend 
plot_subj_values(s1, 'bend', 5);
% s1 extend
plot_subj_values(s1, 'extend', 6);
% s2 bend
plot_subj_values(s2, 'bend', 7);
% s2 extend
plot_subj_values(s2, 'extend', 8);

title( 'Bend-Extend Isolated Movement')
ylabel('CCI')
xlabel('Subject')
h_ax.XTick = 1:8;
h_ax.XTickLabel = {'c2797 Bend' 'c2797 Extend' 'c2798 Bend' 'c2798 Extend' ...
					's3102 Bend' 's3102 Extend' 's3103 Bend' 's3103 Extend'};

% extend only cocontraction 
figure 
h_ax = axes;
hold on
% c1 extend
c1 = plot_subj_values(c1, 'extend', 1);
% c2 extend
c2 = plot_subj_values(c2, 'extend', 2);
% s1 extend
s1 = plot_subj_values(s1, 'extend', 3);
% s2 extend
s2 = plot_subj_values(s2, 'extend', 4);

title( 'Extend Isolated Movement')
ylabel('CCI')
xlabel('Subject')
h_ax.XTick = 1:8;
h_ax.XTickLabel = {'c2797' 'c2798' 's3102' 's3103'};

% extend cci stats
x_vector = [c1.extend_data'; 
			c2.extend_data';
			s1.extend_data';
			s2.extend_data']; 
grp = [repmat({'c2797'},1,length(c1.extend_data)) ...
	   repmat({'c2798'},1,length(c2.extend_data)) ...
	   repmat({'s3102'},1,length(s1.extend_data)) ...
	   repmat({'s3103'},1,length(s2.extend_data)) ]';
% [p, anovatab, stats] = kruskalwallis(x_vector, grp)
[p, anovatab, stats] = anova1(x_vector, grp)
figure
comp = multcompare(stats)



% 4 subjects bar chart
figure
h_ax = axes;

x = 1:4;
y = [mean(c1.extend_data) mean(c2.extend_data) mean(s2.extend_data) mean(s1.extend_data)];
bar(x,y)
hold on
errlow = [std(c1.extend_data) std(c2.extend_data) std(s2.extend_data) std(s1.extend_data)];
errhigh = [std(c1.extend_data) std(c2.extend_data) std(s2.extend_data) std(s1.extend_data)];
er = errorbar(x,y,errlow,errhigh);    
er.Color = [0 0 0];                            
er.LineStyle = 'none'; 
er.LineWidth = 4;

h_ax.XTick = 1:4;
h_ax.XTickLabel = {'C 1' 'C 2' 'S 1' 'S 2'};
h_ax.YLim = [0 0.8];
h_ax.LineWidth = 3;
h_ax.FontSize = 30;
h_ax.FontWeight = 'bold';
box off;
ylabel('CCI')

% sig difference lines/labels
p12_line = line([1 1 2 2], [0.17 0.22 0.22 0.17], 'color', [0 0 0], 'LineWidth', 4);
ph_3_line = line([1.5 1.5 3 3], [0.4 0.45 0.45 0.4], 'color', [0 0 0], 'LineWidth', 4); 
h_txt = text(2.25, 0.47, '*', 'Fontsize', 60, 'HorizontalAlignment', 'center', 'FontWeight', 'bold');

p34_line = line([3 3 4 4], [0.55 0.6 0.6 0.55], 'color', [0 0 0], 'LineWidth', 4); 
h_txt = text(3.5, 0.62, '**', 'Fontsize', 60, 'HorizontalAlignment', 'center', 'FontWeight', 'bold');

ph4_line = line([1.5 1.5 4 4], [0.65 0.7 0.7 0.65], 'color', [0 0 0], 'LineWidth', 4); 
h_txt = text(2.5, 0.72, '***', 'Fontsize', 60, 'HorizontalAlignment', 'center', 'FontWeight', 'bold');
keyboard


% figure with just c2797 and s3102
figure
h_ax = axes;

x = [1 2];
y = [m1 m4];
bar(x, y)
hold on

errlow = [sd1 sd4];
errhigh = [sd1 sd4];
er = errorbar(x,y,errlow,errhigh);    
er.Color = [0 0 0];                            
er.LineStyle = 'none'; 
er.LineWidth = 2;

ylabel('Bicep AUC / Tricep AUC')
h_ax.XTick = [1:2];
h_ax.XTickLabel = {'Healthy' 'Stroke'};
h_ax.YLim = [0 0.37];
h_ax.LineWidth = 1;
h_ax.FontSize = 16;

[h, p] = ttest2(c1.antagonist_agonist_ratio, s2.antagonist_agonist_ratio)

p_line = line([1 1 2 2], [0.28 0.32 0.32 0.28], 'color', [0 0 0], 'LineWidth', 2);
h_txt = text(1.5, 0.34, '*', 'Fontsize', 40)


% 20221109 - c1 and s1 figures and numbers are in the current version of
% the grant

[h, p] = ttest2(c1.antagonist_agonist_ratio, s1.antagonist_agonist_ratio)

% --------------------------------
function subj_struct = plot_subj_values(subj_struct, motion_str, x_col)
msk = contains(subj_struct.motion, motion_str);
var_str = [motion_str '_data'];
subj_struct.(var_str) = subj_struct.antagonist_agonist_ratio(msk);
plot(x_col*ones(1,length(subj_struct.(var_str))),subj_struct.(var_str), 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
m1 = mean(subj_struct.(var_str));
sd1 = std(subj_struct.(var_str));
line(x_col-1+[0.75 1.25], [m1 m1])
line(x_col-1+[0.75 1.25], [m1+sd1 m1+sd1], 'Linestyle', '--')
line(x_col-1+[0.75 1.25], [m1-sd1 m1-sd1], 'Linestyle', '--')

return
end