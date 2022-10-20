function emg_analysis_draw_elbow_data(app)

% data = table2array(app.vicon_data.tbl(:, {'LElbAnglesXZY_X_deg'}));
% line(app.UIAxes_elbow_angle, app.vicon_data.emg_time, data, ...
% 	'Tag', 'line_elbow_angle_raw', 'Color', [0 0.4470 0.7410 0.25])

data = table2array(app.vicon_data.lpfilt(:, {'LElbAnglesXZY_X_deg'}));
line(app.UIAxes_elbow_angle, app.vicon_data.emg_time, data, ...
	'Tag', 'line_elbow_angle_lpfilt', 'Color', 'k')


return
end