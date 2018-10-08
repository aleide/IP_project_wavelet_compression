
function nrms = Nrms(compressed_image,original_image)
i_max = size(compressed_image,1);
j_max = size(compressed_image,2);
mn = i_max * j_max;

sum = 0;
for i = 1:+1:i_max
    for j = 1:+1:j_max
        sum = sum + (compressed_image(i,j) - original_image(i,j))^2;
    end
end

rms = sqrt(sum/mn);

img_max = max(max(compressed_image));
img_min = min(min(compressed_image));
nrms = rms/(img_max - img_min);