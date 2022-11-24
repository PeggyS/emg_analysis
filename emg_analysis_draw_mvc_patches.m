function emg_analysis_draw_mvc_patches(app)
% for mvc app, draw draggable patches for defining the mvc range

h_patches = findobj(app.MVCAnalysisUIFigure, '-regexp', 'Tag', 'patch_.*mvc');
if ~isempty(h_patches)
	delete(h_patches)
end

% mvc info read in from file and saved in app.mvcs
f_names = fieldnames(app.mvcs);
if ~isempty(f_names)
	for m_cnt = 1:length(f_names)
		muscle = f_names{m_cnt};
		axes_str = ['UIAxes_' muscle];
		for e_cnt = 1:length(app.mvcs.(muscle).begin_t)
			emg_analysis_add_patch(app.(axes_str), app.mvcs.(muscle).begin_t(e_cnt), ...
				app.mvcs.(muscle).end_t(e_cnt))
		end % each patch/event
	end % each muscle

else
	% use each event in emg_data
	for e_cnt = 1:length(app.emg_data.event)
		switch lower(app.emg_data.event(e_cnt).type)
			case {'bicepmvc' 'bicep mvc'}
				emg_analysis_add_patch(app.UIAxes_bicep, app.emg_data.event(e_cnt).time, ...
					app.emg_data.event(e_cnt).time + 1.0)
			case {'tricepmvc' 'tricep mvc'}
				emg_analysis_add_patch(app.UIAxes_tricep, app.emg_data.event(e_cnt).time, ...
					app.emg_data.event(e_cnt).time + 1.0)
		end
	end % each event
end
return
end