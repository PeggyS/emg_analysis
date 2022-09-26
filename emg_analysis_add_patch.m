function emg_analysis_add_patch(h_axes, begin_t, end_t)

x_min = begin_t;
x_max = end_t;
y_min = h_axes.YLim(1);
y_max = h_axes.YLim(2);

h_patch = patch(h_axes, 'XData', [x_min x_min x_max x_max], ...
	'YData', [y_min y_max y_max y_min], ...
	'FaceColor', [0.5 0.3 0.5], ...
	'FaceAlpha', 0.25, ...
	'Tag', ['patch_' lower(h_axes.YLabel.String) '_mvc']);

% make it draggable
draggable(h_patch, 'h');
return
end