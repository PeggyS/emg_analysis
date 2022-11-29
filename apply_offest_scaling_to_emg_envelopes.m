function apply_offest_scaling_to_emg_envelopes(app)

% muscle_list = {'bicep', 'tricep', 'fingerflexors', 'fingerextensors'};
muscle_list = fieldnames(app.mvcs);

for m_cnt = 1:length(muscle_list)
	muscle = muscle_list{m_cnt};
	% find the muscle channel index
	muscle_ind = find_channel_index(app.emg_data, muscle);

	% subtract resting_emg offset
	offset = min(app.resting_emg.(muscle).rms_value);
	app.emg_data.linear_envelope(muscle_ind,:) = app.emg_data.linear_envelope(muscle_ind,:) - offset;
	
	% scale by mean mvc (mvc = 100)
	scale  = max(app.mvcs.(muscle).rms_value) - offset;
	app.emg_data.linear_envelope(muscle_ind,:) = app.emg_data.linear_envelope(muscle_ind,:) / scale * 100;

	% make any values below zero, zero
	app.emg_data.linear_envelope(app.emg_data.linear_envelope < 0) = 0;
end
return
end