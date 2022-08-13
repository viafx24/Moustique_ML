
clearvars;

Rapid=false;

if Rapid == false
    folder='D:\MATLAB_DATA\Data_Analyze\New_Datastore';
    ADS = audioDatastore(folder,'FileExtension','.ogg','IncludeSubfolders',true,'LabelSource','foldernames');
    %data = readall(ADS)
    
    
    indices_train=[1:250,333:333+1000];
    ADSsusbsetTrain=subset(ADS,indices_train);
    Training_Data_Cell=readall(ADSsusbsetTrain);
    Training_Data_Double=[Training_Data_Cell{1:end}];
    
    indices_validation=[251:332,1334:length(ADS.Files)];
    ADSsusbsetValidation=subset(ADS,indices_validation);
    Validation_Data_Cell=readall(ADSsusbsetValidation);
    Validation_Data_Double=[Validation_Data_Cell{1:end}];
    
end


Mosquito_Labels = repelem(categorical("mosquito"),332,1);
Background_Labels = repelem(categorical("unknown"),1400,1);


labelsTrain=[Mosquito_Labels(1:250);Background_Labels(1:1001)];
labelsValidation = [Mosquito_Labels(251:332);Background_Labels(1002:1400)];

length(Training_Data_Cell)
length(Validation_Data_Cell)
length(labelsTrain)
length(labelsValidation)


fs=8000;

% aFE = audioFeatureExtractor("SampleRate",fs, ...
%     "SpectralDescriptorInput","melSpectrum", ...
%     "spectralCentroid",true, ...
%     "spectralSlope",true);


aFE = audioFeatureExtractor("SampleRate",fs);
in = info(aFE,"all");
featureSwitches = fields(in);
cellfun(@(x)aFE.set(x,true),featureSwitches)

featuresTrain = extract(aFE,Training_Data_Double);

featuresTrain = permute(featuresTrain,[2,1,3]);
featuresTrain = squeeze(num2cell(featuresTrain,[1,2]));
[numFeatures,numHopsPerSequence] = size(featuresTrain{1})

featuresValidation = extract(aFE,Validation_Data_Double);
featuresValidation = permute(featuresValidation,[2,1,3]);
featuresValidation = squeeze(num2cell(featuresValidation,[1,2]));


% layers = [ ...
%     sequenceInputLayer(numFeatures)
%     lstmLayer(50,"OutputMode","last")
%     fullyConnectedLayer(2)
%     softmaxLayer
%     classificationLayer];



layers = [ ...
    %sequenceInputLayer(size(featuresTrain{1},1))
    sequenceInputLayer(numFeatures)
    bilstmLayer(50,"OutputMode","sequence")
    bilstmLayer(50,"OutputMode","last")
    fullyConnectedLayer(2)
    softmaxLayer
    classificationLayer];



options = trainingOptions("adam", ...
    "Shuffle","every-epoch", ...
    "ValidationData",{featuresValidation,labelsValidation}, ...
    "Plots","training-progress", ...
    "Verbose",false);


net = trainNetwork(featuresTrain,labelsTrain,layers,options);

