
clearvars;
close all force;

load('Filter_8k_400_300.mat')
resampling_Factor=8000;



folder='D:\MATLAB_DATA\Data_Jardin\2022_08_03'
ADS = audioDatastore(folder,'FileExtension','.aac')

Save_Folder='D:\MATLAB_DATA\Data_Jardin\2022_08_03_5S';
Save_Folder_Figure='D:\MATLAB_DATA\Data_Jardin\2022_08_03_5S_Figure';

f = waitbar(0,'Please wait...');
tic
Length_Min=2855622;
Segment_Per_Minute=12;
Length_Segment=ceil(Length_Min/Segment_Per_Minute)



for iteration = 825 : 1000
    iteration_3=0;
    y = audioread(ADS.Files{iteration});
    ADS.Files{iteration}
    
    for iteration_2=1:Length_Segment:Length_Min-Length_Segment
        y_resamp = resample(y(iteration_2:(iteration_2+Length_Segment)-1),resampling_Factor,48000);
        yfilter=filter(Filter_8k_400_300,y_resamp);
        yfilterGain=yfilter*5;
        
        iteration_3 = iteration_3 + 1 ;
        New_Name_Audio=[Save_Folder, ADS.Files{iteration}(38:end-4),'_',num2str(iteration_3,'%03.f'),'.ogg']
        Name_Spectrogram = [Save_Folder_Figure, ADS.Files{iteration}(38:end-4),'_',num2str(iteration_3,'%03.f'),'.png'];
        audiowrite(New_Name_Audio,yfilterGain,resampling_Factor);
        pspectrum(y_resamp,resampling_Factor,'spectrogram','TimeResolution', 0.1,'FrequencyLimits',[400 4000]);
        %     savefig(gcf,Name_Spectrogram,'compact');
        saveas(gcf,Name_Spectrogram);
        close gcf;
    end
    waitbar(iteration/length(ADS.Files),f,'Please wait...');
end

%min(Length_All)
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



% for iteration = 825 : 1000
%     i=i+1;
%     y = audioread(ADS.Files{iteration});
%     ADS.Files{iteration}
%     Length_All(i)=length(y);
%     
% end