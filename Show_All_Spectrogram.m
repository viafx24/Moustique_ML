

Save_Folder_Figure='D:\MATLAB_DATA\Data_Jardin\2022_08_03_Figure';

fds = imageDatastore('D:\MATLAB_DATA\Data_Jardin\2022_08_03_Figure','FileExtensions','.png');

for iteration = 800: length(fds.Files)
    fds.Files{iteration}
    imshow(fds.Files{iteration});
    pause;
    
    
end