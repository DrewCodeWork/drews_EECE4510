%Andrew Simon
%EECE 4510 - Intro to DSP
%HW 3 - 11/22/2022
%
% Reference for code: Blandford & Parr Ch 8 & Dr. Frederick Frigo
% Edited by Andrew Simon

%Clear workspace between runs
clear all, close all, clc

%% (1) Setup given parameters
fs = 8000; fs2 = fs/2;         %Sampling freq and Cutoff/2
fpass = 1000; Rp = 0.03;       %Passband & Passband ripple
fstop = 2000; Rs = 0.03;       %Stopband & Stopband ripple
Fcutoff = ([fpass fstop]);
M = ([1 0]);
dev = [Rp Rs];

%% (2) Calculate order & coefficients of 
[n,fo,ao,w] = firpmord(Fcutoff,M,dev,fs);
H = firpm(n,fo,ao,w);

%% (3) Print out resulting order and coefficients

fprintf("n = %d\r\n",n)   % Print order of filter
for i = 0:length(H)-1   % Print coefficients
    disp(sprintf("b%d = %.6f",i,H(i+1)))
end
