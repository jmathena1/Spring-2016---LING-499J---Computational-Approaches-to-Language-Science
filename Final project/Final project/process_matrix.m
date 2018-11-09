function [raw_new,reduced] = process_matrix(raw,k)
% This function takes a matrix of raw co-occurrence counts, converts the
% raw counts to PPMI, and reduces the matrix to the k columns with the highest 
% variance. 
%
% Input arguments:
% RAW is a matrix of raw co-occurrence counts
% K is the desired number of columns for the reduced-dimension matrix
% 
% Output arguments:
% RAW_NEW is the matrix produced by converting raw counts to PPMI
% REDUCED is the matrix produced by calculating the variance in the columns of the
%   PPMI-converted matrix and retaining only the k columns with highest variance


%pre-compute values needed for PMI probabilities

%total number of co-occurrrences in the matrix (denominator value for all
%probabilities)
tot_pairs = sum(sum(raw));

%get vector of marginal word probabilities (probability of each word
%across all contexts: p(w,*))
rows = sum(raw,2)'/tot_pairs;

%get vector of marginal context probabilities (probability of each
%context across all words: p(*,c) )
cols = sum(raw,1)/tot_pairs;

% get indices (vectors i,j) and values (vector v) of non-zero co-occurrence 
% cells (dividing all raw counts by total number of pairs, so values in v are 
% joint probabilities: p(w,c))
[i,j,v] = find(raw/tot_pairs);

%initialize sparse matrix that will store the converted values
raw_new = sparse([],[],[],size(raw,1),size(raw,2),15886328);
raw = [];

%iterate through all non-zero cells in co-occurrence matrix
for ind = 1:length(v)
    if rem(ind,10000) == 0
        fprintf('Iteration %d\n',ind)
    end
    %get joint probability for this cell: p(w,c)
    pxy = v(ind);
    %get marginal probability of word w: p(w,*)
    px = rows(i(ind));
    %get marginal probability of context c: p(*,c)
    py = cols(j(ind));
    
    %Question 2b
    pmi = log2(pxy/(px*py));
    
    %convert any negative values to zero
    if pmi < 0
        pmi = 0;
    end
    %save PPMI value to correct cell in new matrix
    raw_new(i(ind),j(ind)) = pmi;
end
%apply variance-based dimensionality reduction
%get variance of each column and sort from high to low, returning indices
%in sorted order
vars = [];
for i = 1:length(raw_new(1,:))
    colvar = var(raw_new(:,i));
    vars = [vars colvar];
end
[~,inds] = sort(vars,'descend');
% 
%save top k columns with highest variance to matrix REDUCED
reduced = raw_new(:,inds(1:k));

end