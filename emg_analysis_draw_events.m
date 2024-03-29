function emg_analysis_draw_events(app)
% draw the move, relax, and next events

% delete existing event lines - were already deleted with the data lines
% h_lines = findobj(app.CoConUIFigure, '-regexp', 'Tag', 'line_.*event.*');
% if ~isempty(h_lines)
% 	delete(h_lines)
% end

% delete bend count and times
delete(app.UIAxes_elbow_angle.Children);


bend_cnt = 0;
extend_cnt = 0;

for e_cnt = 1:length(app.emg_data.event)
	time = app.emg_data.event(e_cnt).time;
	event_code = app.emg_data.event(e_cnt).code;
	switch lower(event_code)
		case 'move'
			event_color = [0 0 0.9];
		case 'bend'
			event_color = [0 0 0.9];
			bend_cnt = bend_cnt + 1;
		case 'extend'
			event_color = [0 0.7 0]; % green
			extend_cnt = extend_cnt + 1;
% 			event_color = [0 0 0.9];
		case {'relax' 'rest'}
			event_color = [0.8 0 0];
% 			event_color = [1 1 1];
		case 'next'
			event_color = [0.2 0.7 0.7]; % dark cyan
		case 'viconstart'
			event_color = [0.2 0.7 0.2];
			v_start = time;
		case 'viconstop'
			event_color = [0.9 0.2 0.2];
		otherwise
			event_color = [0 0 0];
	end
	% line in each axes 
	h = []; % variable length vector to hold the line handles in order to link their properties

	
	h(1) = line(app.UIAxes_bicep,  [time time], app.UIAxes_bicep.YLim, 'Color', event_color, ...
		'LineWidth', 2, ...
		'Tag', ['line_bicep_ax_event' num2str(e_cnt)], 'Visible', 'off');
	h(2) = line(app.UIAxes_tricep,  [time time], app.UIAxes_tricep.YLim, 'Color', event_color, ...
		'LineWidth', 2, ...
		'Tag', ['line_tricep_ax_event' num2str(e_cnt)], 'Visible', 'off');
	h(3) = line(app.UIAxes_cci,  [time time], app.UIAxes_cci.YLim, 'Color', event_color, ...
		'LineWidth', 2, ...
		'Tag', ['line_cci_ax_event' num2str(e_cnt)]);
	% only show move events on elbow axes
	if contains(lower(event_code), 'move') || contains(lower(event_code), 'bend') || contains(lower(event_code), 'extend')
		h(4) = line(app.UIAxes_elbow_angle,  [time time], [-180 180], 'Color', event_color, ...
		'LineWidth', 2, ...
		'Tag', ['line_elbow_angle_ax_event' num2str(e_cnt)]);

		if contains(lower(event_code), 'bend')
			msg = sprintf('b%d: %g', bend_cnt, round(time-v_start));
			text(app.UIAxes_elbow_angle,  time+2, 0, msg, 'Color', event_color)
		end
		if contains(lower(event_code), 'extend')
			msg = sprintf('e%d: %g', extend_cnt, round(time-v_start));
			text(app.UIAxes_elbow_angle,  time+2, 0, msg, 'Color', event_color)
		end

		h(5) = line(app.UIAxes_elbow_velocity,  [time time], [-10 10], 'Color', event_color, ...
		'LineWidth', 2, ...
		'Tag', ['line_elbow_velocity_ax_event' num2str(e_cnt)]);
	end

	app.links.event_lines(e_cnt) = linkprop(h, 'XData');
end % each event

return
end