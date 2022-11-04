function emg_analysis_draw_finger_data(app)


% remove existing line if there is one
h_line = findobj(app.UIAxes_elbow_angle, 'Tag', 'line_elbow_angle_lpfilt');
if ~isempty(h_line)
	delete(h_line)
end
h_line = findobj(app.UIAxes_elbow_angle, 'Tag', 'line_hand_distance_lpfilt');
if ~isempty(h_line)
	delete(h_line)
end


% is it left or right?
if any(contains(app.vicon_data.lpfilt.Properties.VariableNames, 'RFIN'))
	hand_var = 'RFIN';
elseif any(contains(app.vicon_data.lpfilt.Properties.VariableNames, 'LFIN'))
	hand_var = 'LFIN';
else
	error('emg_analysis_draw_finger_data.m - no finger data')
end

% compute finger/hand position relative to where it was when the most
% recent bend or extend event occurred.

% vector to hold the hand distance from the starting point when the
% movement cue is given to when the next event 'Rest' is recorded
hand_distance = nan(height(app.vicon_data.lpfilt),1); 

for e_cnt = 1:length(app.emg_data.event)
	if contains(app.emg_data.event(e_cnt).code, 'Bend') || contains(app.emg_data.event(e_cnt).code, 'Extend')
% 		keyboard
		event_index = find(app.vicon_data.emg_time>=app.emg_data.event(e_cnt).time, 1, 'first');
		% at this time/index, get the position of the finger marker: x y z coordinates
		hand_start_pos = app.vicon_data.lpfilt{event_index, {[hand_var '_X_mm'], [hand_var '_Y_mm'], [hand_var '_Z_mm']}};
		
		% index of next event
		next_event_index = find(app.vicon_data.emg_time>=app.emg_data.event(e_cnt+1).time, 1, 'first');
		
		for r_cnt = event_index:next_event_index
			r_position = app.vicon_data.lpfilt{r_cnt, {[hand_var '_X_mm'], [hand_var '_Y_mm'], [hand_var '_Z_mm']}};
			hand_distance(r_cnt) = norm(r_position - hand_start_pos) / 10; % change from mm to cm
		end
	end
end

% save the computed hand distance in the vicon data table
app.vicon_data.lpfilt.hand_distance_cm = hand_distance;

% draw the line 
line(app.UIAxes_elbow_angle, app.vicon_data.emg_time, hand_distance, 'Tag', 'line_hand_distance_lpfilt', 'Color', 'k')
% change axis label if needed
if contains(app.UIAxes_elbow_angle.YLabel.String, 'Elbow')
	app.UIAxes_elbow_angle.YLabel.String = 'Hand Distance (cm)';
	% also change event lines y positions
	h_lines = findobj(app.UIAxes_elbow_angle, '-regexp', 'Tag', '.*event\d+');
	set(h_lines, 'YData', [0 80])
end

% draw the velocity of the hand distance
hand_vel = diff(hand_distance) * app.vicon_data.samp_freq;

% remove existing line, if present
h_line = findobj(app.UIAxes_elbow_velocity, 'Tag', 'line_hand_velocity');
if ~isempty(h_line)
	delete(h_line)
end
% draw the line
line(app.UIAxes_elbow_velocity, app.vicon_data.emg_time(1:end-1), hand_vel, 'color', 'r', 'Tag', 'line_hand_velocity')
% change axis label if needed
if contains(app.UIAxes_elbow_velocity.YLabel.String, 'Elbow')
	app.UIAxes_elbow_velocity.YLabel.String = 'Hand Velocity (cm/s)';
	
end
% draw y=0 line if there is not one
if isempty(findobj(app.UIAxes_elbow_velocity, 'Tag', 'line_y_zero'))
	line(app.UIAxes_elbow_velocity, app.UIAxes_elbow_velocity.XLim, [0 0], 'color', 'k', 'Tag', 'line_y_zero')
end

return
end