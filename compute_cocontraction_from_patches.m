function compute_cocontraction_from_patches(app)

app.cocontraction_data = struct;

% for each of the coactivation patches, compute stuff about it
for p_cnt = 1:length(app.coactivation_patches)
	app.cocontraction_data.begin_t
	app.cocontraction_data.end_t
	app.cocontraction_data.begin_angle
	app.cocontraction_data.end_angle
	app.cocontraction_data.cocontraction_auc
end

return
end