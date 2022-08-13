Rapid=true;

if Rapid == false
    folder='D:\MATLAB_DATA\Data_Analyze\New_Datastore';
    ADS = audioDatastore(folder,'FileExtension','.ogg','IncludeSubfolders',true,'LabelSource','foldernames');
 
end

audioIn=audioread(ADS.Files{1});


spectrograms=yamnetPreprocess(audioIn,8000);

for i=1:9
    arbitrarySpect = spectrograms(:,:,1,i);
    surf(arbitrarySpect,EdgeColor="none")
    view([90 -90])
    xlabel("Mel Band")
    ylabel("Frame")
    title("Mel Spectrogram for YAMNet")
    axis tight
    pause
end