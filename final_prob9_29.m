% EECE 4510 - Marquette University
% Final, Andrew Simon
% Problem 1 - Blandford & Parr 9.29
%
% References:
% 1) example9_10 - Example 9.10 Blandford p 534
% 2) saw_test.m, Fred J. Frigo, Ph.D.

% Clear workspace between runs
clear all, clc

%% (1) Sawtooth waveform setup

% Define parameters for saw wave
fb = 440;   % base freq = 440Hz
fs = 22050; % sample freq = 22.05kHz
T = 1/fs;  % period = 1s / fs
pts = 1/T; % Number of points in 1s period

% Find number fourier terms to use that meet band limit below fs/2
terms = fix(( fs/2/fb + 1)/2);

sw = fouriersaw( fs, pts, fb, terms);
sw = sw/max(sw) ; % scale the waveform in range [-1, 1]


% Plot the waveform
t = [0:pts-1]*T;
figure();
plot(t, sw);
xlabel("Time t (s)"), title("Initial Sawtooth waveform")
ylim([-1 1])

figure();   % Closeup view
plot(t, sw);
xlabel("Time t (s)"), title("Initial Sawtooth waveform (zoom in)")
xlim([0 0.01]),ylim([-1 1])

% Play waveform as sound
sound(sw, fs);

%% (2) Setup and apply peak equalizer filter

% Setup parameters
A = 4;   % peak gain = 4
fc = 2200;  % center freq (Hz)
bw = 3080;  % bandwidth (Hz)

% Use equalizer2 to create peaking equalizer
[num2, den2] = equalizer2(fc,A,bw,fs); % Uses default gain at bandwidth (Abw)
% Default Abw = A + (A-1)/sqrt(2)

% Filter the original signal
s2 = filter(num2, den2, sw);

% Plot the waveform
figure();
plot(t, s2);
xlabel("Time t (s)"), title("Filtered Sawtooth waveform")

figure();   % Closeup view
plot(t, s2);
xlabel("Time t (s)"), title("Filtered Sawtooth waveform (zoom in)")
xlim([0 0.01])

% Play signal with peaking equalizer filter
pause; % pause to ensure prior sound is done
sound(s2, fs);

%% (3) Plot signal & filter frequency response

% Calculate FFT of sawtooth waveforms
Fsw = fft(sw);
Fs2 = fft(s2);
FXsw = fftshift(Fsw);
FXs2 = fftshift(Fs2);

% Plot sawtooth freq spectrum
figure();
plot(abs(FXsw));
xlabel("Freq (Hz)"), title("Initial Sawtooth Wave")

figure();
plot(abs(FXs2));
xlabel("Freq (Hz)"), title("Filtered Sawtooth Wave")

% Plot filter freq response
[H f] = freqz(num2,den2,1024,fs);
figure();
plot(f,abs(H));
xlabel("Freq (Hz)"), title("Peaking Equalizer Filter")

% Plot results together
figure(); hold on
plot(abs(FXs2));
plot(abs(FXsw));
ylabel('Sawtooth Magnitude')
yyaxis right
ylabel('Filter Magnitude')
plot(f,abs(H));
legend('Filtered Sawtooth', 'Initial Sawtooth', 'Filter Freq Response')
xlabel("Freq (Hz)"), title("Frequency Comparison")