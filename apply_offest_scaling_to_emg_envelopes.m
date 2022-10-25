function apply_offest_scaling_to_emg_envelopes(app)

% find the bicep & tricep channel indices
bicep_ind = find_channel_index(app.emg_data, 'bicep');
tricep_ind = find_channel_index(app.emg_data, 'tricep');

% subtract resting_emg offset
bicep_offset = mean(app.resting_emg.bicep.rms_value);
app.emg_data.linear_envelope(bicep_ind,:) = app.emg_data.linear_envelope(bicep_ind,:) - offset;
tricep_offset = mean(app.resting_emg.tricep.rms_value);
app.emg_data.linear_envelope(tricep_ind,:) = app.emg_data.linear_envelope(tricep_ind,:) - offset;

% scale by mean mvc (mvc = 100)
scale  = mean(app.mvcs.bicep.rms_value) - bicep_offset;
app.emg_data.linear_envelope(bicep_ind,:) = app.emg_data.linear_envelope(bicep_ind,:) / scale * 100;
scale  = mean(app.mvcs.tricep.rms_value) - tricep_offset;
app.emg_data.linear_envelope(tricep_ind,:) = app.emg_data.linear_envelope(tricep_ind,:) / scale * 100;

% make any values below zero, zero
app.emg_data.linear_envelope(app.emg_data.linear_envelope < 0) = 0;

return
end