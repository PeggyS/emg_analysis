function ind = find_channel_index(emg_data, chan_label)
% look through emg_data's chanlocs.labels. find the index of the channel
% label sent. If channel is not found, empty ind is returned.

ind = [];
for l_cnt = 1:length(emg_data.chanlocs)
	if contains(emg_data.chanlocs(l_cnt).labels, chan_label)
		ind = l_cnt;
		return
	end
end % check each label

return
end