clear all;close all; clc;

load('C:\Users\EE4902\Desktop\Song1.mat');

%initialisation
fs = 1000;
x = data(:,1);

%t = 0:1/fs:2;
%spectrogram(x,4000,120,4000,1e3); 

%s = spectrogram(x);

%nx = length(x); %length of signal
%nsc = 4000;
%nov = 1000; 
%nff = max(256,2^nextpow2(nsc));

%spectrogram(x,hamming(nsc),nov,nff);
%spectrogram(x,hamming(nsc),30,512,fs,'yaxis')
%maxerr = max(abs(abs(t(:))-abs(s(:))))

%colormap bone
%view(-45,65)

xlen = length(x); %length of signal              
t = (0:xlen-1)/1e3;  
wlen = 4096; % window length (recomended to be power of 2)
nfft = 8*wlen;  
hop = wlen * 0.75;% hop size

w1 = hanning(wlen, 'periodic');
%spectrogram(x, w1, wlen-hop, nfft, fs);

[Y,F,T,P]= spectrogram(x, kaiser(4000,5), wlen-hop, nfft, fs);
h = surf(T,F,10*log10(abs(P)));
set(h,'LineStyle', 'none');
colorbar;
axis tight;
%view(0,90);
%stft(x,fs,'Window',kaiser(4000,1),'OverlapLength',1000,'FFTLength',3000);
%view(-45,65);
%view(-50,50);
colormap jet;
TFD=colorbar;
title(TFD,'Power/Frequency(db/Hz)');
ylabel('Frequency(Hz)')
xlabel('Time(s)')

%figure
%z = 10*log10(abs(P))
%mesh(T,F,z);
%colormap jet;
%TFD=colorbar;
%title(TFD,'Power/Frequency(db/Hz)');
%ylabel('Frequency(Hz)')
%xlabel('Time(s)')
