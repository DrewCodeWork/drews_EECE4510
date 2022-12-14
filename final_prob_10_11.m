% EECE 4510 - Marquette University
% Final, Andrew Simon
% Problem 2 - Blandford & Parr 10.11
%
% References:
% 1) prob_10_11_example.m, Fred J. Frigo, Ph.D.

% Clear workspace between runs
clear all, clc

% (1) Setup the given vector 
h = [1, 2, 2]; % Given
h = [h 2 1];   % Extended to make result have 0 phase  

% (2) multiply vector by itself to get 2D matrix
h2d = (h')*h;

% (3) Extend it to length 65
N = 65; % desired length
kernel_1d = [ h zeros(1, N-length(h)) ];

% (4) Multiply result by itself to create 65x65 space
kernel_2d = kernel_1d'*kernel_1d;

% (5) plot result of 2D matrix and matrix in 65x65 matrix space
figure;     % Just coefficients of h in 2D
surf(h2d);
title('2D Filter Coefficients');

figure;     % h coefficients in 2D extended to 65x65 
surf(kernel_2d);
title('2D Filter Coefficients (65x65)');

figure;     % Freq response using h
freqz2(h2d, [N, N]);
title('Frequency Response');
