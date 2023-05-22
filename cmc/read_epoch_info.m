function read_epoch_info(app, file_name)

	% read in file, parse for the info
	keywords = {'t_start' 't_end' };

	defaults = {[], []};

	try
		paramscell = readparamfile(file_name, keywords, defaults);
	catch ME
		% keyboard
		rethrow(ME)
	end

	app.analysis_epochs.t_start       = paramscell{1};
	app.analysis_epochs.t_end         = paramscell{2};

return
end