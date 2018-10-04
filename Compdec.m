% Returns a version of a wavelet decomposed 2D signal with detail coefficient
% values set to zero if within a given threshold. Threshold is determined
% based on argument stating desired percent of zeroes.
function [decvec,cf,pz,er,le] = Compdec2(decvec, bookmat, dpz)
	% Determine suitable tolerance based on desired percent zeros (dpz)
	detail_startindex = prod(bookmat(1,:),2) + 1; % Starting point of detail coefficients in C
	D = decvec(detail_startindex:end);
	number_coefficients = length(decvec);

	[~, D_sortindex] = sort(abs(D), 'ascend');
	D_reverse_sortindex = ReverseSortIndex(D_sortindex);
	number_of_zeros = fix(number_coefficients*dpz/100);
	thresholded_coefficients_sorted = ...
		logical(horzcat(ones(1, number_of_zeros), zeros(1, number_coefficients - number_of_zeros)));
	thresholded_coefficients = thresholded_coefficients_sorted(D_reverse_sortindex);
	
	pz = 100*number_of_zeros/number_coefficients;
	cf = 100/(100 - pz);
	Dsquare = D.^2;
	w = sum(Dsquare(~thresholded_coefficients));
	W = sum(Dsquare);
	er = 100*w/W;
	le = 100 - er;

	D(thresholded_coefficients) = 0;
	decvec(detail_startindex:end) = D;
end

% FINAL NOTE %
% No elements of the approximation matrix are zeroes. Is this correct?