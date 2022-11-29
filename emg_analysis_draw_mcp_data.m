function emg_analysis_draw_mcp_data(app)


% remove existing line if there is one
h_line = findobj(app.UIAxes_elbow_angle, 'Tag', 'line_elbow_angle_lpfilt');
if ~isempty(h_line)
	delete(h_line)
end
h_line = findobj(app.UIAxes_elbow_angle, 'Tag', 'line_hand_distance_lpfilt');
if ~isempty(h_line)
	delete(h_line)
end
h_line = findobj(app.UIAxes_elbow_angle, 'Tag', 'line_mcp_angle_lpfilt');
if ~isempty(h_line)
	delete(h_line)
end


% is it left or right?
if any(contains(app.vicon_data.lpfilt.Properties.VariableNames, 'RMCP'))
	angle_var = 'RMCPAnglesXZY_X_deg';
elseif any(contains(app.vicon_data.lpfilt.Properties.VariableNames, 'LMCP'))
	angle_var = 'LMCPAnglesXZY_X_deg';
else
	error('emg_analysis_draw_mcp_data.m - no finger data')
end

% draw the line
data = table2array(app.vicon_data.lpfilt(:, {angle_var}));
line(app.UIAxes_elbow_angle, app.vicon_data.emg_time, data, ...
	'Tag', 'line_mcp_angle_lpfilt', 'Color', 'k')

% change axis label if needed
if contains(app.UIAxes_elbow_angle.YLabel.String, 'Elbow')
	app.UIAxes_elbow_angle.YLabel.String = 'Dig2 MCP Angle (°)';
	% also change event lines y positions
% 	h_lines = findobj(app.UIAxes_elbow_angle, '-regexp', 'Tag', '.*event\d+');
% 	set(h_lines, 'YData', [0 80])
end


% velocity
mcp_vel = diff(data) * app.vicon_data.samp_freq;

% remove existing line, if present
h_line = findobj(app.UIAxes_elbow_velocity, 'Tag', 'line_elbow_velocity');
if ~isempty(h_line)
	delete(h_line)
end
h_line = findobj(app.UIAxes_elbow_velocity, 'Tag', 'line_y_zero');
if ~isempty(h_line)
	delete(h_line)
end
h_line = findobj(app.UIAxes_elbow_velocity, 'Tag', 'line_mcp_velocity');
if ~isempty(h_line)
	delete(h_line)
end
line(app.UIAxes_elbow_velocity, app.vicon_data.emg_time(1:end-1), mcp_vel, 'color', 'r', 'Tag', 'line_mcp_velocity')
if isempty(findobj(app.UIAxes_elbow_velocity, 'Tag', 'line_y_zero'))
	line(app.UIAxes_elbow_velocity, app.UIAxes_elbow_velocity.XLim, [0 0], 'color', 'k', 'Tag', 'line_y_zero')
end
% change axis label if needed
if contains(app.UIAxes_elbow_velocity.YLabel.String, 'Elbow')
	app.UIAxes_elbow_angle.YLabel.String = 'Dig2 MCP Angle Velocity (°/s)';
end


return
end