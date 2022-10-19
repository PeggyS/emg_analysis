function end_event_move_callback(h_line)

% disp('end_event_move_callback')

% h_line.UserData contains the app
app = h_line.UserData;

% new end time
t_end = h_line.XData(1);

% event/patch number
tmp = regexp(h_line.Tag, '\d*$', 'match');
assert(~isempty(tmp), ['end_event_move_callback.m - could not find the event number from the line: ' ...
	h_line.Tag])
event_num = str2double(tmp{:});

% update the coactivation_patch for this line
update_coactivation_patch(app, event_num, t_end)

return
end