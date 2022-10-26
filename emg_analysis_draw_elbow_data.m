function emg_analysis_draw_elbow_data(app)

% data = table2array(app.vicon_data.tbl(:, {'LElbAnglesXZY_X_deg'}));
% line(app.UIAxes_elbow_angle, app.vicon_data.emg_time, data, ...
% 	'Tag', 'line_elbow_angle_raw', 'Color', [0 0.4470 0.7410 0.25])

% remove existing line if there is one
h_line = findobj(app.UIAxes_elbow_angle, 'Tag', 'line_elbow_angle_lpfilt');
if ~isempty(h_line)
	delete(h_line)
end


% is it left or right?
if any(contains(app.vicon_data.lpfilt.Properties.VariableNames, 'RElb'))
	angle_var = 'RElbAnglesXZY_X_deg';
end
if any(contains(app.vicon_data.lpfilt.Properties.VariableNames, 'LElb'))
	angle_var = 'LElbAnglesXZY_X_deg';
end
data = table2array(app.vicon_data.lpfilt(:, {angle_var}));
line(app.UIAxes_elbow_angle, app.vicon_data.emg_time, data, ...
	'Tag', 'line_elbow_angle_lpfilt', 'Color', 'k')


return
end