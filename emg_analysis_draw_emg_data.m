function emg_analysis_draw_emg_data(app)
% part of the emg_analysis app, draw or update the data in the emg axes

cocon_flag = false;

if isprop(app, 'MVCAnalysisUIFigure')
	h_lines = findobj(app.MVCAnalysisUIFigure, '-regexp', 'Tag', 'line_.*');
elseif isprop(app, 'CoConUIFigure')
	h_lines = findobj(app.CoConUIFigure, '-regexp', 'Tag', 'line_.*');
	cocon_flag = true;
else
	return
end
if ~isempty(h_lines)
	delete(h_lines)
end

% find the bicep & tricep channel indices
bicep_ind = find_channel_index(app.emg_data, 'bicep');
tricep_ind = find_channel_index(app.emg_data, 'tricep');

line(app.UIAxes_bicep, app.emg_data.time, app.emg_data.data_hp_filt(bicep_ind,:), ...
	'Tag', 'line_bicep_hp_filt', 'Color', [0 0.4470 0.7410 0.25])
line(app.UIAxes_tricep, app.emg_data.time, app.emg_data.data_hp_filt(tricep_ind,:), ...
	'Tag', 'line_tricep_hp_filt', 'Color', [0 0.4470 0.7410 0.25])

line(app.UIAxes_bicep, app.emg_data.time, app.emg_data.linear_envelope(bicep_ind,:), ...
	'Tag', 'line_bicep_envelope', 'Color', [0 0 0], 'LineWidth', 2)
line(app.UIAxes_tricep, app.emg_data.time, app.emg_data.linear_envelope(tricep_ind,:), ...
	'Tag', 'line_tricep_envelope', 'Color', [0 0 0], 'LineWidth', 2)

if cocon_flag == true
	% draw co-contraction index data
	line(app.UIAxes_cci, app.emg_data.time, app.cci_data, ...
		'Tag', 'line_cci_data', 'Color', [0 0 0], 'LineWidth', 2)
	% adjust ylims of bicep & tricep axes
	ymin = min(app.emg_data.linear_envelope(bicep_ind,:));
	ymax = max(app.emg_data.linear_envelope(bicep_ind,:));
	app.UIAxes_bicep.YLim = [ymin ymax];
	ymin = min(app.emg_data.linear_envelope(tricep_ind,:));
	ymax = max(app.emg_data.linear_envelope(tricep_ind,:));
	app.UIAxes_tricep.YLim = [ymin ymax];
	% ylims of cci
	app.UIAxes_cci.YLim = [0 200];
end


return
end