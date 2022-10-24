function emg_analysis_draw_rest_emg_patch(app)
% for mvc app, draw draggable patch for defining the lowest or resting emg

h_patches = findobj(app.MVCAnalysisUIFigure, '-regexp', 'Tag', 'patch_.*resting');
if ~isempty(h_patches)
	delete(h_patches)
end

% resting emg info read in from file and saved in app.resting_emg
if ~isempty(app.resting_emg)
	f_names = fieldnames(app.mvcs);
	for m_cnt = 1:length(f_names)
		muscle = f_names{m_cnt};
		axes_str = ['UIAxes_' muscle];
		for e_cnt = 1:length(app.mvcs.(muscle).begin_t)
			emg_analysis_add_patch(app.(axes_str), app.mvcs.(muscle).begin_t(e_cnt), ...
				app.mvcs.(muscle).end_t(e_cnt))
		end % each patch/event
	end % each muscle
else
	% use data before 1st event in emg_data
	%do for bicep & tricep
	muscle_list = {'bicep' 'tricep'};
	for m_cnt = 1:length(muscle_list)
		muscle = muscle_list{m_cnt};
		ax_var = ['UIAxes_' muscle];
		
		% find the time for resting emg
		% data & time interval to look in
% 		data = app.(ax_var).
% 		emg_analysis_find_rest_emg(app, 
		emg_analysis_add_patch(app.(ax_var), beg_time, end_time, 'resting')
		

	end % each muscle
end
return
end