% EECE 4510 - Marquette University
% Final, Andrew Simon
%
% Original Code:
% mri_edge.m -  read MR DICOM image and apply edge filter
% Fred J. Frigo, Ph.D.
% Marquette University
% 18-Nov-2022
%
% Edited: 12/14/22 - Andrew Simon

% Read DICOM image file 
dfile = "";
dfile = 'e31s360i11.dcm';
if(dfile == "")
    [fname, pname] = uigetfile('*.*', 'Select DICOM image File');
    dfile = strcat(pname, fname);
end

% Get DICOM info from input image.
info = dicominfo(dfile);
exam = info.StudyID;
series = info.SeriesNumber;
patient_name = info.PatientName;
display( patient_name);

MR_img = dicomread(info);
figure();
%image(MR_img);
max_pixel = max(max(MR_img));
imshow(MR_img, [0 max_pixel] );
gray = im2double(MR_img); % Normalize image for 'sobel'

% Loop to apply 2D Sobel and plot comparisons of threshold
figure();
for i = 1:6
    % 2D Sobel Filter
    sobel_threshold = (0.01 * i);      % use threshold values from 0.01 to 1.0
    edgeIm = sobel(gray, sobel_threshold);  

    subplot(2,3,i);
    im3 = repmat(edgeIm, [1 1 3]);
    image(im3);
    sobel_str = sprintf('Sobel filter (threshold = %.3f)',sobel_threshold);
    title(sobel_str);
end 

% Use Matlab edge filter with Sobel option
edgeIm2 = edge(MR_img, "Sobel");
figure();
im4 = repmat(edgeIm2, [1 1 3]);
image(im4);
title('MATLAB edge function with Sobel');
