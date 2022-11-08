% ReconMain.m - MR image reconstruction from Pfile
% Marquette University
% EECE 4510/5510
%
% Fred J. Frigo
% Oct 17, 2017
% Oct 27, 2017 - use Hamming window for apodization
% Oct 15, 2020 - Resize Final Image if necessary
%
% Andrew Simon
% Nov 8, 2022 - variable selection of window appodization use

% Close open figures before running full M file
close all

% Enter name of Pfile
pfile = "";
pfile = 'P20992.7';
if(pfile == "")
    [fname, pname] = uigetfile('*.*', 'Select Pfile');
    pfile = strcat(pname, fname);
end

slice_no = 6;
num_channels = -1;

% Set method to use of processing DICOM image to output 
ver = 0;

%% Importing the P file

%1: Read Pfile containing the raw data for each channel
% if num_channels == -1, it will read all the receiver channels.
% if num_channels == 1, it will prompt you for the specific channel at
%       the matlab console.
[raw_data, alternate] = getChannelData(pfile, slice_no, num_channels);

%% Apodization & Chopping (Mesh plot & K-space)
%2: Perform apodization and chopping

xdim = size(raw_data, 1);

if ver == 0 % --Fermi apodization
    ffilter = fermi(xdim, 0.45*xdim, 0.1*xdim);  % For alt, try fermi( xdim, 0.1*xdim, 0.01*xdim)
elseif ver == 1 % --Hamming apodization
    ffilter = zeros(xdim);
    for k=1:xdim
        %ffilter(k,:)=hamming(1,xdim);
        ffilter(k,:)=hamming(xdim);
    end
elseif ver == 2 % --Gaussian apodization
    ffilter = zeros(xdim);
    for k=1:xdim
        %ffilter(k,:)=hamming(1,xdim);
        ffilter(k,:)=gausswin(xdim);
    end
elseif ver == 3 % --Triangular apodization
    ffilter = zeros(xdim);
    for k=1:xdim
        %ffilter(k,:)=hamming(1,xdim);
        ffilter(k,:)=triang(xdim);
    end
end

figure;
mesh(ffilter);  % this plots the apodization filter
filt_data = filterChannelData(raw_data, ffilter, alternate);

% display the k-space magnitude 
displayMagnitude(raw_data, 'K-space log-magnitude', 1);

%% Magnitude & Phase image plotting

%3: Transform to image domain
im_data = transformChannelData(filt_data);

%4: Display the image magnitude for each channel
displayMagnitude(im_data, 'Image magnitude', 0);

%4.5: Display the image phase for each channel
displayPhase(im_data, 'Image Phase');

%% Weight Sum of Squares
%5: obtain channel weights used in sum of squares combination
weights = read_weights(pfile);

%6: calculate sum_square image
sos_image = sumOfSquares(im_data, weights);

%7: Read corner points & apply gradwarp
% final_image = gradwarp( sos_image, pfile);
%7: Resize image if necessary
zip_factor =1;
final_image = resize_image( sos_image, pfile, zip_factor);

%% DICOM Image Output
%8: Read DICOM image file to obtain DICOM header info 
% Enter name of Pfile
dfile = "";
dfile = 'e31s3i11.dcm';
if(dfile == "")
    [fname, pname] = uigetfile('*.*', 'Select DICOM image File');
    dfile = strcat(pname, fname);
end
   
% Get DICOM info from input image.
info1 = dicominfo(dfile);
exam = info1.StudyID;
series = info1.SeriesNumber;
image_number1 = info1.InstanceNumber;
 
% Create a new DICOM image... starting with header from image1
info = info1;
  
info.WindowWidth  = max(max(final_image));  %default window width for new image
info.WindowCenter = info.WindowWidth/2;  %defautl window level for new image
  
% Multiply original series by 100 and add 0 for new series number
info.StudyID = exam;
info.SeriesNumber= series*100 + 0;
info.InstanceNumber = image_number1;
info.SeriesInstanceUID = dicomuid;  %generate a new DICOM UID for new series

% Create name of NEW DICOM file to create
new_dfile = strcat('e',info.StudyID,'s',int2str(info.SeriesNumber),'i', int2str(info.InstanceNumber),'_',int2str(ver), '.dcm');
  
% Create the new DICOM image  
result = dicomwrite(final_image,new_dfile,info,'CreateMode','copy');

msg=sprintf('New dicom file created = %s', new_dfile);
disp(msg);

