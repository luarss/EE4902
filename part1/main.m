clear all;close all; clc;

load('C:\Users\EE4902\Desktop\Song1.mat');

%initialisation
Fs = 1000;
x = data(:,1);

%%% Smoothing original signal
Ns = 1000;
average = ones(1, Ns)/Ns;

avg = filter(average, 1, x);
%figure
%subplot(2,1,1);
%plot(1:N, avg);
%subplot(2,1,2);
%plot(1:N, x);

x = avg;

%psdx = original powerspectrum
N = length(x);
xdft = fft(x);
%xdft = xdft(1:N/2+1);
psdx = xdft;
%psdx = (1/(Fs*N)) * abs(xdft).^2;
%psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:Fs/length(x):Fs;

% power spectrum for x
%{
plot(freq,10*log10(psdx))
grid on
title('Periodogram Using FFT')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')

figure
plot(x)
%}

t = 0:1/Fs:120;
t = transpose(t);
f_powerline = 50;
noise = 0.005*sin(2*pi*f_powerline*t);
x_new = x + noise ;

N = length(x_new);
xdft = fft(x_new);
%xdft = xdft(1:N/2+1);
psdx_new = xdft;
%psdx_new = (1/(Fs*N)) * abs(xdft).^2;
%psdx_new(2:end-1) = 2*psdx_new(2:end-1);
freq = 0:Fs/(2*length(x)):Fs;

% Power spectrum for x_new
%{
plot(freq,10*log10(psdx))
grid on
title('Periodogram Using FFT')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')

figure
plot(x_new)
%}

%%% Design of notch filter here
F0 = 50;                % notch frequency
Fn = Fs/2;              % Nyquist frequency
freqRatio = F0/Fn;      % ratio of notch freq. to Nyquist freq.

notchWidth = 0.01;       % width of the notch

% Compute zeros
notchZeros = [exp( sqrt(-1)*pi*freqRatio ), exp( -sqrt(-1)*pi*freqRatio )];

% Compute poles
notchPoles = (1-notchWidth) * notchZeros;

%figure;
%zplane(notchZeros.', notchPoles.');

b = poly( notchZeros ); %  Get moving average filter coefficients
a = poly( notchPoles ); %  Get autoregressive filter coefficients

%figure;
%freqz(b,a,32000,Fs)

% filter signal x
y = filter(b,a,x_new);

% power spectrum for new y signal
N = length(y);
xdft = fft(y);
%xdft = xdft(1:N/2+1);
psdx_y = xdft;
%psdx_y = (1/(Fs*N)) * abs(xdft).^2;
%psdx_y(2:end-1) = 2*psdx_y(2:end-1);
freq = 0:Fs/length(x):Fs;


%figure
%subplot(3,1,1);
%plot(x);
%subplot(3,1,2);
%plot(x_new);
%subplot(3,1,3);
%plot(y);

figure
subplot(3,1,1);
x=freq(1:end-1);
y=10*log10(psdx);
plot(x,y);
title('\fontsize{16} Original','Color', 'black')
ylabel('power spectrum(db)')
xlabel('frequency')
axis([40 60 -50 50])

subplot(3,1,2);
x1=freq(1:end-1);
y1=10*log10(psdx_new);
plot(x1,y1);
title('\fontsize{16} Introduce 50Hz Noise Signal','Color', 'black')
ylabel('power spectrum(db)')
xlabel('frequency')
axis([40 60 -50 50])

subplot(3,1,3);
x2=freq(1:end-1);
y2=10*log10(psdx_y);
plot(x2,y2);
title('\fontsize{16} Filtered Signal','Color', 'black')
ylabel('power spectrum(db)')
xlabel('frequency')
axis([40 60 -50 50])

