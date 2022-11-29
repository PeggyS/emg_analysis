function compute_cocontraction_from_patches(app)

app.cocontraction_data = struct;

% are we looking at elbow angle or hand movement data?
if contains(app.UIAxes_elbow_angle.YLabel.String, 'Hand')
% 	target_motion = 'hand';
	line_tag = 'line_hand_distance_lpfilt';
elseif contains(app.UIAxes_elbow_angle.YLabel.String, 'Elbow')
% 	target_motion = 'elbow_angle';
	line_tag = 'line_elbow_angle_lpfilt';
elseif contains(app.UIAxes_elbow_angle.YLabel.String, 'MCP')
	line_tag = 'line_mcp_angle_lpfilt';
else
	error('add_movement_end_event.m - could not determine if hand position, elbow angle, or mcp angle is used')
end

if app.BendOnlyButton.Value == 1 || app.ExtendOnlyButton.Value == 1 || ...
		app.BendExtendButton.Value == 1 || app.FingerExtendButton.Value == 1
	% elbow angle or hand position data
	h_motion_line = findobj(app.UIAxes_elbow_angle, 'Tag', line_tag);
end


% for each of the coactivation patches, compute stuff about it
for p_cnt = 1:length(app.coactivation_patches)
	muscle_list = fieldnames(app.coactivation_patches);
	muscle_1 = muscle_list{1};
	muscle_2 = muscle_list{2};
	% begin & end times
	t_begin = min(app.coactivation_patches(p_cnt).(muscle_1).Vertices(:,1));
	t_end = max(app.coactivation_patches(p_cnt).(muscle_1).Vertices(:,1));
	app.cocontraction_data.begin_t(p_cnt) = t_begin;
	app.cocontraction_data.end_t(p_cnt) = t_end;
	
	if app.BendOnlyButton.Value == 1 || app.ExtendOnlyButton.Value == 1 || ...
			app.BendExtendButton.Value == 1 || app.FingerExtendButton.Value == 1
		% begin and end angle
		ind_begin = find(h_motion_line.XData >= t_begin, 1, 'first');
		ind_end = find(h_motion_line.XData >= t_end, 1, 'first');
		app.cocontraction_data.begin_angle(p_cnt) = h_motion_line.YData(ind_begin);
		app.cocontraction_data.end_angle(p_cnt) = h_motion_line.YData(ind_end);
	end
	
	% flexor/muscle_1 emg auc
	app.cocontraction_data.flexor_auc(p_cnt) = compute_auc(app.coactivation_patches(p_cnt).(muscle_1).Vertices);
	% extensor/muscle_2 emg auc
	app.cocontraction_data.extensor_auc(p_cnt) = compute_auc(app.coactivation_patches(p_cnt).(muscle_2).Vertices);
	
	% coactivation = antagonist auc / agonist auc
	% calc depends on the motion
	if app.BendOnlyButton.Value == 1 || app.IsometricBicepButton.Value == 1
		app.cocontraction_data.antagonist_agonist_ratio(p_cnt) = ...
			app.cocontraction_data.extensor_auc(p_cnt) / app.cocontraction_data.flexor_auc(p_cnt);
	elseif app.FingerExtendButton.Value == 1
		app.cocontraction_data.antagonist_agonist_ratio(p_cnt) = ...
			app.cocontraction_data.flexor_auc(p_cnt) / app.cocontraction_data.extensor_auc(p_cnt);
	elseif app.ExtendOnlyButton.Value == 1 || app.IsometricTricepButton.Value == 1
		app.cocontraction_data.antagonist_agonist_ratio(p_cnt) = ...
			app.cocontraction_data.flexor_auc(p_cnt) / app.cocontraction_data.extensor_auc(p_cnt);
	elseif app.BendExtendButton.Value == 1
		% need to figure out if this event is a bend or extend
		closest_event_num = 0;
		closest_event_distance = inf;
		for e_cnt = 1:length(app.emg_data.event)
			if contains(lower(app.emg_data.event(e_cnt).code), 'bend') || ...
			   contains(lower(app.emg_data.event(e_cnt).code), 'extend')
				event_distance = t_begin - app.emg_data.event(e_cnt).time;
				if event_distance < closest_event_distance && event_distance >= 0
					closest_event_distance = event_distance;
					closest_event_num = e_cnt;
				end
			end
		end
% 		keyboard
		switch lower(app.emg_data.event(closest_event_num).code)
			case 'bend'
				app.cocontraction_data.motion{p_cnt} = 'bend';
				app.cocontraction_data.antagonist_agonist_ratio(p_cnt) = ...
					app.cocontraction_data.extensor_auc(p_cnt) / app.cocontraction_data.flexor_auc(p_cnt);
			case 'extend'
				app.cocontraction_data.motion{p_cnt} = 'extend';
				app.cocontraction_data.antagonist_agonist_ratio(p_cnt) = ...
					app.cocontraction_data.flexor_auc(p_cnt) / app.cocontraction_data.extensor_auc(p_cnt);
			otherwise
				error('compute_cocontraction_from_patches.m - could not find event for patch')
		end
	else
		error('compute_cocontraction_from_patches.m: no radio button for type of experiment found.')
	end
end

return
end