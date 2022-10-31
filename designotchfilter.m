% designotchfilter.m
tic
Fs = 2500;
designed_filter = designfilt('bandstopiir','FilterOrder',10, ...
               'HalfPowerFrequency1',59,'HalfPowerFrequency2',61, ...
               'DesignMethod','butter','SampleRate',Fs);
toc
% fvtool(d,'Fs',Fs)
% save('notch60_fs2500.mat', 'designed_filter', '-mat')