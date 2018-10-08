function rms = Rms2(img1, img2)
	% Normalise images to range [0 1]
	img1 = img1 - min(min(img1));
	img1 = img1./max(max(img1));
	img2 = img2 - min(min(img2));
	img2 = img2./max(max(img2));
	% Calculate RMS
	rms = sqrt(sum(sum((img1 - img2).^2))/numel(img1));
end

