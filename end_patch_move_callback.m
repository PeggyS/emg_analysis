function end_patch_move_callback(h_patch)

% disp('end_patch_move_callback')


% new patch times
begin_t = min(h_patch.XData);
end_t = max(h_patch.XData);

% rms value in the patch
rms_val = compute_rms(h_patch.Parent, begin_t, end_t);

% update the patch datatip
h_patch.DataTipTemplate.DataTipRows(3).Value = repmat(rms_val, size(h_patch.DataTipTemplate.DataTipRows(3).Value));


return
end