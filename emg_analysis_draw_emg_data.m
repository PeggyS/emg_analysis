function emg_analysis_draw_emg_data(app)
% part of the emg_analysis app, draw or update the data in the emg axes

% find the bicep & tricep channel indices
bicep_ind = find_channel_index(app.emg_data, 'bicep');
tricep_ind = find_channel_index(app.emg_data, 'tricep');

line(app.UIAxes_bicep, app.emg_data.times/1000, app.emg_data.data_hp_filt(bicep_ind,:))
line(app.UIAxes_tricep, app.emg_data.times/1000, app.emg_data.data_hp_filt(tricep_ind,:))

return
end