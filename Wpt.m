
% TODO, make a function
clear all; clc;
dwtmode('per');


% Test data 
load('galax2.mat');
image = ngc3314;
wname = 'rbio6.8';
image_padded = zeros(2.^ceil(log2(size(image))));
image_padded(1:size(image,1),1:size(image,2)) = image;


%Decomposition of image
t = wpdec2(image_padded,3,wname);
plot(t)

%128^2 
tn_length = size(get(t,'tn'),1) - 1;
allcfs = [];
for i = 1 :+1:tn_length
    cfs = read(t,'cfs',[3,i]);
    allcfs = vertcat(allcfs,cfs(:));
end

[allcfsSorted, sortind] = sort(allcfs, 'descend');

% Make the changes to allcfsSorted
% example, biggest to 1337
allcfsSorted(1) = 1337;
% Reverse of the sorted list
unsorted = 1:length(allcfs);
newIndex(sortind) = unsorted;
allcfs2 = allcfsSorted(newIndex);


(allcfs2(sortind(1)) == 1337)
% Visit all terminal nodes.
tn_length = size(get(t,'tn'),1) - 1;
for i = 1 :+1:tn_length
    % Get all coefficients of the terminal node 
    cfs = read(t,'cfs',[3,i]);
    
    % Get all coefficients seperately of the terminal node 
    % [t1,cA,cH,cV,cD] = wpsplt(t,[2 i]);
    
    % Test Set all values in cfs to zero.
    newCFS = zeros(size(cfs));
    t = write(t,'cfs',[3 i],newCFS);
end

% Should be a total black image
rec_image = wprec2(t);
figure; imshow(rec_image,[])

    