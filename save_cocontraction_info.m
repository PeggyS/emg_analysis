function save_cocontraction_info(app)
% get default save path
save_path = get_save_path(app, true);
if save_path==0
	disp('No Cocontraction  info was saved')
	return
end


% analyzer's initials and date
analysis_by = upper(app.AnalysisbyEditField.Value);
analysis_date = app.AnalysisdateEditField.Value;


% add analysis info
app.cocontraction_data.analysis_by = analysis_by;
app.cocontraction_data.analysis_date = analysis_date;


% get experiment type
if app.BendOnlyButton.Value == 1
	type = 'bend';
elseif app.ExtendOnlyButton.Value == 1
	type = 'extend';
elseif app.BendExtendButton == 1
	type = 'bend_extend';
else
	error('save_cocontraction_info.m - did not find experiment type')
end

% file name
[~,fname,~] = fileparts(app.FileNameLabel.Text);

save_file = fullfile(save_path,  [fname '_' type '_cocontraction_info.txt']);

if exist(save_file, 'file') == 2
	selected_option = uiconfirm(app.CoConUIFigure, [save_file 'already exists. Do you want to overwrite it?'], ...
		'Confirm Save', 'Options', {'Yes','No'});
	if contains(selected_option, 'Yes')
		% write the file
		write_info(save_file, app.cocontraction_data)
	end
else
	% write the file
	write_info(save_file, app.cocontraction_data)
end

return
end