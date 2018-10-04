function reverse_sorting_index = ReverseSortIndex(sorting_index)
	index_length = length(sorting_index);
	reverse_sorting_index = zeros(1,index_length);
	for i = 1:index_length
		reverse_sorting_index(sorting_index(i)) = i;
	end
end