function draw_data(app)

% display the data
h_dlg.Title = 'Drawing the Data';
if ~isempty(app.UIAxes_C3.Children)
	delete(app.UIAxes_C3.Children)
end
line(app.UIAxes_C3, app.time, app.c3_car)
if ~isempty(app.UIAxes_C4.Children)
	delete(app.UIAxes_C4.Children)
end
line(app.UIAxes_C4, app.time, app.c4_car)
if ~isempty(app.UIAxes_bicep.Children)
	delete(app.UIAxes_bicep.Children)
end
line(app.UIAxes_bicep, app.time, app.bicep_filt)
if ~isempty(app.UIAxes_tricep.Children)
	delete(app.UIAxes_tricep.Children)
end
line(app.UIAxes_tricep, app.time, app.tricep_filt)
app.UIAxes_C3.XLim = [0 max(app.time)];

return
end