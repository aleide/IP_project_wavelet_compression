% Returns a version of a wavelet decomposed 2D signal with detail coefficient
% values set to zero if within a given threshold. Threshold is determined
% based on argument stating desired percent of zeroes.
function [decvec,cf,pz,er,le] = Compdec(decvec, bookmat, dpz)
	% Determine suitable tolerance based on desired percent zeros (dpz)
	p = dpz;
	tolerance = 0.1;
	while (p - fix(p))~=0
		p = p * 10;
		tolerance = tolerance/10;
	end
	Dstartind = prod(bookmat(1,:),2) + 1; % Starting point of detail coefficients in C
	D = decvec(Dstartind:end);

	absD = abs(D);
	T_low = 0;
	T_high = max(absD);
	while true
		T = (T_high + T_low)/2;
		thresholded = absD < T;
		pz = 100*sum(thresholded)/length(decvec); % Percent of zeros in details only, i.e. not including approx.
		delta = pz - dpz;
		if delta > 0
			T_high = T;
		else
			T_low = T;
		end

		if abs(delta) < tolerance, break; end
    end
	
	cf = 100/(100 - pz);
    Dsquare = D.^2;
    w = sum(Dsquare(~thresholded));
    W = sum(Dsquare);
    er = 100*w/W;
    le = 100 - er;
    
	D(thresholded) = 0;
	decvec(Dstartind:end) = D;
end

% FINAL NOTE %
% No elements of the approximation matrix are zeroes. Is this correct?