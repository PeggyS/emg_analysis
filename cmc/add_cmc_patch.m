function add_cmc_patch(app, t_start, t_end)

h_ax_list = [app.UIAxes_C3 app.UIAxes_C4 app.UIAxes_bicep app.UIAxes_tricep];

h_fig = app.UIFigure;

xdata = [t_start t_start t_end t_end];
tag_str = ['patch_' num2str(round(t_start))];

for h_cnt = 1:length(h_ax_list)
	ylim = h_ax_list(h_cnt).YLim;
	ydata = [ylim(1) ylim(2) ylim(2) ylim(1) ];
	h_p(h_cnt) = patch(h_ax_list(h_cnt), 'XData', xdata, 'YData', ydata, ...
 		'FaceColor', [0.9 0.9 0.4], 'EdgeColor', [0.9 0 0], 'FaceAlpha', 0.5, ...
		'Tag', tag_str);
	draggable(h_p(h_cnt));

	% context menu
	cm = uicontextmenu(h_fig);
	uimenu(cm, 'Text', 'Delete patch', 'MenuSelectedFcn', {@cmc_delete_patch, app, tag_str});
	h_p(h_cnt).ContextMenu = cm;
end

hlink = linkprop(h_p, 'XData');
if isfield(h_fig.UserData, 'links')
	h_fig.UserData.links = [h_fig.UserData.links hlink];
else
	h_fig.UserData.links = hlink;
end

return
end