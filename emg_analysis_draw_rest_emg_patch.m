function emg_analysis_draw_rest_emg_patch(app)
% for mvc app, draw draggable patch for defining the lowest or resting emg

h_patches = findobj(app.MVCAnalysisUIFigure, '-regexp', 'Tag', 'patch_.*resting');
if ~isempty(h_patches)
	delete(h_patches)
end

% resting emg info read in from file and saved in app.resting_emg
if ~isempty(fieldnames(app.resting_emg))
	f_names = fieldnames(app.mvcs);
	for m_cnt = 1:length(f_names)
		muscle = f_names{m_cnt};
		axes_str = ['UIAxes_' muscle];
		for e_cnt = 1:length(app.resting_emg.(muscle).begin_t)
			emg_analysis_add_patch(app.(axes_str), app.resting_emg.(muscle).begin_t(e_cnt), ...
				app.resting_emg.(muscle).end_t(e_cnt), 'resting')
		end % each patch/event
	end % each muscle
else
	% This section was intended to make a guess for the best place and 
	% create a resting EMG patch for each axes of data. But is it really 
	% worth the effort? The user can pick a low emg point and add the 
	% resting emg patch.
% 	% use data before 1st event in emg_data
% 	% get muscles
% 	muscle_list = cell(1, length(app.emg_data.chanlocs));
% 	for cnt = 1:length(app.emg_data.chanlocs)
% 		muscle = app.emg_data.chanlocs(cnt).labels;
% 		muscle_list{cnt} = muscle;
% 	end
% 	for m_cnt = 1:length(muscle_list)
% 		muscle = muscle_list{m_cnt};
% 		ax_var = ['UIAxes_' muscle];
% 		
% 		% find the time for resting emg
% 		% data & time interval to look in
% 		line_tag = ['line_' muscle '_hp_filt'];
% 		h_line = findobj(app.(ax_var), 'Tag', line_tag);
% 		if isempty(h_line)
% 			disp(['no emg data line: ' line_tag ' found'])
% 			return
% 		end
%  		data = h_line.XData
% % 		emg_analysis_find_rest_emg(app, 
% 		emg_analysis_add_patch(app.(ax_var), beg_time, end_time, 'resting')
% 		
% 	end % each muscle
end
return
end