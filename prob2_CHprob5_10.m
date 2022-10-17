% Andrew Simon
% EECE 4510 - Intro to DSP

% The following code is an adjusted version based on prior EECE 4510 work
% for HW #2 problem 10 and Blandford & Parr Chapter 5

%Clear workspace between runs
clear all, close all, clc

% (1) Set parameters of low-pass and high-pass FIR filters
fs = 22.05 * 1000;      %Sample freq of filters
fc_lp = 5.5 * 1000;     %Cutoff freq of low-pass
fc_hp = 3 * 1000;       %Cutoff freq of high-pass
N = 20;                 %Order of filters
len = N + 1;            %Length to use for window

% (2) Compute filter designs using fir1(), hamming window, and paramenters
lpFilter = fir1(N, fc_lp/(fs/2), "low", hamming(len));       %Low-pass filter
[H_lp, f_lp] = freqz(lpFilter, 1, 1024, fs);

hpFilter = fir1(N, fc_hp/(fs/2), "high", hamming(len));      %High-pass filter
[H_hp, f_hp] = freqz(hpFilter, 1, 1024, fs);

bpFilter = conv(lpFilter,hpFilter);                            %Bandpass filter = convolution
[H_bp, f_bp] = freqz(bpFilter, 1, 1024, fs);

% (3) Plot magnitude of all windowed filters
figure(2), clf, hold on
plot(f_lp,abs(H_lp),f_hp,abs(H_hp),f_bp,abs(H_bp))
legend('Low-Pass','High-Pass','Bandpass')
title('Problem 2 (B&P 5.10): Bandpass Filter through Cascading')

%Decibel form
%plot(f_lp,20*log10(abs(H_lp)),f_hp,20*log10(abs(H_hp)), ...
%    f_bp,20*log10(abs(H_bp)))

%Apply formatting of figure
grid on, xlabel('Freq (Hz)'), ylabel('Magnitude')