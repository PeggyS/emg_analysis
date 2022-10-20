function compute_cocontraction_from_patches(app)

app.cocontraction_data = struct;

% elbow angle data
h_elb_angle_line = findobj(app.UIAxes_elbow_angle, 'Tag', 'line_elbow_angle_lpfilt');


% for each of the coactivation patches, compute stuff about it
for p_cnt = 1:length(app.coactivation_patches)
	t_begin = min(app.coactivation_patches(p_cnt).Vertices(:,1));
	t_end = max(app.coactivation_patches(p_cnt).Vertices(:,1));
	app.cocontraction_data.begin_t(p_cnt) = t_begin;
	app.cocontraction_data.end_t(p_cnt) = t_end;
	ind_begin = find(h_elb_angle_line.XData >= t_begin, 1, 'first');
	ind_end = find(h_elb_angle_line.XData >= t_end, 1, 'first');
	app.cocontraction_data.begin_angle(p_cnt) = h_elb_angle_line.YData(ind_begin);
	app.cocontraction_data.end_angle(p_cnt) = h_elb_angle_line.YData(ind_end);
	app.cocontraction_data.cocontraction_auc(p_cnt) = compute_auc(app.coactivation_patches(p_cnt).Vertices);
end

return
end