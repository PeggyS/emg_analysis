function add_movement_end_event(app, event_num)

% disp('add_movement_end_event')

evt_time = app.emg_data.event(event_num).time;
% start looking 2 s after the event and find where elbow velocity is zero 

h_elb_line = findobj(app.CoConUIFigure, 'Tag', 'line_elbow_velocity');
assert(~isempty(h_elb_line), 'add_movement_end_event - did not find elbow velocity line')

% index 2 s after event
time_padding = 2;
ind_move_beg = find(h_elb_line.XData > evt_time + time_padding, 1, 'first');

elb_velocity_sign = sign(h_elb_line.YData(ind_move_beg));

if elb_velocity_sign > 0
	ind = find(h_elb_line.YData(ind_move_beg:end) < 0, 1, 'first');
else
	ind = find(h_elb_line.YData(ind_move_beg:end) > 0, 1, 'first');
end
ind_move_end = ind_move_beg + ind - 1;

time = h_elb_line.XData(ind_move_end);
event_color = [230 153 0]/255;
% add move end line at ind
h(1) = line(app.UIAxes_cci,  [time time], app.UIAxes_cci.YLim, 'Color', event_color, ...
		'LineWidth', 2, ...
		'Tag', ['line_cci_ax_move_end_event' num2str(event_num)]);

h(2) = line(app.UIAxes_elbow_angle,  [time time], [-180 180], 'Color', event_color, ...
		'LineWidth', 2, ...
		'Tag', ['line_elbow_angle_ax_move_end_event' num2str(event_num)], ...
		'UserData', app);
tmp = draggable(h(2), 'h', @end_event_move_callback);

h(3) = line(app.UIAxes_elbow_velocity,  [time time], [-10 10], 'Color', event_color, ...
		'LineWidth', 2, ...
		'Tag', ['line_elbow_velocity_ax_move_end_event' num2str(event_num)]);
% tmp = draggable(h(3), 'h');
% tmp.on_move_callback = @end_event_move_callback;
app.links.event_lines(end+1) = linkprop(h, 'XData');

return
end