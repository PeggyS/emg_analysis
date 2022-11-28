function compute_mvcs(app)

patch_tag_list = {'patch_bicep_mvc', 'patch_tricep_mvc', ...
	'patch_fingerflexors_mvc', 'patch_fingerextensors_mvc'};
for p_cnt = 1:length(patch_tag_list)
	patch_tag = patch_tag_list{p_cnt};
	% find the mvc patches
	h_patches = findobj(app.MVCAnalysisUIFigure, 'Tag', patch_tag);

	if ~isempty(h_patches)
		
		% which muscle
		muscle_mvc = strrep(patch_tag, 'patch_', '');
		muscle = strrep(muscle_mvc, '_mvc', '');
		
		% emg envelope data line
		tag_str = ['line_' muscle '_envelope'];
		h_line = findobj(app.MVCAnalysisUIFigure, 'Tag', tag_str);
		assert(~isempty(h_line), ['No ' tag_str ' found'])
		
		% each mvc patch
		for m_cnt = 1:length(h_patches)
			t_patch_min = h_patches(m_cnt).XData(1);
			t_patch_max = h_patches(m_cnt).XData(3);
			patch_data = h_line.YData(h_line.XData > t_patch_min & h_line.XData <= t_patch_max);
			app.mvcs.(muscle).begin_t(m_cnt) = t_patch_min;
			app.mvcs.(muscle).end_t(m_cnt) = t_patch_max;
			app.mvcs.(muscle).rms_value(m_cnt) = rms(patch_data);
			
		end % each mvc patch
	end
end

return
end