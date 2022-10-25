function save_resting_emg(app)

% get default save path
save_path = get_save_path(app, true);
if save_path==0
	disp('No Resting EMG info was saved')
	return
end


% analyzer's initials and date
analysis_by = upper(app.AnalysisbyEditField.Value);
analysis_date = app.AnalysisdateEditField.Value;

% save separate file for each muscle
muscle_names  = fieldnames(app.resting_emg);
for m_cnt = 1:length(muscle_names)
	muscle = muscle_names{m_cnt};

	% add analysis info
	app.resting_emg.(muscle).analysis_by = analysis_by;
	app.resting_emg.(muscle).analysis_date = analysis_date;

	% file name
	save_file = fullfile(save_path, [muscle '_resting_emg.txt']);

	if exist(save_file, 'file') == 2
		selected_option = uiconfirm(app.MVCAnalysisUIFigure, [save_file 'already exists. Do you want to overwrite it?'], ...
			'Confirm Save', 'Options', {'Yes','No'});
		if contains(selected_option, 'Yes')
			% write the file
			write_info(save_file, app.resting_emg.(muscle))
		end
	else
		% write the file
		write_info(save_file, app.resting_emg.(muscle))
	end
end % each muscle

return
end