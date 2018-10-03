
% TODO, make a function

clear all; clc;

% Test data 
load('galax2.mat');
image = ngc3314;
wname = 'rbio6.8';
image_padded = zeros(2.^ceil(log2(size(image))));
image_padded(1:size(image,1),1:size(image,2)) = image;


%Decomposition of image
t = wpdec2(image_padded,3,wname);
plot(t)

% Visit all terminal nodes.
tn_length = size(get(t,'tn'),1) - 1;
for i = 0 :+1:tn_length
    % Get all coefficients of the terminal node 
    cfs = read(t,'cfs',[3,i]);
    
    % Get all coefficients seperately of the terminal node 
    [t1,cA,cD] = wpsplt(t,[3 i]);
    
    % Test Set all values in cfs to zero.
    newCFS = zeros(size(cfs));
    t = write(t,'cfs',[3 i],newCFS);
end


   
    
    