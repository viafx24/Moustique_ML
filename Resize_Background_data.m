clearvars;
close all force;

folder='D:\MATLAB_DATA\Data_Analyze\Datastore\unknown'
ADS = audioDatastore(folder,'FileExtension','.ogg')

% Save_Folder='D:\MATLAB_DATA\Data_Jardin\2022_08_03_5S';
% Save_Folder_Figure='D:\MATLAB_DATA\Data_Jardin\2022_08_03_5S_Figure';



for iteration = 1:1400
iteration
y = audioread(ADS.Files{iteration});
audiowrite(ADS.Files{iteration},y(1:39662),8000);
%     New_Name_Audio=[Save_Folder, ADS.Files{iteration}(38:end-4),'_',num2str(iteration_3,'%03.f'),'.ogg']
%     Name_Spectrogram = [Save_Folder_Figure, ADS.Files{iteration}(38:end-4),'_',num2str(iteration_3,'%03.f'),'.png'];
    
end    
    
    
