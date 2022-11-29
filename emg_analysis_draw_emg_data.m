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
if ~isempty(bicep_ind)
	line(app.UIAxes_bicep, app.emg_data.time, app.emg_data.data_hp_filt(bicep_ind,:), ...
		'Tag', 'line_bicep_hp_filt', 'Color', [0 0.4470 0.7410 0.25])
	line(app.UIAxes_bicep, app.emg_data.time, app.emg_data.linear_envelope(bicep_ind,:), ...
		'Tag', 'line_bicep_envelope', 'Color', [0 0 0], 'LineWidth', 2, 'Visible', 'on')
end
tricep_ind = find_channel_index(app.emg_data, 'tricep');
if ~isempty(tricep_ind)
	line(app.UIAxes_tricep, app.emg_data.time, app.emg_data.data_hp_filt(tricep_ind,:), ...
		'Tag', 'line_tricep_hp_filt', 'Color', [0 0.4470 0.7410 0.25])
	line(app.UIAxes_tricep, app.emg_data.time, app.emg_data.linear_envelope(tricep_ind,:), ...
		'Tag', 'line_tricep_envelope', 'Color', [0 0 0], 'LineWidth', 2, 'Visible', 'on')
end
% and finger muscles
fingflex_ind = find_channel_index(app.emg_data, 'fingerflexors');
if isprop(app, 'UIAxes_fingerflexors')
	if ~isempty(fingflex_ind)
		line(app.UIAxes_fingerflexors, app.emg_data.time, app.emg_data.data_hp_filt(fingflex_ind,:), ...
			'Tag', 'line_fingerflexors_hp_filt', 'Color', [0 0.4470 0.7410 0.25])
		line(app.UIAxes_fingerflexors, app.emg_data.time, app.emg_data.linear_envelope(fingflex_ind,:), ...
			'Tag', 'line_fingerflexors_envelope', 'Color', [0 0 0], 'LineWidth', 2, 'Visible', 'on')
	end
end
fingextens_ind = find_channel_index(app.emg_data, 'fingerextensors');
if isprop(app, 'UIAxes_fingerextensors')
	if ~isempty(fingextens_ind)
		line(app.UIAxes_fingerextensors, app.emg_data.time, app.emg_data.data_hp_filt(fingextens_ind,:), ...
			'Tag', 'line_fingerextensors_hp_filt', 'Color', [0 0.4470 0.7410 0.25])
		line(app.UIAxes_fingerextensors, app.emg_data.time, app.emg_data.linear_envelope(fingextens_ind,:), ...
			'Tag', 'line_fingerextensors_envelope', 'Color', [0 0 0], 'LineWidth', 2, 'Visible', 'on')
	end
end
if cocon_flag == true
	% use downsampled time & linear envelope, if present
	if isfield(app.emg_data, 'time_downsampled')
		t = app.emg_data.time_downsampled;
	else
		t = app.emg_data.time;
	end
		
	if isfield(app.emg_data, 'linear_envelope_downsampled')
		data = app.emg_data.linear_envelope_downsampled;
	else
		data = app.emg_data.linear_envelope;
	end
	
	if app.FingerExtendButton.Value == 1
		% finger data
		line(app.UIAxes_cci, t, data(fingflex_ind,:), ...
			'Tag', 'line_cci_fingerflexors', 'Color', [0 0 0.9], 'LineWidth', 1)
		line(app.UIAxes_cci, t, data(fingextens_ind,:), ...
			'Tag', 'line_cci_fingerextensors', 'Color', [0.9 0 0], 'LineWidth', 1)
	else

		% draw bicep & tricep envelope data
		line(app.UIAxes_cci, t, data(bicep_ind,:), ...
			'Tag', 'line_cci_bicep', 'Color', [0 0 0.9], 'LineWidth', 1)
		line(app.UIAxes_cci, t, data(tricep_ind,:), ...
			'Tag', 'line_cci_tricep', 'Color', [0.9 0 0], 'LineWidth', 1)
	end
	% adjust ylims of bicep & tricep axes
	ymin = min(app.emg_data.linear_envelope(bicep_ind,:));
	ymax = max(app.emg_data.linear_envelope(bicep_ind,:));
% 	app.UIAxes_bicep.YLim = [ymin ymax];
	ymin = min(app.emg_data.linear_envelope(tricep_ind,:));
	ymax = max(app.emg_data.linear_envelope(tricep_ind,:));
% 	app.UIAxes_tricep.YLim = [ymin ymax];
	% ylims of cci
 	app.UIAxes_cci.YLim = [0 100];
end


return
end