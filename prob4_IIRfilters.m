% Andrew Simon
% EECE 4510 - Intro to DSP

% The following code is an adjusted version based on example 6.4 of
% Blandford & Parr

%Clear workspace between runs
clear all, close all, clc

% (1) Define filter parameters
fs = 44.1 * 1000; fs2 = fs/2;                       %Cutoff freq and Cutoff/2
fpass = 4500; Rp = .01; RpDB = -20*log10(1-Rp);     %Passband & Passband ripple
fstop = 6000; Rs = .03; RsDB = -20*log10(Rs);       %Stopband & Stopband ripple


% (2) Calculate design of digital filters
[N fc] = buttord(fpass/fs2, fstop/fs2, RpDB, RsDB); %Butterworth
[num den] = butter(N, fc);
[H_b f_b] = freqz(num, den, 1024, fs);

[N2 fc2] = cheb1ord(fpass/fs2, fstop/fs2, RpDB, RsDB);  %Chebyshev I
[num2 den2] = cheby1(N2, RpDB, fc2);
[H_cheb1 f_cheb1] = freqz(num2, den2, 1024, fs);

[N3 fc3] = cheb2ord(fpass/fs2, fstop/fs2, RpDB, RsDB);  %Chebyshev II (i.e. Inverse)
[num3 den3] = cheby2(N3, RsDB, fc3);
[H_cheb2 f_cheb2] = freqz(num3, den3, 1024, fs);

[N4 fc4] = ellipord(fpass/fs2, fstop/fs2, RpDB, RsDB);  %Elliptic
[num4 den4] = ellip(N4, RpDB, RsDB, fc4);
[H_el f_el] = freqz(num4, den4, 1024, fs);


% (3) Plot the magnitude of the filters
figure(4), grid on, hold on;                 % Plot of all filter magnitudes
plot(f_b,abs(H_b))
plot(f_cheb1,abs(H_cheb1))
plot(f_cheb2,abs(H_cheb2))
plot(f_el,abs(H_el))
title('Problem 4 (B&P 6.19): IIR Filter Design')
legend('Butterworth','Chebyshev I','Chebyshev II','Elliptic')
xlabel('Freq (Hz)'), ylabel('Magnitude (dB)')

figure(41)              % 'Blowup' view of filter bands
subplot(311), grid on, hold on
title('Passband')
plot(f_b,abs(H_b))
plot(f_cheb1,abs(H_cheb1))
plot(f_cheb2,abs(H_cheb2))
plot(f_el,abs(H_el))
xlim([0 4500]), ylim([0.98 1.01])

subplot(312), grid on, hold on
title('Transition band'), ylabel('Magnitude (dB)')
plot(f_b,abs(H_b))
plot(f_cheb1,abs(H_cheb1))
plot(f_cheb2,abs(H_cheb2))
plot(f_el,abs(H_el))
xlim([4500 6000]), ylim([0 1.01])

subplot(313), grid on, hold on
title('Stopband'), xlabel('Freq (Hz)')
plot(f_b,abs(H_b))
plot(f_cheb1,abs(H_cheb1))
plot(f_cheb2,abs(H_cheb2))
plot(f_el,abs(H_el))
xlim([6000 2.3*10^4]), ylim([0 0.04])
legend('Butterworth','Chebyshev I','Chebyshev II','Elliptic')


% (4) Print minimum order of each filter
disp(sprintf("Min. Order of Butterworth: %d",N))
disp(sprintf("Min. Order of Chebyshev I: %d",N2))
disp(sprintf("Min. Order of Chebyshev II: %d",N3))
disp(sprintf("Min. Order of Elliptic: %d",N4))