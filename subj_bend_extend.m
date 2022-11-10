


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

file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/c2795tdvg/Session01/20221107_0003_bend_extend_cocontraction_info.txt';
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



% file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/s3102uemp/session00a/20221107_0003_isometric_tricep_cocontraction_info.txt';
% paramscell = readparamfile(file_name, keywords, defaults);
% s2_extend.begin_t       = paramscell{1};
% s2_extend.end_t         = paramscell{2};
% s2_extend.begin_angle     = paramscell{3};
% s2_extend.end_angle       = paramscell{4};
% s2_extend.bicep_auc         = paramscell{5};
% s2_extend.tricep_auc     = paramscell{6};
% s2_extend.antagonist_agonist_ratio     = paramscell{7};		
% s2_extend.analysis_by   = paramscell{8};
% s2_extend.analysis_date = paramscell{9};


figure
h_ax = axes;
hold on
% c1 bend 
bend_msk = contains(c1.motion, 'bend');
c1.bend_data = c1.antagonist_agonist_ratio(bend_msk);
plot(ones(1,length(c1.bend_data)),c1.bend_data, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
m1 = mean(c1.bend_data);
sd1 = std(c1.bend_data);
line([0.75 1.25], [m1 m1])
line([0.75 1.25], [m1+sd1 m1+sd1], 'Linestyle', '--')
line([0.75 1.25], [m1-sd1 m1-sd1], 'Linestyle', '--')

% c1 extend
extend_msk = contains(c1.motion, 'extend');
c1.extend_data = c1.antagonist_agonist_ratio(extend_msk);
plot(2*ones(1,length(c1.extend_data)),c1.extend_data, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
m2 = mean(c1.extend_data);
sd2 = std(c1.extend_data);
line([1.75 2.25], [m2 m2])
line([1.75 2.25], [m2+sd2 m2+sd2], 'Linestyle', '--')
line([1.75 2.25], [m2-sd2 m2-sd2], 'Linestyle', '--')

% s1 bend
bend_msk = contains(s1.motion, 'bend');
s1.bend_data = s1.antagonist_agonist_ratio(bend_msk);
plot(3*ones(1,length(s1.bend_data)),s1.bend_data, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
m3 = mean(s1.bend_data);
sd3 = std(s1.bend_data);
line([2.75 3.25], [m3 m3])
line([2.75 3.25], [m3+sd3 m3+sd3], 'Linestyle', '--')
line([2.75 3.25], [m3-sd3 m3-sd3], 'Linestyle', '--')

% s1 extend
extend_msk = contains(s1.motion, 'extend');
s1.extend_data = s1.antagonist_agonist_ratio(extend_msk);
plot(4*ones(1,length(s1.extend_data)),s1.extend_data, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
m4 = mean(s1.extend_data);
sd4 = std(s1.extend_data);
line([3.75 4.25], [m4 m4])
line([3.75 4.25], [m4+sd4 m4+sd4], 'Linestyle', '--')
line([3.75 4.25], [m4-sd4 m4-sd4], 'Linestyle', '--')

% c2 bend
bend_msk = contains(c2.motion, 'bend');
c2.bend_data = c2.antagonist_agonist_ratio(bend_msk);
plot(5*ones(1,length(c2.bend_data)),c2.bend_data, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
m5 = mean(c2.bend_data);
sd5 = std(c2.bend_data);
line([4.75 5.25], [m5 m5])
line([4.75 5.25], [m5+sd5 m5+sd5], 'Linestyle', '--')
line([4.75 5.25], [m5-sd5 m5-sd5], 'Linestyle', '--')

% c2 extend
extend_msk = contains(c2.motion, 'extend');
c2.extend_data = c2.antagonist_agonist_ratio(extend_msk);
plot(6*ones(1,length(c2.extend_data)),c2.extend_data, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
m6 = mean(c2.extend_data);
sd6 = std(c2.extend_data);
line([5.75 6.25], [m6 m6])
line([5.75 6.25], [m6+sd6 m6+sd6], 'Linestyle', '--')
line([5.75 6.25], [m6-sd6 m6-sd6], 'Linestyle', '--')


title( 'Bend-Extend Isolated Movement')
ylabel('CCI')
xlabel('Subject')
h_ax.XTick = [1:6];
h_ax.XTickLabel = {'C2797 Bend' 'C2797 Extend' 'S3102 Bend' 'S3102 Extend' 'C2795 Bend' 'C2795 Extend'};

x_vector = [c1.bend_data'; c1.extend_data'; 
			s1.bend_data'; s1.extend_data';
			c2.bend_data'; c2.extend_data']; 
grp = [repmat({'c2797bend'},1,length(c1.bend_data)) ...
	repmat({'c2797extend'},1,length(c1.extend_data)) ...
	repmat({'S3102bend'},1,length(s1.bend_data)) ...
	repmat({'S3102extend'},1,length(s1.extend_data)) ...
	repmat({'c2795bend'},1,length(c2.bend_data)) ...
	repmat({'c2795extend'},1,length(c2.extend_data))]';
% [p, anovatab, stats] = kruskalwallis(x_vector, grp)
[p, anovatab, stats] = anova1(x_vector, grp)
figure
comp = multcompare(stats)

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

[h, p] = ttest2(c1.antagonist_agonist_ratio, s2_extend.antagonist_agonist_ratio)

p_line = line([1 1 2 2], [0.28 0.32 0.32 0.28], 'color', [0 0 0], 'LineWidth', 2);
h_txt = text(1.5, 0.34, '*', 'Fontsize', 40)


% 20221109 - c1 and s1 figures and numbers are in the current version of
% the grant

[h, p] = ttest2(c1.antagonist_agonist_ratio, s1.antagonist_agonist_ratio)
