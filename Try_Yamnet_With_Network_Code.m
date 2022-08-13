%% Prepare datastore

trainingSetup = load("F:\Documents\MATLAB\Moustique_ML\params_2022_08_11__11_17_34.mat");

Rapid=false;

if Rapid == false
    folder='D:\MATLAB_DATA\Data_Analyze\Datastore';
    ADS = audioDatastore(folder,'FileExtension','.ogg','IncludeSubfolders',true,'LabelSource','foldernames');
 
end

[adsTrain,adsValidation,adsTest] = splitEachLabel(ADS,0.7,0.2,0.1);

tdsTrain = transform(adsTrain,@audioPreprocess,'IncludeInfo',true);
tdsValidation = transform(adsValidation,@audioPreprocess,'IncludeInfo',true);
tdsTest = transform(adsTest,@audioPreprocess,'IncludeInfo',true);


%% Training

opts = trainingOptions("adam",...
    "ExecutionEnvironment","auto",...
    "InitialLearnRate",0.0001,...
    "MaxEpochs",2,...
    "Shuffle","every-epoch",...
    "Plots","training-progress",...
    "ValidationData",tdsValidation);


layers = [
    imageInputLayer([96 64 1],"Name","input_1","Normalization","none")
    convolution2dLayer([3 3],32,"Name","conv2d","Padding","same","Stride",[2 2],"Bias",trainingSetup.conv2d.Bias,"Weights",trainingSetup.conv2d.Weights)
    batchNormalizationLayer("Name","b","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.b.Offset,"Scale",trainingSetup.b.Scale,"TrainedMean",trainingSetup.b.TrainedMean,"TrainedVariance",trainingSetup.b.TrainedVariance)
    reluLayer("Name","activation")
    groupedConvolution2dLayer([3 3],1,32,"Name","depthwise_conv2d","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.depthwise_conv2d.Bias,"Weights",trainingSetup.depthwise_conv2d.Weights)
    batchNormalizationLayer("Name","L11","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L11.Offset,"Scale",trainingSetup.L11.Scale,"TrainedMean",trainingSetup.L11.TrainedMean,"TrainedVariance",trainingSetup.L11.TrainedVariance)
    reluLayer("Name","activation_1")
    convolution2dLayer([1 1],64,"Name","conv2d_1","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.conv2d_1.Bias,"Weights",trainingSetup.conv2d_1.Weights)
    batchNormalizationLayer("Name","L12","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L12.Offset,"Scale",trainingSetup.L12.Scale,"TrainedMean",trainingSetup.L12.TrainedMean,"TrainedVariance",trainingSetup.L12.TrainedVariance)
    reluLayer("Name","activation_2")
    groupedConvolution2dLayer([3 3],1,64,"Name","depthwise_conv2d_1","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2],"Bias",trainingSetup.depthwise_conv2d_1.Bias,"Weights",trainingSetup.depthwise_conv2d_1.Weights)
    batchNormalizationLayer("Name","L21","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L21.Offset,"Scale",trainingSetup.L21.Scale,"TrainedMean",trainingSetup.L21.TrainedMean,"TrainedVariance",trainingSetup.L21.TrainedVariance)
    reluLayer("Name","activation_3")
    convolution2dLayer([1 1],128,"Name","conv2d_2","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.conv2d_2.Bias,"Weights",trainingSetup.conv2d_2.Weights)
    batchNormalizationLayer("Name","L22","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L22.Offset,"Scale",trainingSetup.L22.Scale,"TrainedMean",trainingSetup.L22.TrainedMean,"TrainedVariance",trainingSetup.L22.TrainedVariance)
    reluLayer("Name","activation_4")
    groupedConvolution2dLayer([3 3],1,128,"Name","depthwise_conv2d_2","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.depthwise_conv2d_2.Bias,"Weights",trainingSetup.depthwise_conv2d_2.Weights)
    batchNormalizationLayer("Name","L31","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L31.Offset,"Scale",trainingSetup.L31.Scale,"TrainedMean",trainingSetup.L31.TrainedMean,"TrainedVariance",trainingSetup.L31.TrainedVariance)
    reluLayer("Name","activation_5")
    convolution2dLayer([1 1],128,"Name","conv2d_3","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.conv2d_3.Bias,"Weights",trainingSetup.conv2d_3.Weights)
    batchNormalizationLayer("Name","L32","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L32.Offset,"Scale",trainingSetup.L32.Scale,"TrainedMean",trainingSetup.L32.TrainedMean,"TrainedVariance",trainingSetup.L32.TrainedVariance)
    reluLayer("Name","activation_6")
    groupedConvolution2dLayer([3 3],1,128,"Name","depthwise_conv2d_3","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2],"Bias",trainingSetup.depthwise_conv2d_3.Bias,"Weights",trainingSetup.depthwise_conv2d_3.Weights)
    batchNormalizationLayer("Name","L41","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L41.Offset,"Scale",trainingSetup.L41.Scale,"TrainedMean",trainingSetup.L41.TrainedMean,"TrainedVariance",trainingSetup.L41.TrainedVariance)
    reluLayer("Name","activation_7")
    convolution2dLayer([1 1],256,"Name","conv2d_4","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.conv2d_4.Bias,"Weights",trainingSetup.conv2d_4.Weights)
    batchNormalizationLayer("Name","L42","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L42.Offset,"Scale",trainingSetup.L42.Scale,"TrainedMean",trainingSetup.L42.TrainedMean,"TrainedVariance",trainingSetup.L42.TrainedVariance)
    reluLayer("Name","activation_8")
    groupedConvolution2dLayer([3 3],1,256,"Name","depthwise_conv2d_4","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.depthwise_conv2d_4.Bias,"Weights",trainingSetup.depthwise_conv2d_4.Weights)
    batchNormalizationLayer("Name","L51","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L51.Offset,"Scale",trainingSetup.L51.Scale,"TrainedMean",trainingSetup.L51.TrainedMean,"TrainedVariance",trainingSetup.L51.TrainedVariance)
    reluLayer("Name","activation_9")
    convolution2dLayer([1 1],256,"Name","conv2d_5","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.conv2d_5.Bias,"Weights",trainingSetup.conv2d_5.Weights)
    batchNormalizationLayer("Name","L52","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L52.Offset,"Scale",trainingSetup.L52.Scale,"TrainedMean",trainingSetup.L52.TrainedMean,"TrainedVariance",trainingSetup.L52.TrainedVariance)
    reluLayer("Name","activation_10")
    groupedConvolution2dLayer([3 3],1,256,"Name","depthwise_conv2d_5","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2],"Bias",trainingSetup.depthwise_conv2d_5.Bias,"Weights",trainingSetup.depthwise_conv2d_5.Weights)
    batchNormalizationLayer("Name","L61","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L61.Offset,"Scale",trainingSetup.L61.Scale,"TrainedMean",trainingSetup.L61.TrainedMean,"TrainedVariance",trainingSetup.L61.TrainedVariance)
    reluLayer("Name","activation_11")
    convolution2dLayer([1 1],512,"Name","conv2d_6","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.conv2d_6.Bias,"Weights",trainingSetup.conv2d_6.Weights)
    batchNormalizationLayer("Name","L62","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L62.Offset,"Scale",trainingSetup.L62.Scale,"TrainedMean",trainingSetup.L62.TrainedMean,"TrainedVariance",trainingSetup.L62.TrainedVariance)
    reluLayer("Name","activation_12")
    groupedConvolution2dLayer([3 3],1,512,"Name","depthwise_conv2d_6","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.depthwise_conv2d_6.Bias,"Weights",trainingSetup.depthwise_conv2d_6.Weights)
    batchNormalizationLayer("Name","L71","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L71.Offset,"Scale",trainingSetup.L71.Scale,"TrainedMean",trainingSetup.L71.TrainedMean,"TrainedVariance",trainingSetup.L71.TrainedVariance)
    reluLayer("Name","activation_13")
    convolution2dLayer([1 1],512,"Name","conv2d_7","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.conv2d_7.Bias,"Weights",trainingSetup.conv2d_7.Weights)
    batchNormalizationLayer("Name","L72","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L72.Offset,"Scale",trainingSetup.L72.Scale,"TrainedMean",trainingSetup.L72.TrainedMean,"TrainedVariance",trainingSetup.L72.TrainedVariance)
    reluLayer("Name","activation_14")
    groupedConvolution2dLayer([3 3],1,512,"Name","depthwise_conv2d_7","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.depthwise_conv2d_7.Bias,"Weights",trainingSetup.depthwise_conv2d_7.Weights)
    batchNormalizationLayer("Name","L81","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L81.Offset,"Scale",trainingSetup.L81.Scale,"TrainedMean",trainingSetup.L81.TrainedMean,"TrainedVariance",trainingSetup.L81.TrainedVariance)
    reluLayer("Name","activation_15")
    convolution2dLayer([1 1],512,"Name","conv2d_8","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.conv2d_8.Bias,"Weights",trainingSetup.conv2d_8.Weights)
    batchNormalizationLayer("Name","L82","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L82.Offset,"Scale",trainingSetup.L82.Scale,"TrainedMean",trainingSetup.L82.TrainedMean,"TrainedVariance",trainingSetup.L82.TrainedVariance)
    reluLayer("Name","activation_16")
    groupedConvolution2dLayer([3 3],1,512,"Name","depthwise_conv2d_8","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.depthwise_conv2d_8.Bias,"Weights",trainingSetup.depthwise_conv2d_8.Weights)
    batchNormalizationLayer("Name","L91","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L91.Offset,"Scale",trainingSetup.L91.Scale,"TrainedMean",trainingSetup.L91.TrainedMean,"TrainedVariance",trainingSetup.L91.TrainedVariance)
    reluLayer("Name","activation_17")
    convolution2dLayer([1 1],512,"Name","conv2d_9","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.conv2d_9.Bias,"Weights",trainingSetup.conv2d_9.Weights)
    batchNormalizationLayer("Name","L92","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L92.Offset,"Scale",trainingSetup.L92.Scale,"TrainedMean",trainingSetup.L92.TrainedMean,"TrainedVariance",trainingSetup.L92.TrainedVariance)
    reluLayer("Name","activation_18")
    groupedConvolution2dLayer([3 3],1,512,"Name","depthwise_conv2d_9","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.depthwise_conv2d_9.Bias,"Weights",trainingSetup.depthwise_conv2d_9.Weights)
    batchNormalizationLayer("Name","L101","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L101.Offset,"Scale",trainingSetup.L101.Scale,"TrainedMean",trainingSetup.L101.TrainedMean,"TrainedVariance",trainingSetup.L101.TrainedVariance)
    reluLayer("Name","activation_19")
    convolution2dLayer([1 1],512,"Name","conv2d_10","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.conv2d_10.Bias,"Weights",trainingSetup.conv2d_10.Weights)
    batchNormalizationLayer("Name","L102","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L102.Offset,"Scale",trainingSetup.L102.Scale,"TrainedMean",trainingSetup.L102.TrainedMean,"TrainedVariance",trainingSetup.L102.TrainedVariance)
    reluLayer("Name","activation_20")
    groupedConvolution2dLayer([3 3],1,512,"Name","depthwise_conv2d_10","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.depthwise_conv2d_10.Bias,"Weights",trainingSetup.depthwise_conv2d_10.Weights)
    batchNormalizationLayer("Name","L111","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L111.Offset,"Scale",trainingSetup.L111.Scale,"TrainedMean",trainingSetup.L111.TrainedMean,"TrainedVariance",trainingSetup.L111.TrainedVariance)
    reluLayer("Name","activation_21")
    convolution2dLayer([1 1],512,"Name","conv2d_11","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.conv2d_11.Bias,"Weights",trainingSetup.conv2d_11.Weights)
    batchNormalizationLayer("Name","L112","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L112.Offset,"Scale",trainingSetup.L112.Scale,"TrainedMean",trainingSetup.L112.TrainedMean,"TrainedVariance",trainingSetup.L112.TrainedVariance)
    reluLayer("Name","activation_22")
    groupedConvolution2dLayer([3 3],1,512,"Name","depthwise_conv2d_11","BiasLearnRateFactor",0,"Padding","same","Stride",[2 2],"Bias",trainingSetup.depthwise_conv2d_11.Bias,"Weights",trainingSetup.depthwise_conv2d_11.Weights)
    batchNormalizationLayer("Name","L121","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L121.Offset,"Scale",trainingSetup.L121.Scale,"TrainedMean",trainingSetup.L121.TrainedMean,"TrainedVariance",trainingSetup.L121.TrainedVariance)
    reluLayer("Name","activation_23")
    convolution2dLayer([1 1],1024,"Name","conv2d_12","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.conv2d_12.Bias,"Weights",trainingSetup.conv2d_12.Weights)
    batchNormalizationLayer("Name","L122","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L122.Offset,"Scale",trainingSetup.L122.Scale,"TrainedMean",trainingSetup.L122.TrainedMean,"TrainedVariance",trainingSetup.L122.TrainedVariance)
    reluLayer("Name","activation_24")
    groupedConvolution2dLayer([3 3],1,1024,"Name","depthwise_conv2d_12","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.depthwise_conv2d_12.Bias,"Weights",trainingSetup.depthwise_conv2d_12.Weights)
    batchNormalizationLayer("Name","L131","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L131.Offset,"Scale",trainingSetup.L131.Scale,"TrainedMean",trainingSetup.L131.TrainedMean,"TrainedVariance",trainingSetup.L131.TrainedVariance)
    reluLayer("Name","activation_25")
    convolution2dLayer([1 1],1024,"Name","conv2d_13","BiasLearnRateFactor",0,"Padding","same","Bias",trainingSetup.conv2d_13.Bias,"Weights",trainingSetup.conv2d_13.Weights)
    batchNormalizationLayer("Name","L132","Epsilon",0.0001,"ScaleLearnRateFactor",0,"Offset",trainingSetup.L132.Offset,"Scale",trainingSetup.L132.Scale,"TrainedMean",trainingSetup.L132.TrainedMean,"TrainedVariance",trainingSetup.L132.TrainedVariance)
    reluLayer("Name","activation_26")
    globalAveragePooling2dLayer("Name","global_average_pooling2d")
    fullyConnectedLayer(2,"Name","fc","BiasLearnRateFactor",10,"WeightLearnRateFactor",10)
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];


[net, traininfo] = trainNetwork(tdsTrain,layers,opts);


%% Analyze Result

data = readall(tdsTest);
YTest = [data{:,2}];
YPred = classify(trainedNetwork_1,tdsTest);

accuracy = sum(YPred == YTest')/numel(YTest)


%% helper function

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

