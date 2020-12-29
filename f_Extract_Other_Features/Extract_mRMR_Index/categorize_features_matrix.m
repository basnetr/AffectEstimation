function features_matrix_cat = categorize_features_matrix(features_matrix)

%	features_matrix_cat = categorize_features_matrix(features_matrix)
%
%	OVERVIEW
%		Categorizes feature values to integer levels by z-scoring
%       and shifting to a positive range instead of centered at 0.
%       Used prior to mRMR feature selection.
%
%	INPUT
%		features_matrix
%
%	OUTPUT
%		features_matrix_cat - categorized
%
%	AUTHORS
%       Erik Reinertsen <erikrtn@gmail.com>
%
%	REPO
%       https://github.com/cliffordlab/mrmr
%
%   DEPENDENCIES
%		None.
%	
%	COPYRIGHT (C) 2016 AUTHORS (see above)
%       This code (and all others in this repository) are under the GNU General Public License v3
%       See LICENSE in this repo for details.

features_matrix_cat = NaN(size(features_matrix,1), size(features_matrix,2));
features_matrix = zscore(features_matrix);

features_matrix_cat(features_matrix < -2) = 1;

features_matrix_cat(features_matrix >= -2 & features_matrix < -1.75) = 2;
features_matrix_cat(features_matrix >= -1.75 & features_matrix < -1.5) = 3;

features_matrix_cat(features_matrix >= -1.5 & features_matrix < -1.25) = 4;
features_matrix_cat(features_matrix >= -1.25 & features_matrix < -1.0) = 5;

features_matrix_cat(features_matrix >= -1.0 & features_matrix < -0.75) = 6;
features_matrix_cat(features_matrix >= -0.75 & features_matrix < -0.5) = 7;

features_matrix_cat(features_matrix >= -0.5 & features_matrix < -0.25) = 8;
features_matrix_cat(features_matrix >= -0.25 & features_matrix < 0) = 9;

features_matrix_cat(features_matrix >= 0.0 & features_matrix < 0.25) = 10;
features_matrix_cat(features_matrix >= 0.25 & features_matrix < 0.5) = 11;

features_matrix_cat(features_matrix >= 0.5 & features_matrix < 0.75) = 12;
features_matrix_cat(features_matrix >= 0.75 & features_matrix < 1.0) = 13;

features_matrix_cat(features_matrix >= 1.0 & features_matrix < 1.25) = 14;
features_matrix_cat(features_matrix >= 1.25 & features_matrix < 1.5) = 15;

features_matrix_cat(features_matrix >= 1.5 & features_matrix < 1.75) = 16;
features_matrix_cat(features_matrix >= 1.75 & features_matrix < 2.0) = 17;

features_matrix_cat(features_matrix >= 2.0) = 18;

end