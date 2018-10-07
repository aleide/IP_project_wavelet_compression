
function rms = Rms(compressed_image,original_image)
i_max = size(compressed_image,1);
j_max = size(compressed_image,2);

sum = 0;
for i = 1:+1:i_max
    for j = 1:+1:j_max
        sum = sum + (compressed_image(i,j) - original_image(i,j))^2;
    end
end

mn = i_max * j_max;
rms = ((1/mn) * sum)^(1/2);