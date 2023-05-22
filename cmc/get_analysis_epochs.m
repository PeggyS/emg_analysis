function get_analysis_epochs(app)

app.analysis_epochs = [];

save_loc = get_save_path(app, false);
if save_loc == 0
	% no epochs saved
	return
end

[~,fname,~] = fileparts(app.FileNameLabel.Text);
save_file = fullfile(save_loc, [fname '_epochs.txt']);
if exist(save_file, 'file') ~= 2
	% no epoch file found
	return
end

read_epoch_info(app, save_file)

return
end