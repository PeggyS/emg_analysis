function [min_beg_t, min_end_t] = emg_analysis_find_min_emg(app, emg, beg_t, end_t, interval)
% emg is struct with .xdata and .ydata
% beg_t and end_t are the time interval (xdata) in which to look for min
% emg interval 

min_mean_over_interval = inf;

% num points in an interval
n_pts = app.emg_data.srate * interval;

% move along emg starting at beg_t index ending at end_t index-n_pts
beg_ind = find(emg.xdata >= beg_t, 1, 'first');
end_ind = find(emg.xdata >= end_t, 1, 'first');
for cnt = beg_ind:end_ind-n_pts
	% interval indices
	interval_beg_ind = cnt;
	interval_end_ind = cnt + n_pts;
	
	mean_over_interval = mean(emg.ydata(interval_beg_ind:interval_end_ind));
	% keep the smallest interval mean
	if mean_over_interval < min_mean_over_interval
		min_mean_over_interval = mean_over_interval;
		min_beg_ind = interval_beg_ind;
		min_end_ind = interval_end_ind;
	end
end

min_beg_t = emg.xdata(min_beg_ind);
min_end_t = emg.xdata(min_end_ind);

return
end