function write_info(fileName, info)
% writes the info from a struct into a text file of the name specified
% fileName		complete path and file name (with extension) of file to write
% info		struct of info

% open the file
fid = fopen(fileName, 'w');

% get the fieldnames of the info struct
fldNames = fieldnames(info);

% each field
for fld = 1:length(fldNames)
	% write the name of the field
	fprintf(fid, '%s : ', fldNames{fld});
	% write the data
	if ischar(info.(fldNames{fld}))
		fprintf(fid, '%s', info.(fldNames{fld}));
	elseif iscell(info.(fldNames{fld}))
		for cnt = 1:length(info.(fldNames{fld}))
			fprintf(fid, '%s ', info.(fldNames{fld}){cnt});
		end
	else
		fprintf(fid, '%g ', info.(fldNames{fld}));
	end
	fprintf(fid, '\n');
end

% close the file
fclose(fid);

