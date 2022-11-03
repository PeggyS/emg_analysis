function emg_analysis_draw_finger_data(app)


% remove existing line if there is one
h_line = findobj(app.UIAxes_elbow_angle, 'Tag', 'line_elbow_angle_lpfilt');
if ~isempty(h_line)
	delete(h_line)
end


% is it left or right?
if any(contains(app.vicon_data.lpfilt.Properties.VariableNames, 'RFIN'))
	hand_var = 'RFIN';
end
if any(contains(app.vicon_data.lpfilt.Properties.VariableNames, 'LFIN'))
	hand_var = 'RFIN';
end

% compute finger/hand position relative to where it was when the most
% recent bend or extend event occurred.
for e_cnt = 1:length(app.emg_data.event)
	if contains(app.emg_data.event.code, 'Bend') || contains(app.emg_data.event.code, 'Extend')
		
	end
end

data = table2array(app.vicon_data.lpfilt(:, {angle_var}));
line(app.UIAxes_elbow_angle, app.vicon_data.emg_time, data, ...
	'Tag', 'line_elbow_angle_lpfilt', 'Color', 'k')


return
end