


% read in file, parse for the info
keywords = {'begin_t' 'end_t' 'begin_angle' 'end_angle' 'bicep_auc' 'tricep_auc' ...
	'antagonist_agonist_ratio' 'analysis_by' 'analysis_date'};

defaults = {[], [], [], [], [], [], [], '', ''};



file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/c2797tdvg/session03/20221101_0003_isometric_tricep_cocontraction_info.txt';
paramscell = readparamfile(file_name, keywords, defaults);
c1_extend.begin_t       = paramscell{1};
c1_extend.end_t         = paramscell{2};
c1_extend.begin_angle     = paramscell{3};
c1_extend.end_angle       = paramscell{4};
c1_extend.bicep_auc         = paramscell{5};
c1_extend.tricep_auc     = paramscell{6};
c1_extend.antagonist_agonist_ratio     = paramscell{7};		
c1_extend.analysis_by   = paramscell{8};
c1_extend.analysis_date = paramscell{9};

file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/c2795tdvg/Session01/20221107_0002_isometric_tricep_cocontraction_info.txt';
paramscell = readparamfile(file_name, keywords, defaults);
c2_extend.begin_t       = paramscell{1};
c2_extend.end_t         = paramscell{2};
c2_extend.begin_angle     = paramscell{3};
c2_extend.end_angle       = paramscell{4};
c2_extend.bicep_auc         = paramscell{5};
c2_extend.tricep_auc     = paramscell{6};
c2_extend.antagonist_agonist_ratio     = paramscell{7};		
c2_extend.analysis_by   = paramscell{8};
c2_extend.analysis_date = paramscell{9};


file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/s3101uemp/Session05/20221027_0005_isometric_tricep_cocontraction_info.txt';
paramscell = readparamfile(file_name, keywords, defaults);
s1_extend.begin_t       = paramscell{1};
s1_extend.end_t         = paramscell{2};
s1_extend.begin_angle     = paramscell{3};
s1_extend.end_angle       = paramscell{4};
s1_extend.bicep_auc         = paramscell{5};
s1_extend.tricep_auc     = paramscell{6};
s1_extend.antagonist_agonist_ratio     = paramscell{7};		
s1_extend.analysis_by   = paramscell{8};
s1_extend.analysis_date = paramscell{9};



file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/s3102uemp/session00a/20221107_0003_isometric_tricep_cocontraction_info.txt';
paramscell = readparamfile(file_name, keywords, defaults);
s2_extend.begin_t       = paramscell{1};
s2_extend.end_t         = paramscell{2};
s2_extend.begin_angle     = paramscell{3};
s2_extend.end_angle       = paramscell{4};
s2_extend.bicep_auc         = paramscell{5};
s2_extend.tricep_auc     = paramscell{6};
s2_extend.antagonist_agonist_ratio     = paramscell{7};		
s2_extend.analysis_by   = paramscell{8};
s2_extend.analysis_date = paramscell{9};

% bend 
figure
h_ax = axes;
hold on
plot(ones(1,length(c1_extend.antagonist_agonist_ratio)),c1_extend.antagonist_agonist_ratio, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
m1 = mean(c1_extend.antagonist_agonist_ratio);
sd1 = std(c1_extend.antagonist_agonist_ratio);
line([0.75 1.25], [m1 m1])
line([0.75 1.25], [m1+sd1 m1+sd1], 'Linestyle', '--')
line([0.75 1.25], [m1-sd1 m1-sd1], 'Linestyle', '--')

plot(2*ones(1,length(c2_extend.antagonist_agonist_ratio)),c2_extend.antagonist_agonist_ratio, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
m2 = mean(c2_extend.antagonist_agonist_ratio);
sd2 = std(c2_extend.antagonist_agonist_ratio);
line([1.75 2.25], [m2 m2])
line([1.75 2.25], [m2+sd2 m2+sd2], 'Linestyle', '--')
line([1.75 2.25], [m2-sd2 m2-sd2], 'Linestyle', '--')

plot(3*ones(1,length(s1_extend.antagonist_agonist_ratio)),s1_extend.antagonist_agonist_ratio, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
m3 = mean(s1_extend.antagonist_agonist_ratio);
sd3 = std(s1_extend.antagonist_agonist_ratio);
line([2.75 3.25], [m3 m3])
line([2.75 3.25], [m3+sd3 m3+sd3], 'Linestyle', '--')
line([2.75 3.25], [m3-sd3 m3-sd3], 'Linestyle', '--')

plot(4*ones(1,length(s2_extend.antagonist_agonist_ratio)),s2_extend.antagonist_agonist_ratio, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
m4 = mean(s2_extend.antagonist_agonist_ratio);
sd4 = std(s2_extend.antagonist_agonist_ratio);
line([3.75 4.25], [m4 m4])
line([3.75 4.25], [m4+sd4 m4+sd4], 'Linestyle', '--')
line([3.75 4.25], [m4-sd4 m4-sd4], 'Linestyle', '--')

title( 'Isometric Extension')
ylabel('Bicep AUC / Tricep AUC')
xlabel('Subject')
h_ax.XTick = [1:4];
h_ax.XTickLabel = {'C2797' 'C2795' 'S3101' 'S3102'};

x_vector = [c1_extend.antagonist_agonist_ratio'; c2_extend.antagonist_agonist_ratio'; 
			s1_extend.antagonist_agonist_ratio'; s2_extend.antagonist_agonist_ratio']; 
grp = [repmat({'c2797'},1,length(c1_extend.antagonist_agonist_ratio)) ...
	repmat({'c2795'},1,length(c2_extend.antagonist_agonist_ratio)) ...
	repmat({'S3101'},1,length(s1_extend.antagonist_agonist_ratio)) ...
	repmat({'S3102'},1,length(s2_extend.antagonist_agonist_ratio)) ]';
[p, anovatab, stats] = kruskalwallis(x_vector, grp)
figure
comp = multcompare(stats)


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

[h, p] = ttest2(c1_extend.antagonist_agonist_ratio, s2_extend.antagonist_agonist_ratio)

p_line = line([1 1 2 2], [0.28 0.32 0.32 0.28], 'color', [0 0 0], 'LineWidth', 2);
h_txt = text(1.5, 0.34, '*', 'Fontsize', 40)