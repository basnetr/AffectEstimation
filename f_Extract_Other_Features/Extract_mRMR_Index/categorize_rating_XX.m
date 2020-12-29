function rating_cat = categorize_rating_XX(rating_array)
	rating_cat = NaN(size(rating_array,1), size(rating_array,2));
	rating_cat(rating_array >= 0.22 & rating_array < 0.26) = 1;
	rating_cat(rating_array >= 0.16 & rating_array < 0.18) = 2;
	rating_cat(rating_array >= 0.12 & rating_array < 0.15) = 3;
	rating_cat(rating_array >= 0.09 & rating_array < 0.11) = 4;
	rating_cat(rating_array >= 0.068 & rating_array < 0.08) = 5;
	rating_cat(rating_array >= 0.04 & rating_array < 0.067) = 6;
	rating_cat(rating_array >= 0.02 & rating_array < 0.035) = 7;
	rating_cat(rating_array >= 0.009 & rating_array < 0.015) = 8;
	rating_cat(rating_array >= -0.08 & rating_array < -0.06) = 9;
	rating_cat(rating_array >= -0.02 & rating_array < -0.008) = 10;
end