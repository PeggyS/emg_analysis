function emg_analysis_draw_events(app)
% draw the move, relax, and next events

% delete existing event lines - were already deleted with the data lines
% h_lines = findobj(app.CoConUIFigure, '-regexp', 'Tag', 'line_.*event.*');
% if ~isempty(h_lines)
% 	delete(h_lines)
% end

for e_cnt = 1:length(app.emg_data.event)
	event_code = app.emg_data.event(e_cnt).code;
	switch lower(event_code)
		case 'move'
			event_color = [0 0 0.9];
		case 'relax'
			event_color = [0.8 0 0];
		case 'next'
			event_color = [0.2 0.7 0.7];
		case 'viconstart'
			event_color = [0.2 0.7 0.2];
		case 'viconstop'
			event_color = [0.9 0.2 0.2];
		otherwise
			event_color = [0 0 0];
	end
	% line in each axes 
	time = app.emg_data.event(e_cnt).time;
	h1 = line(app.UIAxes_bicep,  [time time], app.UIAxes_bicep.YLim, 'Color', event_color, ...
		'LineWidth', 2, ...
		'Tag', ['line_bicep_ax_event' num2str(e_cnt)]);
	h2 = line(app.UIAxes_tricep,  [time time], app.UIAxes_tricep.YLim, 'Color', event_color, ...
		'LineWidth', 2, ...
		'Tag', ['line_tricep_ax_event' num2str(e_cnt)]);
	h3 = line(app.UIAxes_cci,  [time time], app.UIAxes_cci.YLim, 'Color', event_color, ...
		'LineWidth', 2, ...
		'Tag', ['line_cci_ax_event' num2str(e_cnt)]);

	app.links.event_lines(e_cnt) = linkprop([h1, h2, h3], 'XData');
end % each event

return
end