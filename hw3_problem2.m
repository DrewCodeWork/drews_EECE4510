%Andrew Simon
%EECE 4510 - Intro to DSP
%HW 3 - 11/22/2022
%
% Reference for code: Blandford & Parr Ch 7 & Dr. Frederick Frigo
% Edited by Andrew Simon

%Clear workspace between runs
clear all, close all, clc

%% (1) Setup given waveform and parameters

% Given input signal
fs = 1500; T = 1/fs;
Pts = 1024;
t = 0:T:(Pts-1)*T;
s = chirp(t,0,Pts*T,100);

fs = 1500;              % Initial sampling freq (Hz)
fup = 3500;             % Up-sample freq
[U D] = rat(fup/fs);    % Scale factors
cutoffFreq = [0 400];
rp = 0.001;             % Passband ripple
rs = 0.001;             % Stopband ripple
ripple = [rp rs];
amp = [1 0];            % Amplitude

%% (2) Create & apply up-sampled filter with Parks-McClellan

[n,fo,ao,w] = firpmord(cutoffFreq,amp, ripple,fs*U);  % Find order & paramters of filter
h1 = firpm(n,fo,ao,w);                                    % Find up-sampled filter coefficients

z1 = filter(h1,1,s);    % Filter the input signal

%% (3) Down-sample filter samples to get result
z2 = downsample(z1,D);
tz2 = downsample(t,D);

%% (4) Print / Plot output results

% Show rational factors
U % Show up-sample factor
D % Show down-sample factor

% Show difference between signal samples
up_size =length(z1)
down_size = length(z2)

% Plot results
figure, hold on
plot(t,s)
plot(t,z1)
plot(tz2,z2)
hold off
legend('Initial Signal','Up-Sample Filter','Down-Sampled Result')
xlabel("Time (s)"), ylabel ("Input X[n], Output Y[n]")
title("Filter From Rational Up-Sampling")

% Create plot with closer view of output
figure, hold on
plot(t,s)
plot(t,z1)
plot(tz2,z2)
hold off
legend('Initial Signal','Up-Sample Filter','Down-Sampled Result')
xlabel("Time (s)"), ylabel ("Input X[n], Output Y[n]")
title("Filter From Rational Up-Sampling")
xlim([0.014 0.024]), ylim([0.05 0.35])