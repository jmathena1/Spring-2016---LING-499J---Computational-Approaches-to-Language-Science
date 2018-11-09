function [rho] = evaluate_sim(vectors,wordlist,simset)
% This function takes a matrix of word vector representations, a mapping 
% from words to row indices in the matrix, and a similarity ratings dataset, 
% and returns the Spearman rank correlation coefficient between the model's
% similarities and the human similarity ratings.
%
% Input arguments:
% VECTORS is a matrix of word vector representations
% WORDLIST is the mapping from words to (row) indices in the matrix
% SIMSET is a human similarity rating dataset to be evaluated against
% 
% Output arguments:
% RHO is the Spearman rank correlation coefficient between the model's
%   similarity values and the human similarity ratings

% load word pairs and human similarity ratings from similarity dataset
word_pairs = simset(:,1:2);
ratings = cell2mat(simset(:,3));

% initialize vectors that will store model similarity values and human ratings
sims = [];
rats = [];

%iterate through all word pairs
for i = 1:length(ratings)
    skip = 0;
    %get the two words in the pair
    w1 = word_pairs{i,1};
    w1 = regexprep(w1,'/\S+','');
    w2 = word_pairs{i,2};
    w2 = regexprep(w2,'/\S+','');
    
    %if either of the words is not in the vocabulary, skip this pair
    try 
        ind1 = wordlist(w1);
        ind2 = wordlist(w2);
    catch
        skip = 1;
    end
    if skip
        continue
    end
    
    %otherwise, add human rating to RATS
    r = ratings(i);
    rats = [rats r];
    
    %get vectors from the vector matrix
    v1 = vectors(ind1,:);
    v2 = vectors(ind2,:);
    
    %compute cosine and store in SIMS
    s = full(cossim(v1,v2));
    sims = [sims s];
    
end

%compute Spearman rank correlation coefficient between model similarity values
%and human similarity ratings
rho = corr(sims',rats','type','Spearman');
end