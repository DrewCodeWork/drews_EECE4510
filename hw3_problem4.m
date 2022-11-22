%Andrew Simon
%EECE 4510 - Intro to DSP
%HW 3 - 11/22/2022
%
% Reference for code: Blandford & Parr Ch 8 & Dr. Frederick Frigo
% Edited by Andrew Simon

%Clear workspace between runs
clear all, close all, clc

% (1) Set coefficients of terms in transfer function
numer = [1 2 1];
denom = [1 -0.61589 0.23139];
b0 = numer(1); b1 = numer(2); b2 = numer(3);
a0 = denom(1); a1 = denom(2); a2 = denom(3);

% (2) Setup initial state space of the function
A = [0 1; -a2 -a1];
B = [0; 1];
C = [(b2 - b0*a2) (b1 - b0*a1)];
D = [1];

% (3) Find denominator roots to determine find alpha & beta
r = roots(denom);
alpha = real(r(1));
beta = imag(r(1));

% (4) Setup transform matrix T to use
T = [-1/beta 0; -alpha/beta 1];
At = T^-1 * A * T;
Bt = T^-1 * B;
Ct = C*T;

% (5) Display results
display(At)
display(Bt)
display(Ct)
display(D)
