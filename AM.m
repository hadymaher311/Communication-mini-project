% read from audio file
[audio, sample_rate] = audioread('speech_dft_8khz.wav');
% make sure that the audio is 1D vector
audio = audio(:,1);
% DC component
Ac = abs(min(audio) / 0.9);
% carrier frequency and sample rate
carr_freq = 100000;
carr_sample_rate = carr_freq* 3;
% resample the audio to the carrier sample rate
audio = resample(audio, carr_sample_rate, sample_rate);
% carrier omega
Wc = 2 * pi * carr_freq;
% time vector
size_of_audio = size(audio);
t = (1:size_of_audio(1));
t = transpose(t);
% modulated signal
St = (Ac + audio(t)) .* cos(Wc * t);
% loop in SNR from 0 to 20 dB
for SNR = 0:20
    % calculate the signal with noise
    audio_noise = awgn(St, SNR);
    % calcualte the demodulated signal
    demod = abs(hilbert(audio_noise)) - mean(abs(hilbert(audio_noise)));
    % resample it to the base sample rate
    demod = resample(demod, sample_rate, carr_sample_rate);
    % listen to the signal
    sound(demod);
    pause(5);
end
