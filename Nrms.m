
function nrms = Nrms(compressed_image,original_image)
i_max = size(compressed_image,1);
j_max = size(compressed_image,2);
mn = i_max * j_max;

compressed_image = compressed_image - min(min(compressed_image));
compressed_image = compressed_image./max(max(compressed_image));
original_image = original_image - min(min(original_image));
original_image = original_image./max(max(original_image));

sum = 0;
for i = 1:+1:i_max
    for j = 1:+1:j_max
        sum = sum + (compressed_image(i,j) - original_image(i,j))^2;
    end
end

nrms = sqrt(sum/mn);
