

file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/c2797tdvg/session2/20220901_0004_bend_cocontraction_info.txt';

% read in file, parse for the info
keywords = {'begin_t' 'end_t' 'begin_angle' 'end_angle' 'bicep_auc' 'tricep_auc' ...
	'antagonist_agonist_ratio' 'analysis_by' 'analysis_date'};

defaults = {[], [], [], [], [], [], [], '', ''};

try
	paramscell = readparamfile(file_name, keywords, defaults);
catch ME
	% keyboard
	rethrow(ME)
end

c1_bend.begin_t       = paramscell{1};
c1_bend.end_t         = paramscell{2};
c1_bend.begin_angle     = paramscell{3};
c1_bend.end_angle       = paramscell{4};
c1_bend.bicep_auc         = paramscell{5};
c1_bend.tricep_auc     = paramscell{6};
c1_bend.antagonist_agonist_ratio     = paramscell{7};		
c1_bend.analysis_by   = paramscell{8};
c1_bend.analysis_date = paramscell{9};


file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/c2797tdvg/session2/20220901_0005_extend_cocontraction_info.txt';
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

file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/c2799tdvg/Session1/20220826_0002_bend_cocontraction_info.txt';
paramscell = readparamfile(file_name, keywords, defaults);
c2_bend.begin_t       = paramscell{1};
c2_bend.end_t         = paramscell{2};
c2_bend.begin_angle     = paramscell{3};
c2_bend.end_angle       = paramscell{4};
c2_bend.bicep_auc         = paramscell{5};
c2_bend.tricep_auc     = paramscell{6};
c2_bend.antagonist_agonist_ratio     = paramscell{7};		
c2_bend.analysis_by   = paramscell{8};
c2_bend.analysis_date = paramscell{9};

file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/c2799tdvg/Session1/20220826_0003_extend_cocontraction_info.txt';
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

file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/s3101uemp/week01/20220927_0004_bend_cocontraction_info.txt';
paramscell = readparamfile(file_name, keywords, defaults);
s1_bend.begin_t       = paramscell{1};
s1_bend.end_t         = paramscell{2};
s1_bend.begin_angle     = paramscell{3};
s1_bend.end_angle       = paramscell{4};
s1_bend.bicep_auc         = paramscell{5};
s1_bend.tricep_auc     = paramscell{6};
s1_bend.antagonist_agonist_ratio     = paramscell{7};		
s1_bend.analysis_by   = paramscell{8};
s1_bend.analysis_date = paramscell{9};

file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/s3101uemp/week01/20220927_0005_extend_cocontraction_info.txt';
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


file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/s3102uemp/week01/20221012_0004_bend_cocontraction_info.txt';
paramscell = readparamfile(file_name, keywords, defaults);
s2_bend.begin_t       = paramscell{1};
s2_bend.end_t         = paramscell{2};
s2_bend.begin_angle     = paramscell{3};
s2_bend.end_angle       = paramscell{4};
s2_bend.bicep_auc         = paramscell{5};
s2_bend.tricep_auc     = paramscell{6};
s2_bend.antagonist_agonist_ratio     = paramscell{7};		
s2_bend.analysis_by   = paramscell{8};
s2_bend.analysis_date = paramscell{9};

file_name = '/Users/peggy/Documents/BrainLab/myopro_merit/analysis/emg/s3102uemp/week01/20221012_0005_extend_cocontraction_info.txt';
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
plot(ones(1,length(c1_bend.antagonist_agonist_ratio)),c1_bend.antagonist_agonist_ratio, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
m1 = mean(c1_bend.antagonist_agonist_ratio);
sd1 = std(c1_bend.antagonist_agonist_ratio);
line([0.75 1.25], [m1 m1])
line([0.75 1.25], [m1+sd1 m1+sd1], 'Linestyle', '--')
line([0.75 1.25], [m1-sd1 m1-sd1], 'Linestyle', '--')

plot(2*ones(1,length(c2_bend.antagonist_agonist_ratio)),c2_bend.antagonist_agonist_ratio, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
m2 = mean(c2_bend.antagonist_agonist_ratio);
sd2 = std(c2_bend.antagonist_agonist_ratio);
line([1.75 2.25], [m2 m2])
line([1.75 2.25], [m2+sd2 m2+sd2], 'Linestyle', '--')
line([1.75 2.25], [m2-sd2 m2-sd2], 'Linestyle', '--')

plot(3*ones(1,length(s1_bend.antagonist_agonist_ratio)),s1_bend.antagonist_agonist_ratio, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
m3 = mean(s1_bend.antagonist_agonist_ratio);
sd3 = std(s1_bend.antagonist_agonist_ratio);
line([2.75 3.25], [m3 m3])
line([2.75 3.25], [m3+sd3 m3+sd3], 'Linestyle', '--')
line([2.75 3.25], [m3-sd3 m3-sd3], 'Linestyle', '--')

plot(4*ones(1,length(s2_bend.antagonist_agonist_ratio)),s2_bend.antagonist_agonist_ratio, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
m4 = mean(s2_bend.antagonist_agonist_ratio);
sd4 = std(s2_bend.antagonist_agonist_ratio);
line([3.75 4.25], [m4 m4])
line([3.75 4.25], [m4+sd4 m4+sd4], 'Linestyle', '--')
line([3.75 4.25], [m4-sd4 m4-sd4], 'Linestyle', '--')

title( 'Bend Isolated Movement')
ylabel('Bicep AUC / Tricep AUC')
xlabel('Subject')
h_ax.XTick = [1:4];
h_ax.XTickLabel = {'C2797' 'C2799' 'S3101' 'S3102'};

x_vector = [c1_bend.antagonist_agonist_ratio'; c2_bend.antagonist_agonist_ratio'; 
			s1_bend.antagonist_agonist_ratio'; s2_bend.antagonist_agonist_ratio']; 
grp = [repmat({'c2797'},1,length(c1_bend.antagonist_agonist_ratio)) ...
	repmat({'c2799'},1,length(c2_bend.antagonist_agonist_ratio)) ...
	repmat({'S3101'},1,length(s1_bend.antagonist_agonist_ratio)) ...
	repmat({'S3102'},1,length(s2_bend.antagonist_agonist_ratio)) ]';
[p, anovatab, stats] = kruskalwallis(x_vector, grp)
figure
comp = multcompare(stats)

% extend
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
title( 'Extend Isolated Movement')
ylabel('Tricep AUC / Bicep AUC')
xlabel('Subject')
h_ax.XTick = [1:4];
h_ax.XTickLabel = {'C2797' 'C2799' 'S3101' 'S3102'};

x_vector = [c1_extend.antagonist_agonist_ratio'; c2_extend.antagonist_agonist_ratio'; 
			s1_extend.antagonist_agonist_ratio'; s2_extend.antagonist_agonist_ratio']; 
grp = [repmat({'c2797'},1,length(c1_extend.antagonist_agonist_ratio)) ...
	repmat({'c2799'},1,length(c2_extend.antagonist_agonist_ratio)) ...
	repmat({'S3101'},1,length(s1_extend.antagonist_agonist_ratio)) ...
	repmat({'S3102'},1,length(s2_extend.antagonist_agonist_ratio)) ]';
[p, anovatab, stats] = kruskalwallis(x_vector, grp)
figure
comp = multcompare(stats)