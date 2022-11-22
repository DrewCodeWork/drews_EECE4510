% EECE 4510 HW #3
% F. Frigo  10-Nov-2021
% Marquette University
%
% See: PWMChirp.m
%      Blandford & Parr, Introduction to Digital Signal Processing
%      example 9.1 p 488
% 
% Edits:
% A. Simon 22-Nov-2021
% Marquette University

%Clear workspace between runs
clear all, close all, clc

fs = 1000; T = 1/fs;
N = 1000;
% Problem 9.1:
fsig = 100;
t = 0:T:((3*N*T)-T);
y = 0.5*(sawtooth(2*pi*fsig*t, 0.5)-1);

N1 = max (size(y)); 
figure(1); clf;
plot(t, y,'LineWidth',3);  % plot input signal

% Create the PWM signal in an matrix which has N2 rows x N columns
%    where each column represents one sample of the signal.
% Here each column has v ones and N2-v zeros where v is the
%    value of the signal at the sample
b = 7; N2 = 2^b; %bits of resolution
PWMOut = zeros(N2, N1);
for i=1:size(PWMOut,2)
   v = abs(fix(y(i)*N2));
   s = [ones(1, v) zeros(1, N2 - v)];
   PWMOut(:, i) = s';
end

% Change PWMOut which is N2 x N to a column matrix that is (N2*N) x 1.
PWMPlot = -PWMOut(:);  % Problem 9.1
hold on;

%PWMPlot has N2 times as many samples as t.
Ts = T/N2;
t1=0:Ts:(N1*T)-Ts;
plot(t1, PWMPlot);

%This is an early segment of the signal
axis([0 0.1 -1.1 0.1]); % Problem 9.1
title ('PWM encoded signal');
xlabel('time in seconds');
ylabel('signal amplitude');
