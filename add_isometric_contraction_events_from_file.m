function add_isometric_contraction_events_from_file(app)
% 

for cnt = 1:length(app.cocontraction_data.begin_t)

	% look for the closest move event location to the begin_t
	closest_event_num = 0;
	closest_event_distance = inf;
	if ~isempty(app.emg_data)
		for e_cnt = 1:length(app.emg_data.event)
			if contains(lower(app.emg_data.event(e_cnt).code), 'bend') || ...
					contains(lower(app.emg_data.event(e_cnt).code), 'extend')
				event_distance = abs(app.cocontraction_data.begin_t(cnt) - app.emg_data.event(e_cnt).time);
				if event_distance < closest_event_distance
					% event is to the left of the begin_t
					closest_event_distance = event_distance;
					closest_event_num = e_cnt;
				end
			end
		end
	end
% 	if closest_event_num == 14
% 		keyboard
% 	end
	add_isometric_contraction_end_event(app, closest_event_num, app.cocontraction_data.end_t(cnt))
	% 			drawnow
	add_coactivation_patch(app, closest_event_num)

end
return
end