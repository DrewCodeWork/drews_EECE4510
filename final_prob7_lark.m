% EECE 4510 - Marquette University
% Final, Andrew Simon
% Problem 7 - Blandford & Parr 11.19
%
% References:
% MATLAB example code, Fred J. Frigo, Ph.D.
% Example on reading and plotting meadowlar audio
% Lecture 12/1/22
%

% Clear workspace between runs
clear all, clc

%% (1) Read & plot mp4 file data
filename = 'meadowlark_song.mp4'; % File to read in

audioinfo(filename)
[y Fs] = audioread(filename);
Ts = 1/Fs; %sample period
num_samples = max(size(y));
Tts = Ts * num_samples; % total sample time

% Channel data
x1 = y(:,1); % channel 1
x2 = y(:,2); % channel 2

% Plot channel 1 data
t = linspace(0,Tts,num_samples);
figure();
plot(t,x1);
xlabel("Time (s)"), ylabel("Amplitude")
title("Audio File Ch1 Data", filename, 'Interpreter','none')

%% (2) Apply CWT and plot spectral information
wavelet_type = 'morse'; % Set wavelet type to use

figure()
cwt(x1, wavelet_type, Fs);   % Apply CWT to channel 1 data