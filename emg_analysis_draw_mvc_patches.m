function emg_analysis_draw_mvc_patches(app)
% for mvc app, draw draggable patches for defining the mvc range

% each event in emg_data
for e_cnt = 1:length(app.emg_data.event)
	switch lower(app.emg_data.event(e_cnt).type)
		case 'bicepmvc'
			emg_analysis_add_patch(app.UIAxes_bicep, app.emg_data.event(e_cnt).time)
		case 'tricepmvc'
			emg_analysis_add_patch(app.UIAxes_tricep, app.emg_data.event(e_cnt).time)
	end
end % each event

return
end