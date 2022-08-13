% clear all;
close all;

% figure
 %[y,Fs] = audioread('\\BOX\CleMichel\USB_Cam_Mangeoire\Test\video_Chaque_Seconde_15000_LD.mp4');
[y,Fs] = audioread('D:\MATLAB_DATA\Data_Analyze\2022_08_03_5S_Audio-Selection\Track_03-Aug-2022_19-55-56_001.ogg');

%pspectrum(y(:,1),Fs,'spectrogram','TimeResolution', 1,'FrequencyLimits',[1000 50000])
%pspectrum(y(1:length(y)/8,1),Fs,'spectrogram','TimeResolution', 0.01,'FrequencyLimits',[1000 5000])
%fig=gcf;ax=fig.CurrentAxes;fig.Color='w';fig.OuterPosition=fig.InnerPosition;
%pspectrum(y,Fs,'spectrogram','TimeResolution', 0.1,'FrequencyLimits',[400 4000])


[p,f,t]=pspectrum(y,Fs,'spectrogram','TimeResolution', 0.1,'FrequencyLimits',[700 4000])


A=normalize(p,'range',[0 1]);
B=flipud(A)
imshow(B);
colormap(gca, jet(256));
imwrite(B,'test.png')
size(p)
size(f)
size(t)
%mesh(t,f,p)
% windowSize = 256;
% windowOverlap = [];
% freqRange = 400:4000;
% data=spectrogram(y, windowSize, windowOverlap, freqRange, Fs, 'yaxis');
% Test=im2uint8(data);
% imshow(Test)
%set(gca,'visible','off')

%image(p,'CDataMapping','scaled')
axis off
colorbar('off')
set(gca,'LooseInset',get(gca,'TightInset'));
saveas(gcf,'test.png')
delete(findall(findall(gcf,'Type','axe'),'Type','text'))
%

% figure
% [y,Fs] = audioread('\\BOX\CleMichel\USB_Cam_Mangeoire\Backup_For_Sound\video_1600_1M_10FPS_45sec.mp4');
% pspeczzzzzzzzzzzzzzzzzzztrum(y(:,1),Fs,'spectrogram')

% y(288*length(y)/600:291*length(y)/600,1)