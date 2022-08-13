
Rapid=false;

if Rapid == false
    folder='D:\MATLAB_DATA\Data_Analyze\New_Datastore';
    ADS = audioDatastore(folder,'FileExtension','.ogg','IncludeSubfolders',true,'LabelSource','foldernames');
 
end

[adsTrain,adsValidation,adsTest] = splitEachLabel(ADS,0.7,0.2,0.1);

tdsTrain = transform(adsTrain,@audioPreprocess,'IncludeInfo',true);
tdsValidation = transform(adsValidation,@audioPreprocess,'IncludeInfo',true);
tdsTest = transform(adsTest,@audioPreprocess,'IncludeInfo',true);

% [~,info] = read(ADS)
% 
% [data,info] = audioPreprocess(ADS.Files{1},info)

function [data,info] = audioPreprocess(audioIn,info)
class = info.Label;
fs = info.SampleRate;
features = yamnetPreprocess(audioIn,fs);

numSpectrograms = size(features,4);

data = cell(numSpectrograms,2);
for index = 1:numSpectrograms
    data{index,1} = features(:,:,:,index);
    data{index,2} = class;
end
end

