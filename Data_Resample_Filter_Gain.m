
clearvars;
close all force;

load('Filter_8k_400_300.mat')
resampling_Factor=8000;

[y,Fs] = audioread('D:\MATLAB_DATA\Data_Jardin\2022_08_03\Track_03-Aug-2022_19-05-08.aac');

y_resamp = resample(y,resampling_Factor,48000);
yfilter=filter(Filter_8k_400_300,y_resamp);
yfilterGain=yfilter*5;

Resample_Filtered_Gain_Name='F:\Documents\MATLAB\Moustique_ML\yes_Resample_Filtered_Gain.ogg'
audiowrite(Resample_Filtered_Gain_Name,yfilterGain,resampling_Factor);

pspectrum(yfilterGain,resampling_Factor,'spectrogram','TimeResolution', 0.1,'FrequencyLimits',[400 4000])


% % Resample_Name='F:\Documents\MATLAB\Moustique_ML\yes_Resample_8k.ogg'
% % audiowrite(Resample_Name,y_resamp,8000);
% 
% Resample_Filtered_Name='F:\Documents\MATLAB\Moustique_ML\yes_Resample_Filtered.ogg'
% audiowrite(Resample_Filtered_Name,yfilter,8000);
% 
% Resample_Filtered_Gain_Name='F:\Documents\MATLAB\Moustique_ML\yes_Resample_Filtered_Gain.ogg'
% 
% audiowr%pspectrum(y,8000,'spectrogram','TimeResolution', 0.1,'FrequencyLimits',[200 10000])
% % figure
% % pspectrum(y_resamp,8000,'spectrogram','TimeResolution', 0.1)
