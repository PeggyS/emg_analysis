%% this takes processed results from 'LeeCalcIMC_CMCNeurospecCompare_Commented' for one control and one stroke subject and plots results for comparison.
%It will need to be modified to account for multiple subjects.
close all
clear all
S=load('C:\Grants\AhlamCDA2\ResubmissionJune2022\ResubmissionDec2022\Data\REdownload\s3103uemp\week01\0007_processedCompare.mat');% stroke path
C=load('C:\Grants\AhlamCDA2\ResubmissionJune2022\ResubmissionDec2022\Data\REdownload\c2795tdvg\Session01\0002_processedCompare.mat');% control path
sig=.016973 %thia value was pulled off of the Neurospec plot dotted significance line  subplot labelled 'Coh...' but I think might be for all combined rest and contract data. significance is based on amount of data which could vary by person unless you keep the length consistent between subjects.
%% first plot intermuscular coherence from Contraction data only
f1S=figure(1)
subplot(3,2,1)
plot(S.Cont.f_bt_c(S.Setup.iFFTmatrix(1):S.Setup.iFFTmatrix(end),1),S.Cont.f_bt_c(S.Setup.iFFTmatrix(1):S.Setup.iFFTmatrix(end),4),'k-')
hold on
plot([S.Cont.f_bt_c(S.Setup.iFFTmatrix(1),1) S.Cont.f_bt_c(S.Setup.iFFTmatrix(end),1)],[sig sig],'k:')
ylabel('IMC Bi/Tri')
axis ([6 55 0 .6])


% I cant recall for sure but I think this was some form of normalization recommended by one of the reviewer papers. It's not intuitive but it turns out to be  linear scaling if you plot the z version against the non-z version.
S.Cont.f_btz_c=S.Cont.f_bt_c(:,4);
 for i=1
        S.Cont.f_btz_c=.5*log10((1+S.Cont.f_bt_c(:,4))./(1-S.Cont.f_bt_c(:,4)));
  end

%% this sums over z-ed intermuscular coherence values over alpha, beta and gamma bands and plots as bars 
S.iIMCz=[] 
for i=1:3
    S.iIMCz=[S.iIMCz sum(S.Cont.f_btz_c(S.Setup.iFFTmatrix(i,1):S.Setup.iFFTmatrix(i,2),1)*S.Cont.f_bt_c(1,1))]
end
subplot(3,2,2)

bar(S.iIMCz)
axis([.4 3.6 0 5]);
ylabel('Bi/Tri');

%% now plot corticomuscular coherence for C3 and triceps using same sig dotted line (since it is based on length of data
subplot(3,2,3)
plot(S.Cont.f_C3t_c(S.Setup.iFFTmatrix(1):S.Setup.iFFTmatrix(end),1),S.Cont.f_C3t_c(S.Setup.iFFTmatrix(1):S.Setup.iFFTmatrix(end),4),'k-')
hold on
plot([S.Cont.f_bt_c(S.Setup.iFFTmatrix(1),1) S.Cont.f_bt_c(S.Setup.iFFTmatrix(end),1)],[sig sig],'k:')
ylabel('CMC C3/Tri')
axis ([6 55 0 .04])
% z tansform
S.Cont.f_C3tz_c=S.Cont.f_C3t_c(:,4);
 for i=1
        S.Cont.f_C3tz_c=.5*log10((1+S.Cont.f_C3t_c(:,4))./(1-S.Cont.f_C3t_c(:,4)));
 end

% sum by band and plot as bars
S.iCMC_C3tz=[]
for i=1:3
    S.iCMC_C3tz=[S.iCMC_C3tz sum(S.Cont.f_C3tz_c(S.Setup.iFFTmatrix(i,1):S.Setup.iFFTmatrix(i,2),1)*S.Cont.f_C3t_c(1,1))]
end
subplot(3,2,4)

bar(S.iCMC_C3tz)
axis([.4 3.6 0 0.06]);
ylabel('C3/Tri');

%% now plot corticomuscular coherence for C3 and biceps using same sig dotted line (since it is based on length of data
subplot(3,2,5)
plot(S.Cont.f_C3b_c(S.Setup.iFFTmatrix(1):S.Setup.iFFTmatrix(end),1),S.Cont.f_C3b_c(S.Setup.iFFTmatrix(1):S.Setup.iFFTmatrix(end),4),'k-')
hold on
plot([S.Cont.f_bt_c(S.Setup.iFFTmatrix(1),1) S.Cont.f_bt_c(S.Setup.iFFTmatrix(end),1)],[sig sig],'k:')
ylabel('CMC C3/Bi')
axis ([6 55 0 .04])

%z transform again
S.Cont.f_C3bz_c=S.Cont.f_C3b_c(:,4);
 for i=1
        S.Cont.f_C3bz_c=.5*log10((1+S.Cont.f_C3b_c(:,4))./(1-S.Cont.f_C3b_c(:,4)));
    end
% sum by band and plot as bars
S.iCMC_C3bz=[]
for i=1:3
    S.iCMC_C3bz=[S.iCMC_C3bz sum(S.Cont.f_C3bz_c(S.Setup.iFFTmatrix(i,1):S.Setup.iFFTmatrix(i,2),1)*S.Cont.f_C3b_c(1,1))]
end
subplot(3,2,6)

bar(S.iCMC_C3bz)
axis([.4 3.6 0 0.06]);
ylabel('C3/Bi');





%% ============Repeat same analysis/plotting process as above but for controls 
f1C=figure(2)
subplot(3,2,1)
plot(C.Cont.f_bt_c(C.Setup.iFFTmatrix(1):C.Setup.iFFTmatrix(end),1),C.Cont.f_bt_c(C.Setup.iFFTmatrix(1):C.Setup.iFFTmatrix(end),4),'k-')
hold on
plot([C.Cont.f_bt_c(C.Setup.iFFTmatrix(1),1) C.Cont.f_bt_c(C.Setup.iFFTmatrix(end),1)],[sig sig],'k:')
ylabel('IMC Bi/Tri')
axis ([6 55 0 .6])

C.Cont.f_btz_c=C.Cont.f_bt_c(:,4);
 for i=1
        C.Cont.f_btz_c=.5*log10((1+C.Cont.f_bt_c(:,4))./(1-C.Cont.f_bt_c(:,4)));
    end

C.iIMCz=[]
for i=1:3
    C.iIMCz=[C.iIMCz sum(C.Cont.f_btz_c(C.Setup.iFFTmatrix(i,1):C.Setup.iFFTmatrix(i,2),1)*C.Cont.f_bt_c(1,1))]
end
subplot(3,2,2)

bar(C.iIMCz)
axis([.4 3.6 0 5]);
ylabel('Bi/Tri');

subplot(3,2,3)
plot(C.Cont.f_C3t_c(C.Setup.iFFTmatrix(1):C.Setup.iFFTmatrix(end),1),C.Cont.f_C3t_c(C.Setup.iFFTmatrix(1):C.Setup.iFFTmatrix(end),4),'k-')
hold on
plot([C.Cont.f_bt_c(C.Setup.iFFTmatrix(1),1) C.Cont.f_bt_c(C.Setup.iFFTmatrix(end),1)],[sig sig],'k:')
ylabel('CMC C3/Tri')
axis ([6 55 0 .04])

C.Cont.f_C3tz_c=C.Cont.f_C3t_c(:,4);
 for i=1
        C.Cont.f_C3tz_c=.5*log10((1+C.Cont.f_C3t_c(:,4))./(1-C.Cont.f_C3t_c(:,4)));
    end

C.iCMC_C3tz=[]
for i=1:3
    C.iCMC_C3tz=[C.iCMC_C3tz sum(C.Cont.f_C3tz_c(C.Setup.iFFTmatrix(i,1):C.Setup.iFFTmatrix(i,2),1)*C.Cont.f_C3t_c(1,1))]
end
subplot(3,2,4)

bar(C.iCMC_C3tz)
axis([.4 3.6 0 0.06]);
ylabel('C3/Tri');

subplot(3,2,5)
plot(C.Cont.f_C3b_c(C.Setup.iFFTmatrix(1):C.Setup.iFFTmatrix(end),1),C.Cont.f_C3b_c(C.Setup.iFFTmatrix(1):C.Setup.iFFTmatrix(end),4),'k-')
hold on
plot([C.Cont.f_bt_c(C.Setup.iFFTmatrix(1),1) C.Cont.f_bt_c(C.Setup.iFFTmatrix(end),1)],[sig sig],'k:')
ylabel('CMC C3/Bi')
axis ([6 55 0 .04])

C.Cont.f_C3bz_c=C.Cont.f_C3b_c(:,4);
 for i=1
        C.Cont.f_C3bz_c=.5*log10((1+C.Cont.f_C3b_c(:,4))./(1-C.Cont.f_C3b_c(:,4)));
    end

C.iCMC_C3bz=[]
for i=1:3
    C.iCMC_C3bz=[C.iCMC_C3bz sum(C.Cont.f_C3bz_c(C.Setup.iFFTmatrix(i,1):C.Setup.iFFTmatrix(i,2),1)*C.Cont.f_C3b_c(1,1))]
end
subplot(3,2,6)

bar(C.iCMC_C3bz)
ylabel('C3/Bi');
axis([.4 3.6 0 0.06]);


%% ---------- now plot control and stroke coherence together on the same plots.

% plot coherence across all designated bands
FSC3=figure(3)
subplot(3,1,1)
plot(S.Cont.f_bt_c(S.Setup.iFFTmatrix(1):S.Setup.iFFTmatrix(end),1),S.Cont.f_bt_c(S.Setup.iFFTmatrix(1):S.Setup.iFFTmatrix(end),4),'r-')
hold on
plot(C.Cont.f_bt_c(C.Setup.iFFTmatrix(1):C.Setup.iFFTmatrix(end),1),C.Cont.f_bt_c(C.Setup.iFFTmatrix(1):C.Setup.iFFTmatrix(end),4),'k-')
plot([S.Cont.f_bt_c(S.Setup.iFFTmatrix(1),1) S.Cont.f_bt_c(S.Setup.iFFTmatrix(end),1)],[sig sig],'k:')
ylabel('IMC Bi/Tri')
axis ([6 55 0 .6])

subplot(3,1,2)
plot(S.Cont.f_C3t_c(S.Setup.iFFTmatrix(1):S.Setup.iFFTmatrix(end),1),S.Cont.f_C3t_c(S.Setup.iFFTmatrix(1):S.Setup.iFFTmatrix(end),4),'r-')
hold on
plot(C.Cont.f_C3t_c(C.Setup.iFFTmatrix(1):C.Setup.iFFTmatrix(end),1),C.Cont.f_C3t_c(C.Setup.iFFTmatrix(1):C.Setup.iFFTmatrix(end),4),'k-')
plot([S.Cont.f_bt_c(S.Setup.iFFTmatrix(1),1) S.Cont.f_bt_c(S.Setup.iFFTmatrix(end),1)],[sig sig],'k:')
ylabel('CMC C3/Tri')
axis ([6 55 0 .04])

subplot(3,1,3)
plot(S.Cont.f_C3b_c(S.Setup.iFFTmatrix(1):S.Setup.iFFTmatrix(end),1),S.Cont.f_C3b_c(S.Setup.iFFTmatrix(1):S.Setup.iFFTmatrix(end),4),'r-')
hold on
plot(C.Cont.f_C3b_c(C.Setup.iFFTmatrix(1):C.Setup.iFFTmatrix(end),1),C.Cont.f_C3b_c(C.Setup.iFFTmatrix(1):C.Setup.iFFTmatrix(end),4),'k-')
plot([S.Cont.f_bt_c(S.Setup.iFFTmatrix(1),1) S.Cont.f_bt_c(S.Setup.iFFTmatrix(end),1)],[sig sig],'k:')
ylabel('CMC C3/Bi')
axis ([6 55 0 .04])

% plot z scored coherence summed by alpha, beta and gamma bands. This is
% the final data you would compare between stroke and control subjects.
FSCBar=figure(4)
subplot(3,1,1)
bar([S.iIMCz' C.iIMCz'])
ylabel('Bi/Tri');
axis([.4 3.6 0 5]);

subplot(3,1,2)
bar([S.iCMC_C3tz' C.iCMC_C3tz'])
ylabel('C3/Tri');
axis([.4 3.6 0 0.06]);
subplot(3,1,3)
bar([S.iCMC_C3bz' C.iCMC_C3bz'])
ylabel('C3/Bi');
axis([.4 3.6 0 0.06]);