% EECE 4510 HW #3
% F. Frigo  Nov-2019
% Marquette University
%
% See: PWMChirp.m
%      Blandford & Parr, Introduction to Digital Signal Processing
%      Example 9.10 p 534
% 
% Edits:
% A. Simon 22-Nov-2021
% Marquette University

%Clear workspace between runs
clear all, close all, clc

% (1) Given waveform setup
fs = 8 * 1000;T = 1/fs; % Sample freq & period
t = (0:3*fs)*T;         % 3 sec period
u = 0.49*(chirp(t,10,3,1000)+1);

% audiowrite() used due to deprecation of wavwrite
sound(u,fs); % play sound
audiowrite('ChirpSound.wav',u,fs);  % *.wav format

pause(3);   % Add delay so initial waveform sound finishes

% (2) Take original chirp data and apply delay filter settings
k = 1;
delay_list = [0.08 0.01 0.001];

for i = 1:length(delay_list)
    dtime = delay_list(i);  %delay time in seconds
    
    delay = fix(fs*dtime);
    disp('Filter delay taps =');
    disp(delay);
    num = zeros(1, delay);
    num(1) = 1;
    num(delay) = k; 
    den = zeros(1, delay);
    den(1) = 1;
    [H f] = freqz(num, den, 8192, fs);
    
    figure(i);clf;
    subplot(2, 1, 1);
    plot(f, abs(H)/max(abs(H)));
    axis([0 fs/2 0 1.2]);
    xlabel('frequency in Hz');
    ylabel('gain');
    title(['Frequency response: delay = '...
    num2str(dtime) 'seconds']);
    subplot(2, 1, 2);
    zplane(num, den);
    y = filter(num, den, u);
    sound(y, fs);  % Play the new sound

    pause(3);   % Add pause to prevent audio play overlap
end