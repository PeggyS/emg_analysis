function out = hpfilt(in, ord, cutoff, sampf)

% make sure it's column defined data (each column is a channel of data to filter)
[m,n] = size(in);
switchFlg = false;
if n>m 	%% row-wise data sent
	in = in';
	switchFlg = true;
end

% define the filter
nyqf = sampf/2;
[b,a] = butter(ord, cutoff/nyqf, 'high');

% filter each column of data
out = nan(size(in));
for i = 1:size(in,2)
	out(:,i) = filtfilt(b,a,double(in(:,i)));
end

% if data sent was switched from row-wise to col-wise, switch it back
if switchFlg
	out = out';
end