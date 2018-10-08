function rms = Rms2(image1, image2)
	rms = sqrt(sum(sum((image1 - image2).^2))/numel(image1));
end

