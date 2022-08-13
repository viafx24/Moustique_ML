[audioIn,fs] = audioread('F:\Documents\MATLAB\Moustique_ML\Data\Mosquito\21.mp4');


%[audioIn,fs] = audioread('F:\Documents\MATLAB\Moustique_ML\no.aac');

melSpectrogram(audioIn,fs,'FrequencyRange',[200,5000],'WindowLength',2000);