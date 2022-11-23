function add_isometric_contraction_end_event(app, event_num, end_time)

% disp('add_isometric_contraction_end_event')

% % use the right-click x position
% time = app.right_click_loc.x;
event_color = [230 153 0]/255;
% add end line at time
h_l = line(app.UIAxes_cci,  [end_time end_time], app.UIAxes_cci.YLim, 'Color', event_color, ...
		'LineWidth', 2, ...
		'Tag', ['line_cci_ax_move_end_event' num2str(event_num)], ...
		'UserData', app);


draggable(h_l, 'h', @end_event_move_callback);

return
end