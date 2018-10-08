close all; clear all; clc;
dwtmode('per');

% Load images
load galax2.mat %ngc3314
clear map_ngc3314 % map_ngc3314 is just gray colormap.
duststorm = double(imread('Dust_storm_in_Amarillo,_Texas.gif'));
footprint = double(imread('610px-Footprint.gif'));
footprint512 = double(imread('Footprint512.tiff'));
duststorm512 = double(imread('Dust512.tiff'));
cameraman = double(imread('standard_test_images/cameraman.tif'));
house = imread('standard_test_images/house.tif'); house = double(house(:,:,1));
jetplane = imread('standard_test_images/jetplane.tif'); jetplane = double(jetplane(:,:,1));
lake = imread('standard_test_images/lake.tif'); lake = double(lake(:,:,1));
lena_gray_512 = double(imread('standard_test_images/lena_gray_512.tif'));
livingroom = double(imread('standard_test_images/livingroom.tif'));
mandril_gray = double(imread('standard_test_images/mandril_gray.tif'));
peppers_gray = imread('standard_test_images/peppers_gray.tif'); peppers_gray = double(peppers_gray(:,:,1));
pirate = double(imread('standard_test_images/pirate.tif'));
walkbridge = imread('standard_test_images/walkbridge.tif'); walkbridge = double(walkbridge(:,:,1));
woman_blonde = double(imread('standard_test_images/woman_blonde.tif'));
woman_darkhair = double(imread('standard_test_images/woman_darkhair.tif'));

% Parameters

image = woman_darkhair;
wname = 'rbio6.8';
decomp_level = 3;
dcpf = 20;
dpz = 100*(1 - 1/dcpf);
useWavelet = 1; % 0 = wavelet packet

% Get information about image
image_size = size(image);
needs_padding = ~all((log2(image_size) - fix(log2(image_size))) == 0);

% Handle padding if necessary
if needs_padding
	image_padded = zeros(2.^ceil(log2(image_size)));
	image_padded(1:image_size(1),1:image_size(2)) = image;
	correct_image = image_padded;
else
	correct_image = image;
end

% Do the wavelet
if useWavelet
	[C,S] = wavedec2(correct_image, decomp_level, wname);
	[C_comp,compressionfactor,percentzeroes,ER,LE] = Compdec(C, S, dpz);
	compressed_image = waverec2(C_comp, S, wname);
else
	T = wpdec2(correct_image,decomp_level,wname);
	[T_comp,compressionfactor,percentzeroes,ER,LE] = Compdwp(T, dpz);
	compressed_image = wprec2(T_comp);
end

% De-pad if necessary
if needs_padding
	compressed_image = compressed_image(1:image_size(1),1:image_size(2));
end

RMS = Rms(compressed_image,image);

% Display images
figure; imshow(image,[]);
figure; imshow(compressed_image,[]);

% Present numbers
disp("Compression factor")
disp(compressionfactor)
disp("Percentage of zeroes")
disp(percentzeroes)
disp("Energy Ratio")
disp(ER)
disp("Loss of information")
disp(LE)
disp("Root square mean error")
disp(RMS)
