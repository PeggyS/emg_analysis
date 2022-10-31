

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
plot(ones(1,20),c1_bend.antagonist_agonist_ratio, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
hold on
plot(2*ones(1,20),c2_bend.antagonist_agonist_ratio, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
plot(3*ones(1,20),s1_bend.antagonist_agonist_ratio, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
plot(4*ones(1,20),s2_bend.antagonist_agonist_ratio, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
title( 'Bend Isolated Movement')
ylabel('Bicep AUC / Tricep AUC')
xlabel('Subject')
h_ax.XTick = [1:4];
h_ax.XTickLabel = {'C1' 'C2' 'S1' 'S2'};

% extend
figure
h_ax = axes;
plot(ones(1,20),c1_extend.antagonist_agonist_ratio, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
hold on
plot(2*ones(1,20),c2_extend.antagonist_agonist_ratio, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
plot(3*ones(1,18),s1_extend.antagonist_agonist_ratio, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
plot(4*ones(1,19),s2_extend.antagonist_agonist_ratio, 'marker', 'o', 'linestyle', 'none', 'MarkerFaceColor', [0 0.4470 0.7410])
title( 'Extend Isolated Movement')
ylabel('Tricep AUC / Bicep AUC')
xlabel('Subject')
h_ax.XTick = [1:4];
h_ax.XTickLabel = {'C1' 'C2' 'S1' 'S2'};