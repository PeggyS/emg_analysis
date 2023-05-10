function cci_pre_post_training(pre_file, post_file)

% read in file, parse for the info
keywords = {'begin_t' 'end_t' 'begin_angle' 'end_angle' 'bicep_auc' 'tricep_auc' ...
	'antagonist_agonist_ratio' 'analysis_by' 'analysis_date'};

defaults = {[], [], [], [], [], [], [], '', ''};

% read in pre data
try
	paramscell = readparamfile(pre_file, keywords, defaults);
catch ME
	% keyboard
	rethrow(ME)
end

pre_data.begin_t       = paramscell{1};
pre_data.end_t         = paramscell{2};
pre_data.begin_angle     = paramscell{3};
pre_data.end_angle       = paramscell{4};
pre_data.bicep_auc         = paramscell{5};
pre_data.tricep_auc     = paramscell{6};
pre_data.antagonist_agonist_ratio     = paramscell{7};
pre_data.analysis_by   = paramscell{8};
pre_data.analysis_date = paramscell{9};

% read in post_data
try
	paramscell = readparamfile(post_file, keywords, defaults);
catch ME
	% keyboard
	rethrow(ME)
end

post_data.begin_t       = paramscell{1};
post_data.end_t         = paramscell{2};
post_data.begin_angle     = paramscell{3};
post_data.end_angle       = paramscell{4};
post_data.bicep_auc         = paramscell{5};
post_data.tricep_auc     = paramscell{6};
post_data.antagonist_agonist_ratio     = paramscell{7};
post_data.analysis_by   = paramscell{8};
post_data.analysis_date = paramscell{9};

% angle the elbow moved
pre_data.angle_moved = pre_data.end_angle - pre_data.begin_angle;
post_data.angle_moved = post_data.end_angle - post_data.begin_angle;

% amt of time it took to move
pre_data.time_moved = pre_data.end_t - pre_data.begin_t;
post_data.time_moved = post_data.end_t - post_data.begin_t;

% medians and comparisons
fprintf('N: pre = %d, post = %d\n', length(pre_data.time_moved), length(post_data.time_moved))
fprintf('median angle moved (deg): pre = %f, post = %f\n', median(pre_data.angle_moved), median(post_data.angle_moved))
fprintf('median amt of time (s): pre = %f, post = %f\n', median(pre_data.time_moved), median(post_data.time_moved))
fprintf('median emg antagonist/agonist ratio: pre = %f, post = %f\n', median(pre_data.antagonist_agonist_ratio), median(post_data.antagonist_agonist_ratio))

disp('ranksum tests - pre vs post')
[p, h] = ranksum(pre_data.angle_moved, post_data.angle_moved);
fprintf('angle moved p = %f\n', p)
[p, h] = ranksum(pre_data.time_moved, post_data.time_moved);
fprintf('time moved p = %f\n', p)
[p, h] = ranksum(pre_data.antagonist_agonist_ratio, post_data.antagonist_agonist_ratio);
fprintf('emg antagonist/agonist ratio p = %f\n', p)

return
end