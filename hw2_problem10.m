%Andrew Simon
%EECE 4510 - Intro to DSP
%HW 2 - 9/29/2022
%
% Reference for code: Blandford & Parr Ch 5
% Edited by Andrew Simon

%Clear workspace between runs
clear all, close all, clc

%Set parameters of filter
fs = 44.1 * 1000;   %sample freq
fc = 8 * 1000;      %cutoff freq
lenList = [6, 9, 12, 15]; %lengths to use

%Plot all windowed filters
figure(10); clf;
hold on
legList = zeros([1 length(lenList)]);

for i = 1:length(lenList)
    %Designing windowed filter
    L = lenList(i);                         %Set length
    N = lenList(i) - 1;                     %Set length L-1 to use for linear phase
    numR = fir1(N,fc/(fs/2),rectwin(L));
    [Hr f] = freqz(numR, 1,1024,fs);
    
    %Plot windowed filter
    plot(f, 20*log10(abs(Hr)))
    leglist(i) = sprintf("Length = %d",L);
end

%Add legend to plot
legend(leglist)

%Other optional plot formatting
grid on
xlabel('Freq (Hz)'), ylabel('Decibels')

% filter = lowpass FIR filter
%lengths = 6, 9, 12, 15
%fsample = 44.1kHz
%fcutoff = 8kHz