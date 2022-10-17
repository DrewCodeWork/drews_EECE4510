% Andrew Simon
% EECE 4510 - Intro to DSP

% The following code is an adjusted version based on examples 6.4 & 6.12 of
% Blandford & Parr

%Clear workspace between runs
clear all, close all, clc

% (1) Define filter parameters
fs = 1000; fs2 = fs/2;                              %Cutoff freq and Cutoff/2
fpass = 150; Rp = .03; RpDB = -20*log10(1-Rp);      %Passband & Passband ripple
fstop = 200; Rs = .03; RsDB = -20*log10(Rs);  %Stopband & Stopband ripple

% (2) Calculate FIR filter using given Parks-McClellan method
F = ([0 0.3 0.4 1]);
M = ([1 1 0 0]);
N = 28;
num = firpm(N, F, M);
den = 1;

[H_fpm f_fpm] = freqz(num, den, 1024, fs);     %Calculate filter response

% (3) Calculate elliptic filter design
[N2 fc2] = ellipord(fpass/fs2, fstop/fs2, RpDB, RsDB);  %Elliptic
[num2 den2] = ellip(N2, RpDB, RsDB, fc2);
[H_el f_el] = freqz(num2, den2, 1024, fs);


% (3) Plot filter responses
figure(50)                              % Plot of all filter responses
subplot(211), grid on, hold on
plot(f_fpm,abs(H_fpm))                  % Magnitude
plot(f_el,abs(H_el))
title('Problem 5 (B&P 6.21): FIR vs IIR Design Filter Responses')
legend('FIR (Parks-McClellan)','Elliptic')
ylabel('Magnitude (dB)')

subplot(212), grid on, hold on
plot(f_fpm,unwrap(angle(H_fpm))*180/pi) % Phase
plot(f_el,unwrap(angle(H_el))*180/pi)
xlabel('Freq (Hz)'), ylabel('Phase (degrees)')


% (4) Plot 'exploded' view of magnitude of filter bands
figure(51)
subplot(311), grid on, hold on
title('Passband')
plot(f_fpm,abs(H_fpm))
plot(f_el,abs(H_el))
xlim([0 fpass]), ylim([0.96 1.05])

subplot(312), grid on, hold on
title('Transition band'), ylabel('Magnitude (dB)')
plot(f_fpm,abs(H_fpm))
plot(f_el,abs(H_el))
xlim([fpass fstop]), ylim([0 1.05])
legend('FIR (Parks-McClellan)','Elliptic')

subplot(313), grid on, hold on
title('Stopband'), xlabel('Freq (Hz)')
plot(f_fpm,abs(H_fpm))
plot(f_el,abs(H_el))
xlim([fstop 500]), ylim([0 0.04])

% (5) Plot 'exploded' view of phase of filter bands
figure(52)
subplot(311), grid on, hold on
title('Passband')
plot(f_fpm,unwrap(angle(H_fpm))*180/pi)
plot(f_el,unwrap(angle(H_el))*180/pi)
xlim([0 fpass]), ylim([-800 25])

subplot(312), grid on, hold on
title('Transition band'), ylabel('Phase (degrees)')
plot(f_fpm,unwrap(angle(H_fpm))*180/pi)
plot(f_el,unwrap(angle(H_el))*180/pi)
xlim([fpass fstop]), ylim([-1020 -170])
legend('FIR (Parks-McClellan)','Elliptic')

subplot(313), grid on, hold on
title('Stopband'), xlabel('Freq (Hz)')
plot(f_fpm,unwrap(angle(H_fpm))*180/pi)
plot(f_el,unwrap(angle(H_el))*180/pi)
xlim([fstop 500]), ylim([-1030 30])

% (6) Print minimum order of each filter
disp(sprintf("Min. Order of FIR: %d",N))
disp(sprintf("Min. Order of Elliptic: %d",N2))