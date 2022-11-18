function rms_val = compute_rms(h_axes, begin_t, end_t)
% within the h_axes, compute the rms value of the envelope line between the begin and end times

% get the envelope line in the axes
h_line = findobj(h_axes, '-regexp', 'Tag', '.*_envelope');
% extract data during the begin & end times
data = h_line.YData(h_line.XData > begin_t & h_line.XData <= end_t);
% rms value
rms_val = rms(data);