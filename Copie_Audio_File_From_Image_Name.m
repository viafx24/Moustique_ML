clearvars;
close all force;


Image_Folder='D:\MATLAB_DATA\Data_Analyze\2022_08_03_5S_Figure-For_New_Selection';
Audio_Folder='D:\MATLAB_DATA\Data_Analyze\2022_08_03_5S_Audio-Selection\';
Audio_Selection_Folder='D:\MATLAB_DATA\Data_Analyze\2022_08_03_5S_Audio-For_New_Selection\';

imds = imageDatastore(Image_Folder)

for iteration = 1:length(imds.Files)
    
    Name_Image=imds.Files{iteration}
    
    Name_Audio=[Audio_Folder, Name_Image(68:end-4),'.ogg']
    New_name_Audio=[Audio_Selection_Folder,Name_Image(68:end-4),'.ogg']
    copyfile(Name_Audio,New_name_Audio)
    iteration
end


