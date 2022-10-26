function add_coactivation_patch(app, event_num)

% x values for beginning & end of patch
begin_t = app.emg_data.event(event_num).time;
h_end_move_line = findobj(app.UIAxes_cci, 'Tag', ['line_cci_ax_move_end_event' num2str(event_num)]);
assert(~isempty(h_end_move_line), ['add_coactivation_patch.m  - could not find line: ' ...
	'line_cci_ax_move_end_event' num2str(event_num)]);

end_t = h_end_move_line.XData(1);

% add bicep patch
% y values for height of patch is the bicep envelope

h_bicep = findobj(app.UIAxes_cci, 'Tag', 'line_cci_bicep');
assert(~isempty(h_bicep), 'add_coactivation_patch.m - could not find line_cci_bicep')

y_val = h_bicep.YData;
% start defining vertices at the begin_t and y=0
vertices = [begin_t, 0];

% add vertices at y_val of all time points between begin_t and end_t
between_t_mask = h_bicep.XData >= begin_t & h_bicep.XData <= end_t;
between_t = h_bicep.XData(between_t_mask);
between_y = y_val(between_t_mask);

vertices = [vertices;
			between_t', between_y'];

% end the patch at end time and y=0
vertices = [vertices; end_t, 0];
color = [0 0 0.9]; % bicep is blue
h_patch = patch(app.UIAxes_cci, vertices(:,1), vertices(:,2), color, 'Tag', ['bicep_emg_patch' num2str(event_num)] );
h_patch.EdgeColor = 'none';
h_patch.FaceAlpha = 0.2;
app.coactivation_patches(end+1) = h_patch;


% tricep patch
h_tricep = findobj(app.UIAxes_cci, 'Tag', 'line_cci_tricep');
assert(~isempty(h_tricep), 'add_coactivation_patch.m - could not find line_cci_tricep')

y_val = h_tricep.YData;
% start defining vertices at the begin_t and y=0
vertices = [begin_t, 0];

% add vertices at y_val of all time points between begin_t and end_t
between_t_mask = h_tricep.XData >= begin_t & h_tricep.XData <= end_t;
between_t = h_tricep.XData(between_t_mask);
between_y = y_val(between_t_mask);

vertices = [vertices;
			between_t', between_y'];

% end the patch at end time and y=0
vertices = [vertices; end_t, 0];
color = [0.9 0 0]; % tricep is red
h_patch = patch(app.UIAxes_cci, vertices(:,1), vertices(:,2), color, 'Tag', ['tricep_emg_patch' num2str(event_num)] );
h_patch.EdgeColor = 'none';
h_patch.FaceAlpha = 0.2;
app.coactivation_patches(end+1) = h_patch;


return
end