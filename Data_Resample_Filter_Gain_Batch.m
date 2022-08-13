
clearvars;
close all force;

load('Filter_500_200.mat');

folder='D:\MATLAB_DATA\Data_Jardin\2022_08_03'
ADS = audioDatastore(folder,'FileExtension','.aac')

Save_Folder='D:\MATLAB_DATA\Data_Jardin\2022_08_03_Corrected';
Save_Folder_Figure='D:\MATLAB_DATA\Data_Jardin\2022_08_03_Figure';

f = waitbar(0,'Please wait...');
tic


for iteration = 1 : length(ADS.Files)
    
    y = audioread(ADS.Files{iteration});
    y_resamp = resample(y,8000,48000);
    yfilter=filter(Hd_500_200,y_resamp);
    yfilterGain=yfilter*5;
    
    New_Name_Audio=[Save_Folder, ADS.Files{iteration}(38:end-4),'.ogg'];
    Name_Spectrogram = [Save_Folder_Figure, ADS.Files{iteration}(38:end-4),'.png'];
    audiowrite(New_Name_Audio,yfilterGain,8000);
    pspectrum(y_resamp,8000,'spectrogram','TimeResolution', 0.1,'FrequencyLimits',[500 4000]);
%     savefig(gcf,Name_Spectrogram,'compact');
    saveas(gcf,Name_Spectrogram);
    close gcf;
    waitbar(iteration/length(ADS.Files),f,'Please wait...'); 
end
toc
% Rapid= true;
%
% if Rapid == false
%
%     data = readall(ADS)
% end
%
%
% [y,Fs] = audioread('F:\Documents\MATLAB\Moustique_ML\no.aac');
%

%
% Resample_Filtered_Gain_Name='F:\Documents\MATLAB\Moustique_ML\yes_Resample_Filtered_Gain.ogg'
% audiowrite(Resample_Filtered_Gain_Name,yfilterGain,8000);
%
% pspectrum(yfilterGain,8000,'spectrogram','TimeResolution', 0.1)


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
