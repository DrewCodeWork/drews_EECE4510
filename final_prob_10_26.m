% EECE 4510 - Marquette University
% Final, Andrew Simon
% Problem 3 - Blandford & Parr 10.26
%
% References:
% prob_10_25.m, Fred J. Frigo, Ph.D.

% Clear workspace between runs
clear all, clc

%% (1) Setup ideal lowpass filter
fs = 2;     % sample freq
fc = .35;   % cutoff freq
N = 65;     % N points in range [0, 1]

[f1, f2] = freqspace(N, 'meshgrid');    % meshgrid in freq space
r = sqrt(f1.^2 + f2.^2);    % Take distance of freq space point from origin

Hd = ones(N);   % Initialize filter freq response 2D matrix
Hd(r>fc) = 0;   % filter out freq values above cutoff (ideal)

%% (2) Plot ideal filter frequency response
figure(1);clf;
subplot(2, 2, 1);
mesh(f1, f2, Hd);
title('Ideal filter');

figure();
mesh(f1, f2, Hd);
title('Ideal filter');

%% (3) Take inverse FFT magnitude of filter and plot result
iHdFFT = ifft2(ifftshift(Hd));
figure(1);
subplot(2, 2, 2);
mesh(f1, f2, abs(fftshift(iHdFFT)));
title('Inverse FFT magnitude');

figure();
mesh(f1, f2, abs(fftshift(iHdFFT)));
title('Inverse FFT magnitude');

%% (4) Create Hanning (von Hann) window filter

% (A) create von Hann window
[t1, t2] = freqspace(N, 'meshgrid');
wHan1 = hann(N);
wHan2 = wHan1*wHan1';

% (B) Plot von Hann window
figure(1);
subplot(2, 2, 3);
mesh(t1, t2, wHan2);
title('Hanning (von Hann) window');

figure();
mesh(t1, t2, wHan2);
title('Hanning (von Hann) window');

%% (5) Apply Hanning window to filter for final filter result
figure(1);
subplot(2, 2, 4);
freqz2(wHan2.*fftshift(iHdFFT));
title('Final filter');

figure();
freqz2(wHan2.*fftshift(iHdFFT));
title('Final filter');