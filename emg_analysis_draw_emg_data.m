function emg_analysis_draw_emg_data(app)
% part of the emg_analysis app, draw or update the data in the emg axes
h_lines = findobj(app.MVCAnalysisUIFigure, '-regexp', 'Tag', 'line_.*');
if ~isempty(h_lines)
	delete(h_lines)
end

% find the bicep & tricep channel indices
bicep_ind = find_channel_index(app.emg_data, 'bicep');
tricep_ind = find_channel_index(app.emg_data, 'tricep');

line(app.UIAxes_bicep, app.emg_data.times/1000, app.emg_data.data_hp_filt(bicep_ind,:), ...
	'Tag', 'line_bicep_hp_filt', 'Color', [0 0.4470 0.7410 0.25])
line(app.UIAxes_tricep, app.emg_data.times/1000, app.emg_data.data_hp_filt(tricep_ind,:), ...
	'Tag', 'line_tricep_hp_filt', 'Color', [0 0.4470 0.7410 0.25])

line(app.UIAxes_bicep, app.emg_data.times/1000,app.emg_data.linear_envelope(bicep_ind,:), ...
	'Tag', 'line_bicep_envelope', 'Color', [0 0 0], 'LineWidth', 2)
line(app.UIAxes_tricep, app.emg_data.times/1000,app.emg_data.linear_envelope(tricep_ind,:), ...
	'Tag', 'line_tricep_envelope', 'Color', [0 0 0], 'LineWidth', 2)


return
end