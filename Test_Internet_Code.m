    N=1024;
    n=0:N-1;
    w0=2*pi/5;
    x=sin(w0*n)+10*sin(2*w0*n);
    s=spectrogram(x);
    spectrogram(x,'yaxis');
    saveas(gcf,'filename.png'); %Use to display save as image