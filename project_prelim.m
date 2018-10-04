close all; clear all; clc;
dwtmode('per');
load galax2.mat

% Parameters
image = ngc3314;
wname = 'rbio6.8';
dpz = 99.0;

clear map_ngc3314 % map_ngc3314 is just gray colormap.

% ngc3314 pixel range [2 64]
figure; imshow(image,[]);

image_padded = zeros(2.^ceil(log2(size(image))));
image_padded(1:size(image,1),1:size(image,2)) = image;

maxlev_image = wmaxlev(size(image_padded), wname); % soft rule?

[C,S] = wavedec2(image_padded, maxlev_image, wname);

tic;
[C_comp,compressionfactor,percentzeroes,ER,LE] = Compdec(C, S, dpz);
toc;

% Present numbers
disp("Compression factor")
disp(compressionfactor)
disp("Percentage of zeroes")
disp(percentzeroes)
disp("Energy Ratio")
disp(ER)
disp("Loss of information")
disp(LE)

ngc3314_comp = round(waverec2(C_comp, S, wname));
ngc3314_comp = ngc3314_comp(1:size(ngc3314,1),1:size(ngc3314,2));
figure; imshow(ngc3314_comp,[]);