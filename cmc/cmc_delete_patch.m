function cmc_delete_patch(src, event, app, tag_str)

h_obj = findobj(app.UIFigure, 'Tag', tag_str);
if ~isempty(h_obj)
	delete(h_obj)
end

return
end