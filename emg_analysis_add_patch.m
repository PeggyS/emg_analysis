function emg_analysis_add_patch(h_axes, time)

x_min = time;
x_max = time + 0.5;
y_min = h_axes.YLim(1);
y_max = h_axes.YLim(2);

h_patch = patch(h_axes, 'XData', [x_min x_min x_max x_max], ...
	'YData', [y_min y_max y_max y_min], ...
	'FaceColor', [0.8 0.1 0.3], ...
	'FaceAlpha', 0.5, ...
	'Tag', ['patch_' lower(h_axes.YLabel.String) '_mvc']);

% make it draggable
draggable(h_patch, 'h');
return
end