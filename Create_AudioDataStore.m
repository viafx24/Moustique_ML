
Rapid= false;

if Rapid == false
    folder='F:\Documents\MATLAB\Moustique_ML\Data'
    ADS = audioDatastore(folder,'FileExtension','.mp4','IncludeSubfolders',true)
    data = readall(ADS)
end

data_Mosquito=[data{1:60}];
data_Background=[data{61:120}];

Mosquito_Labels = repelem(categorical("Mosquito"),60,1);
Background_Labels = repelem(categorical("Background"),60,1);

audioTrain=[data_Mosquito(:,1:40),data_Background(:,1:40)];
labelsTrain=[Mosquito_Labels(1:40);Background_Labels(1:40)];

audioValidation = [data_Mosquito(:,41:60),data_Background(:,41:60)];
labelsValidation = [Mosquito_Labels(41:60);Background_Labels(41:60)];


fs=48000;
aFE = audioFeatureExtractor("SampleRate",fs, ...
    "SpectralDescriptorInput","melSpectrum", ...
    "spectralCentroid",true, ...
    "spectralSlope",true);


% aFE = audioFeatureExtractor("SampleRate",fs);
% 
% in = info(aFE,"all");
% featureSwitches = fields(in);
% cellfun(@(x)aFE.set(x,true),featureSwitches)
% 




featuresTrain = extract(aFE,audioTrain);
[numHopsPerSequence,numFeatures,numSignals] = size(featuresTrain);


featuresTrain = permute(featuresTrain,[2,1,3]);
featuresTrain = squeeze(num2cell(featuresTrain,[1,2]));

numSignals = numel(featuresTrain)
[numFeatures,numHopsPerSequence] = size(featuresTrain{1})



featuresValidation = extract(aFE,audioValidation);
featuresValidation = permute(featuresValidation,[2,1,3]);
featuresValidation = squeeze(num2cell(featuresValidation,[1,2]));


length(featuresTrain)
length(labelsTrain)
length(featuresValidation)
length(labelsValidation)


layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(50,"OutputMode","last")
    fullyConnectedLayer(numel(unique(labelsTrain)))
    softmaxLayer
    classificationLayer];


options = trainingOptions("adam", ...
    "Shuffle","every-epoch", ...
    "ValidationData",{featuresValidation,labelsValidation}, ...
    "Plots","training-progress", ...
    "Verbose",false);

net = trainNetwork(featuresTrain,labelsTrain,layers,options);