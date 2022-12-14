% EECE 4510 - Marquette University
% Final, Andrew Simon
% Problem 4 - Blandford & Parr 11.19
%
% References:
% prob_11_19.m, Fred J. Frigo, Ph.D.
% Blandford p.660 continuous wavelet transform
%           Use 'morse', 'amor' & 'bump' instead of 'haar' & 'mexh'

% Clear workspace between runs
clear all, clc

%% (1) Setup & plot given signal 
hr = [50 80 100 75 60 125 40 30];
wr = [80 60 80 100 50 50 100 60];
f = hr(1)*ones(1, wr(1));
for i=2:length(hr);
   f = [f hr(i)*ones(1, wr(i))];
end

figure();
plot(f), title("Given signal 'f'");

%% (2) Apply Morse continuous wavelet transforms
fsig = f;
Fs = 1; % Sample Frequency not given, set to 1 Hz
N = max(size(fsig));
duration = N*Fs;
t = linspace(0,duration,N);

wavelet_type = 'morse'; % Morse wavelet transform
[cfs, frq] = cwt(fsig, wavelet_type, Fs);   % Apply CWT to signal
figure();
ax(1) = subplot(3,3,(7:9));
plot(t,fsig)
axis tight
xlabel('Time (sec)')
ylabel('Amplitude');

ax(2) = subplot(3,3,(1:6)); % Wavelet scalogram plot
tmp1 = abs(cfs);
t1 = size(tmp1,2);
tmp1 = tmp1';
minv = min(tmp1);
tmp1 = (tmp1 - minv(ones(1,t1),:));
maxv = max(tmp1);
maxvArray = maxv(ones(1,t1),:);
indx = maxvArray < eps;
tmp1 = 240*(tmp1./maxvArray);
tmp2 = 1+fix(tmp1);
tmp2(indx) = 1;
tmp2 = tmp2';
pcolor(t,frq,tmp2);
shading interp;
ylabel('Frequency');
title(wavelet_type);
colormap(jet);
colorbar;
linkaxes(ax,'x');

%% (3)  Apply Amor continuous wavelet transform
wavelet_type = 'amor'; % Morse wavelet transform
[cfs, frq] = cwt(fsig, wavelet_type, Fs);   % Apply CWT to signal
figure();
ax(1) = subplot(3,3,(7:9));
plot(t,fsig)
axis tight
xlabel('Time (sec)')
ylabel('Amplitude');

ax(2) = subplot(3,3,(1:6)); % Wavelet scalogram plot
tmp1 = abs(cfs);
t1 = size(tmp1,2);
tmp1 = tmp1';
minv = min(tmp1);
tmp1 = (tmp1 - minv(ones(1,t1),:));
maxv = max(tmp1);
maxvArray = maxv(ones(1,t1),:);
indx = maxvArray < eps;
tmp1 = 240*(tmp1./maxvArray);
tmp2 = 1+fix(tmp1);
tmp2(indx) = 1;
tmp2 = tmp2';
pcolor(t,frq,tmp2);
shading interp;
ylabel('Frequency');
title(wavelet_type);
colormap(jet);
colorbar;
linkaxes(ax,'x');

%% (4)  Apply bump continuous wavelet transform
wavelet_type = 'bump'; % Morse wavelet transform
[cfs, frq] = cwt(fsig, wavelet_type, Fs);   % Apply CWT to signal
figure();
ax(1) = subplot(3,3,(7:9));
plot(t,fsig)
axis tight
xlabel('Time (sec)')
ylabel('Amplitude');

ax(2) = subplot(3,3,(1:6)); % Wavelet scalogram plot
tmp1 = abs(cfs);
t1 = size(tmp1,2);
tmp1 = tmp1';
minv = min(tmp1);
tmp1 = (tmp1 - minv(ones(1,t1),:));
maxv = max(tmp1);
maxvArray = maxv(ones(1,t1),:);
indx = maxvArray < eps;
tmp1 = 240*(tmp1./maxvArray);
tmp2 = 1+fix(tmp1);
tmp2(indx) = 1;
tmp2 = tmp2';
pcolor(t,frq,tmp2);
shading interp;
ylabel('Frequency');
title(wavelet_type);
colormap(jet);
colorbar;
linkaxes(ax,'x');