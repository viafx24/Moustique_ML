

[y1,Fs] = audioread('F:\Documents\MATLAB\Moustique_ML\yes.aac');

% y = resample(y1,1,3);
% 
% figure
% plot(y1(1:20),'-b+')
% hold on
% plot(y(1:20),'-r+')

% 
% fs = 10;
% t1 = 0:1/fs:1;
% x = y1;
% y = resample(x,3,2);
% t2 = (0:(length(y)-1))*2/(3*fs);
% 
% plot(t1,x,'*',t2,y,'o')
close all force

[y,Fs] = audioread('F:\Documents\MATLAB\Moustique_ML\yes.aac');
% figure
% pspectrum(y,48000,'spectrogram','TimeResolution', 0.1)
y_resamp = resample(y,8000,48000);


%pspectrum(y,8000,'spectrogram','TimeResolution', 0.1,'FrequencyLimits',[200 10000])
% figure
% pspectrum(y_resamp,8000,'spectrogram','TimeResolution', 0.1)

yfilter=filter(Hd_500_200,y_resamp);



% Resample_Name='F:\Documents\MATLAB\Moustique_ML\yes_Resample_8k.ogg'
% audiowrite(Resample_Name,y_resamp,8000);

Resample_Filtered_Name='F:\Documents\MATLAB\Moustique_ML\yes_Resample_Filtered.ogg'
audiowrite(Resample_Filtered_Name,yfilter,8000);

Resample_Filtered_Gain_Name='F:\Documents\MATLAB\Moustique_ML\yes_Resample_Filtered_Gain.ogg'
yfilterGain=yfilter*5;
audiowrite(Resample_Filtered_Gain_Name,yfilterGain,8000);