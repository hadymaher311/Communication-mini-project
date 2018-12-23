% pkg load communications
%Original Signal
[x, fs] = audioread('speech_dft_8khz.wav');
sound(x, fs, 16);
plot(x)

%Modulated Signal
%fm = 'New.wav' 
%t = 0:1/fs:10;
%w=2*pi*100000*t;
%audiowrite(fm, cos(cos(w/1500).*w), fs);
%[y,fs]=audioread('New.wav');
%sound(y, fs, 16);
%plot (y);

% FM Modualtion
fdev = fc/5;
audiowrite(fm, fmmod(x,100000,fs,fdev), fs);
[y,fs]=audioread('New.wav');
sound(y, fs, 16);
plot (y);

%Add Random Noise
noised = awgn(y,10,'measured');

%Demodulate
audiowrite(fm, fmdemod(noised,fc,fs,fDev), fs);
[z,fs]=audioread('New.wav');
sound(z, fs, 16);
plot (z);
