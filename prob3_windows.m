% Andrew Simon
% EECE 4510 - Intro to DSP

% Midterm Problem 3:
% Sketch the impulse response functions of rectangular, triangluar,
% Hamming, von Hann, and Blackman window functions for length 30.

% (1) Calculate impulse response of windows
len = 30;               %Set length to use

rect = rectwin(len);    %Use window functions for impulse response
tri = triang(len);      
ham = hamming(len);
vhan = hann(len);
bman = blackman(len);

% (2) Plot the impulse response of each window together
figure(), hold on
plot(rect)
plot(tri)
plot(ham)
plot(vhan)
plot(bman)
legend('Rectangular', 'Triangular', 'Hamming', 'von Hann', 'Blackman')

%Apply formatting to plot
grid on, ylabel('Magnitude')
