function draw_results(app)

% ffts
if ~isempty(app.UIAxes_C3_fft.Children)
	delete(app.UIAxes_C3_fft.Children)
end
line(app.UIAxes_C3_fft, app.c3_bicep.f(:,1), app.c3_bicep.f(:,2)); % f col 2  = c3fft
if ~isempty(app.UIAxes_bicep_fft.Children)
	delete(app.UIAxes_bicep_fft.Children)
end
line(app.UIAxes_bicep_fft, app.c3_bicep.f(:,1), app.c3_bicep.f(:,3)); % f col 3 = bicep fft
if ~isempty(app.UIAxes_C4_fft.Children)
	delete(app.UIAxes_C4_fft.Children)
end
line(app.UIAxes_C4_fft, app.c4_bicep.f(:,1), app.c4_bicep.f(:,2)); % f col 2  = c4 fft
if ~isempty(app.UIAxes_tricep_fft.Children)
	delete(app.UIAxes_tricep_fft.Children)
end
line(app.UIAxes_tricep_fft, app.c3_tricep.f(:,1), app.c3_tricep.f(:,3)); % f col 3 = tricep fft

% coherences
if ~isempty(app.UIAxes_C3_bicep_coh.Children)
	delete(app.UIAxes_C3_bicep_coh.Children)
end
line(app.UIAxes_C3_bicep_coh, app.c3_bicep.f(:,1), app.c3_bicep.f(:,4));
line(app.UIAxes_C3_bicep_coh, [0 100], [app.c3_bicep.cl.ch_c95 app.c3_bicep.cl.ch_c95], ...
	'LineStyle', '--', 'Color', [0.9 0 0]);
if ~isempty(app.UIAxes_C4_bicep_coh.Children)
	delete(app.UIAxes_C4_bicep_coh.Children)
end
line(app.UIAxes_C4_bicep_coh, app.c4_bicep.f(:,1), app.c4_bicep.f(:,4));
line(app.UIAxes_C4_bicep_coh, [0 100], [app.c4_bicep.cl.ch_c95 app.c4_bicep.cl.ch_c95], ...
	'LineStyle', '--', 'Color', [0.9 0 0]);
if ~isempty(app.UIAxes_C3_tricep_coh.Children)
	delete(app.UIAxes_C3_tricep_coh.Children)
end
line(app.UIAxes_C3_tricep_coh, app.c3_tricep.f(:,1), app.c3_tricep.f(:,4));
line(app.UIAxes_C3_tricep_coh, [0 100], [app.c3_tricep.cl.ch_c95 app.c3_tricep.cl.ch_c95], ...
	'LineStyle', '--', 'Color', [0.9 0 0]);
if ~isempty(app.UIAxes_C4_tricep_coh.Children)
	delete(app.UIAxes_C4_tricep_coh.Children)
end
line(app.UIAxes_C4_tricep_coh, app.c4_tricep.f(:,1), app.c4_tricep.f(:,4));
line(app.UIAxes_C4_tricep_coh, [0 100], [app.c4_tricep.cl.ch_c95 app.c4_tricep.cl.ch_c95], ...
	'LineStyle', '--', 'Color', [0.9 0 0]);
if ~isempty(app.UIAxes_bicep_tricep_coh.Children)
	delete(app.UIAxes_bicep_tricep_coh.Children)
end
line(app.UIAxes_bicep_tricep_coh, app.bicep_tricep.f(:,1), app.bicep_tricep.f(:,4));
line(app.UIAxes_bicep_tricep_coh, [0 100], [app.bicep_tricep.cl.ch_c95 app.bicep_tricep.cl.ch_c95], ...
	'LineStyle', '--', 'Color', [0.9 0 0]);

% show freq bands
ax_list = [app.UIAxes_C3_bicep_coh, app.UIAxes_C4_bicep_coh, ...
	app.UIAxes_C3_tricep_coh, app.UIAxes_C4_tricep_coh, ...
	app.UIAxes_bicep_tricep_coh];
for a_cnt = 1:length(ax_list)
	ylim = ax_list(a_cnt).YLim;
	patch(ax_list(a_cnt), 'XData', [app.alpha_band(1), app.alpha_band(1), app.alpha_band(2), app.alpha_band(2)], ...
		'YData', [ylim(1) ylim(2) ylim(2) ylim(1)], ...
		'FaceColor', [235, 237, 49]/255, 'EdgeColor', [0.5 0.5 0.5], 'FaceAlpha', 0.3);
	patch(ax_list(a_cnt), 'XData', [app.beta_band(1), app.beta_band(1), app.beta_band(2), app.beta_band(2)], ...
		'YData', [ylim(1) ylim(2) ylim(2) ylim(1)], ...
		'FaceColor', [63, 221, 194]/255, 'EdgeColor', [0.5 0.5 0.5], 'FaceAlpha', 0.3);
	patch(ax_list(a_cnt), 'XData', [app.low_gamma_band(1), app.low_gamma_band(1), app.low_gamma_band(2), app.low_gamma_band(2)], ...
		'YData', [ylim(1) ylim(2) ylim(2) ylim(1)], ...
		'FaceColor', [180, 131, 253]/255, 'EdgeColor', [0.5 0.5 0.5], 'FaceAlpha', 0.3);
	patch(ax_list(a_cnt), 'XData', [app.high_gamma_band(1), app.high_gamma_band(1), app.high_gamma_band(2), app.high_gamma_band(2)], ...
		'YData', [ylim(1) ylim(2) ylim(2) ylim(1)], ...
		'FaceColor', [203, 152, 178]/255, 'EdgeColor', [0.5 0.5 0.5], 'FaceAlpha', 0.3);
end

return
end