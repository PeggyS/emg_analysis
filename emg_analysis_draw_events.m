function emg_analysis_draw_events(app)
% draw the move, relax, and next events

% delete existing event lines
h_lines = findobj(app.CoConUIFigure, '-regexp', 'Tag', 'line_event.*');
if ~isempty(h_lines)
	delete(h_lines)
end

evt_code_list = {'move', 'relax', 'next', 'Viconstart'};
evt_color_list = {[0 0 0.9], [0.8 0 0], [0.2 0.7 0.7], [0.5 0.5 0.5]};


for e_cnt = 1:length(app.emg_data.event)
	switch app.emg_data.event(e_cnt)
		case 'move'
			evt_
			add_event_line(app, event_code, time)
	
	keyboard
end % each event

return
end