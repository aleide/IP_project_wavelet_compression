% 
% 
% 
function [coefficients,compression_factor,percent_zeros,energy_ratio,loss_of_information]...
	=	Compdec(coefficients, bookmat, dpz)

	% Collect initial data
	detail_startindex = prod(bookmat(1,:),2) + 1;
	detail_coefficients = coefficients(detail_startindex:end);
	number_coefficients = length(coefficients);
	number_detail_coefficients = length(detail_coefficients);

	% Find coefficients to be thresholded
	[~, D_sortindex] = sort(abs(detail_coefficients), 'ascend');
	D_reverse_sortindex = ReverseSortIndex(D_sortindex);
	number_of_zeros = min(fix(number_coefficients*dpz/100), number_detail_coefficients);
	thresholded_coefficients_sorted = ...
		logical(horzcat(ones(1, number_of_zeros), zeros(1, number_detail_coefficients - number_of_zeros)));
	thresholded_coefficients = thresholded_coefficients_sorted(D_reverse_sortindex);
	
	% Calculate fancy numbers
	percent_zeros = 100*number_of_zeros/number_coefficients;
	compression_factor = 100/(100 - percent_zeros);
	details_square = detail_coefficients.^2;
	approx_square = coefficients(1:(detail_startindex-1)).^2;
	w = sum([approx_square details_square(~thresholded_coefficients)]);
	W = sum([approx_square details_square]);
	energy_ratio = 100*w/W;
	loss_of_information = 100 - energy_ratio;

	% Collect and write final data
	detail_coefficients(thresholded_coefficients) = 0;
	coefficients(detail_startindex:end) = detail_coefficients;
end