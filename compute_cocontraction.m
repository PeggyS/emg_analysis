function compute_cocontraction(app)
% use bicep and tricep emg data with mvcs (for normalization) to compute
% co-contraction index using Falconer and Winter, 1985 formula

% CCI =  2 * (emg flexors) /( emg flexors + emg extensors) * 100%


% find the bicep & tricep channel indices
bicep_ind = find_channel_index(app.emg_data, 'bicep');
tricep_ind = find_channel_index(app.emg_data, 'tricep');

bicep_mvc = mean(app.mvcs.bicep.rms_value);
tricep_mvc = mean(app.mvcs.tricep.rms_value);

bicep_norm = app.emg_data.linear_envelope(bicep_ind,:) / bicep_mvc;
tricep_norm = app.emg_data.linear_envelope(tricep_ind,:) / tricep_mvc;

app.cci_data = 2 * (bicep_norm) ./ (bicep_norm + tricep_norm) * 100;
