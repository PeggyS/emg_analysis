function compute_cocontraction_from_patches(app)

app.cocontraction_data = struct;

if app.BendOnlyButton.Value == 1 || app.ExtendOnlyButton.Value == 1
	% elbow angle data
	h_elb_angle_line = findobj(app.UIAxes_elbow_angle, 'Tag', 'line_elbow_angle_lpfilt');
end


% for each of the coactivation patches, compute stuff about it
for p_cnt = 1:length(app.coactivation_patches)
	% begin & end times
	t_begin = min(app.coactivation_patches(p_cnt).bicep.Vertices(:,1));
	t_end = max(app.coactivation_patches(p_cnt).bicep.Vertices(:,1));
	app.cocontraction_data.begin_t(p_cnt) = t_begin;
	app.cocontraction_data.end_t(p_cnt) = t_end;
	
	if app.BendOnlyButton.Value == 1 || app.ExtendOnlyButton.Value == 1
		% begin and end angle
		ind_begin = find(h_elb_angle_line.XData >= t_begin, 1, 'first');
		ind_end = find(h_elb_angle_line.XData >= t_end, 1, 'first');
		app.cocontraction_data.begin_angle(p_cnt) = h_elb_angle_line.YData(ind_begin);
		app.cocontraction_data.end_angle(p_cnt) = h_elb_angle_line.YData(ind_end);
	end
	
	% bicep emg auc
	app.cocontraction_data.bicep_auc(p_cnt) = compute_auc(app.coactivation_patches(p_cnt).bicep.Vertices);
	% tricep emg auc
	app.cocontraction_data.tricep_auc(p_cnt) = compute_auc(app.coactivation_patches(p_cnt).tricep.Vertices);
	
	% coactivation = antagonist auc / agonist auc
	% calc depends on the motion
	if app.BendOnlyButton.Value == 1 || app.IsometricBicepButton.Value == 1
		app.cocontraction_data.antagonist_agonist_ratio(p_cnt) = ...
			app.cocontraction_data.tricep_auc(p_cnt) / app.cocontraction_data.bicep_auc(p_cnt);
	elseif app.ExtendOnlyButton.Value == 1 || app.IsometricTricepButton.Value == 1
		app.cocontraction_data.antagonist_agonist_ratio(p_cnt) = ...
			app.cocontraction_data.bicep_auc(p_cnt) / app.cocontraction_data.tricep_auc(p_cnt);
	elseif app.BendExtendButton.Value == 1
		% FIXME - not implemented yet
		% need to figure out if this event is a bend or extend
	else
		error('compute_cocontraction_from_patches.m: no radio button for type of experiment found.')
	end
end

return
end