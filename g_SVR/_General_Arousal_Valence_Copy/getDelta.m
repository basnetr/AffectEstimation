function D = getDelta(C)
	N = length(C);
	for i = 1:N
		index1 = i + 1; index2 = i - 1; index3 = i + 2; index4 = i - 2;
		if index1 < 1
			index1 = 1;
		end
		if index2 < 1
			index2 = 1;
		end
		if index3 < 1
			index3 = 1;
		end
		if index4 < 1
			index4 = 1;
		end
		if index1 > N
			index1 = N;
		end
		if index2 > N
			index2 = N;
		end
		if index3 > N
			index3 = N;
		end
		if index4 > N
			index4 = N;
		end
		D(i) = ((C(index1) - C(index2)) + 2*(C(index3) - C(index4)))/10;
	end
end