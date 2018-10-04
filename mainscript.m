close all; clear all; clc;
dwtmode('per');

% Load images
load galax2.mat
clear map_ngc3314 % map_ngc3314 is just gray colormap.

% Parameters
image = ngc3314;
wname = 'rbio6.8';
decomp_level = 5;
dpz = 99.0;

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
[C,S] = wavedec2(correct_image, decomp_level, wname);
[C_comp,compressionfactor,percentzeroes,ER,LE] = Compdec(C, S, dpz);
compressed_image = waverec2(C_comp, S, wname);

% De-pad if necessary
if needs_padding
	compressed_image = compressed_image(1:image_size(1),1:image_size(2));
end

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