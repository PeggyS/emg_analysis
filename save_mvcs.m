function save_mvcs(app)

% get default save path
save_path = get_save_path(app, true);
if save_path==0
	disp('No MVC info was saved')
	return
end


% analyzer's initials and date
analysis_by = upper(app.AnalysisbyEditField.Value);
analysis_date = app.AnalysisdateEditField.Value;

% save separate file for each muscle
muscle_names  = fieldnames(app.mvcs);
for m_cnt = 1:length(muscle_names)
	muscle = muscle_names{m_cnt};

	% add analysis info
	app.mvcs.(muscle).analysis_by = analysis_by;
	app.mvcs.(muscle).analysis_date = analysis_date;

	% file name
	save_file = fullfile(save_path, [muscle '_mvcs.txt']);

	if exist(save_file, 'file') == 2
		selected_option = uiconfirm(app.MVCAnalysisUIFigure, [save_file 'already exists. Do you want to overwrite it?'], ...
			'Confirm Save', 'Options', {'Yes','No'});
		if contains(selected_option, 'Yes')
			% write the file
			write_info(save_file, app.mvcs.(muscle))
		end
	end
end % each muscle

return
end