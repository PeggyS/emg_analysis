function update_coactivation_patch(app, event_num, end_t)

% x values for beginning & end of patch
begin_t = app.emg_data.event(event_num).time;
h_end_move_line = findobj(app.UIAxes_cci, 'Tag', ['line_cci_ax_move_end_event' num2str(event_num)]);
assert(~isempty(h_end_move_line), ['update_coactivation_patch.m  - could not find line: ' ...
	'line_cci_ax_move_end_event' num2str(event_num)]);

% separate patches for bicep and tricep
h_bicep = findobj(app.UIAxes_cci, 'Tag', 'line_cci_bicep');
assert(~isempty(h_bicep), 'update_coactivation_patch.m - could not find line_cci_bicep')
h_tricep = findobj(app.UIAxes_cci, 'Tag', 'line_cci_tricep');
assert(~isempty(h_tricep), 'update_coactivation_patch.m - could not find line_cci_tricep')

% bicep
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

% find the patch
h_patch = findobj(app.UIAxes_cci, 'Tag', ['bicep_emg_patch' num2str(event_num)]);

% update the patch
h_patch.Vertices = vertices;
h_patch.Faces = 1:size(vertices,1);


% tricep
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

% find the patch
h_patch = findobj(app.UIAxes_cci, 'Tag', ['tricep_emg_patch' num2str(event_num)]);

% update the patch
h_patch.Vertices = vertices;
h_patch.Faces = 1:size(vertices,1);
return
end