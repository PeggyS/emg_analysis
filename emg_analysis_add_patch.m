function emg_analysis_add_patch(h_axes, begin_t, end_t, type)
% draw a draggable patch

if nargin < 4 % type not defined, default = mvc
	type = 'mvc';
end
	
% color depending on type
switch lower(type)
	case 'mvc'
		color = [0.5 0.3 0.5];
	case 'resting'
		color = [68 156 126]/255;
	otherwise
		color = [0.8 0.8 0.8];
end

x_min = begin_t;
x_max = end_t;
y_min = h_axes.YLim(1);
y_max = h_axes.YLim(2);

h_patch = patch(h_axes, 'XData', [x_min x_min x_max x_max], ...
	'YData', [0 y_max y_max 0], ...
	'FaceColor', color, ...
	'FaceAlpha', 0.25, ...
	'Tag', ['patch_' lower(h_axes.YLabel.String) '_' type]);

% data tip to show the mean emg value in the patch - FIXME
datatip(h_patch, 'Location', 'southeast');
% array the same length as the vertices of the patch
rms_vaue = compute_rms(h_axes, begin_t, end_t); 
t1 = repelem(rms_vaue,1,size(h_patch.Vertices,1));
dt_row = dataTipTextRow('rms:', t1);
h_patch.DataTipTemplate.DataTipRows(end+1) = dt_row;

% make it draggable
draggable(h_patch, 'h', @end_patch_move_callback);
return
end