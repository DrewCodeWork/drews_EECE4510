%Andrew Simon
%EECE 4510 - Intro to DSP
%HW 3 - 11/22/2022
%
% Reference for code: Blandford & Parr Ch 7 & Dr. Frederick Frigo
% Edited by Andrew Simon

%Clear workspace between runs
clear all, close all, clc

%% Part (a) information & base signals at original sample

% Set given parameters
fs = 10 * 1000; %sample freq
f1 = 1000;      %sinusoid 1 freq = 1,000Hz
f2 = 3000;      %sinusoid 2 freq = 3,000Hz

% Calculate and plot signals
tEnd = 0.002;  % 2 msec period
Tx = 0:1/fs:tEnd;
x1 = sin(2*pi*f1*Tx); % Sinusoid 1
x2 = sin(2*pi*f2*Tx); % Sinusoid 2

figure, hold on
plot(Tx,x1,'- .')
plot(Tx,x2,'- o')
hold off
legend('F1 = 1kHz','F2 = 3kHz')
xlabel("Time (s)"), ylabel ("Sinusoid Output F(x)")
title("Original Sample of Signals")

%% Part (b) down-sample by factor of 2

% Set downsampling parameters
D = 2;          %downsampling factor

% Apply downsampling and plot result
Ty = downsample(Tx,D);      %downsample time vals
y1 = downsample(x1,D);      %downsample sinusoid 1
y2 = downsample(x2,D);      %downsample sinusoid 2
%Ty1 = (0:numel(y1)-1)/fds;
%y2 = resample(x2,1,D);      %resample sinusoid 2
%Ty2 = (0:numel(y2)-1)/fds;

figure, hold on
plot(Ty,y1,'- .')
plot(Ty,y2,'- o')
hold off
legend('F1 = 1kHz','F2 = 3kHz')
xlabel("Time (s)"), ylabel ("Sinusoid Output F(x)")
title("Down-Sampled Signals (D = 2)")


%% Combined signal output

xt = x1 + x2;
yt = y1 + y2;
figure, hold on
plot(Tx,xt,'- .')
plot(Ty,yt,'- o')
hold off
legend('Initial Signal Sample','Down-Sampled Signal')
xlabel("Time (s)"), ylabel ("Sinusoid Output F(x)")
title("Overall Signal Comparison")