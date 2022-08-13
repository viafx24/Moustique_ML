
Fs=48000;

[y1,Fs] = audioread('F:\Documents\MATLAB\Moustique_ML\yes.aac');
[y2,Fs] = audioread('F:\Documents\MATLAB\Moustique_ML\no.aac');


Length_To_Get_min=[length(y1) length(y2)];
Length_Echantillon=floor(min(Length_To_Get_min)/60);

i=0;  
tic
for iteration=1:Length_Echantillon:min(Length_To_Get_min)-Length_Echantillon
    
    i=i+1;
    y=y1(iteration:(iteration+Length_Echantillon)-1);
%    length(y);
    filename = ['F:\Documents\MATLAB\Moustique_ML\Data\Mosquito\' int2str(i) '.mp4'];
    audiowrite( filename,y,Fs);
    
    y=y2(iteration:(iteration+Length_Echantillon)-1);
%    length(y);
    filename = ['F:\Documents\MATLAB\Moustique_ML\Data\No_Mosquito\' int2str(i) '.mp4'];
    audiowrite( filename,y,Fs);
    
end 

toc