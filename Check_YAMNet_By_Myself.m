

Rapid=false;

if Rapid == false
    folder='D:\MATLAB_DATA\Data_Analyze\Datastore';
    ADS = audioDatastore(folder,'FileExtension','.ogg','IncludeSubfolders',true,'LabelSource','foldernames');

end
%
%
% audioIn=audioread(ADS.Files{1000});
%
% info.Label="mosquito";
% info.SampleRate=8000;
% [data,info] = audioPreprocess(audioIn,info);


for iteration=2000:2100 
    ADS_Only_One_File = subset(ADS,iteration);
    TDS_Only_One_File = transform(ADS_Only_One_File,@audioPreprocess,'IncludeInfo',true);

    YPred = classify(trainedNetwork_1,TDS_Only_One_File)
    pause
end
%  data = readall(tdsTest);
% YTest = [data{:,2}];
% YPred = classify(trainedNetwork_1,tdsTest);
%
% accuracy = sum(YPred == YTest')/numel(YTest)



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