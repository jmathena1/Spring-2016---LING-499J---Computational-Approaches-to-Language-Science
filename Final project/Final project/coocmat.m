function [counts,wordlist] = coocmat(vocab,w)
% read through data and get co-occurrence matrix

% Input arguments:
% VOCAB is a cell array of words in the vocabulary, of dimensions 1 x [size
%  of vocabulary + UNK] (just like the VOCAB variable in Problem Set 2)
% W is the window size (number of words on the left or right that get
%  counted)

% Output arguments:
% COUNTS is the co-occurrence matrix
% WORDLIST is the map from words to their indices in the co-occurrence matrix 

vocabulary_size = length(vocab);

% This is a hash mapping vocabulary items to indices, for faster indexing
wordlist = containers.Map(vocab,1:vocabulary_size);

counts = sparse([],[],[],vocabulary_size,vocabulary_size,15886328);

%this is the name of the folder holding all the corpus files. you can
%change the name if you want to -- just make sure the correct name is
%specified here
corpus = 'train';

trainingfiles = dir(corpus);

%iterate through files in corpus directory
for f=1:size(trainingfiles,1)
  
  if (~isempty(regexp(trainingfiles(f).name,'^c\w\d\d','ONCE')))
    
    trainingfile = strcat(corpus,'/',trainingfiles(f).name);
    
    file = fopen(trainingfile,'r');
    
    fprintf(1,'Reading in %s\n', trainingfile);
    
    % While we still haven't reached the end of the file
    l = 1;
    while (~feof(file))
      
      % Read in the next line
      line = fgetl(file);
      l = l + 1;
      
      % If there's something on the line
      if ~isempty(line)
        
        % Use a helper function, process_line_of_text (included in
        % Problem Set 2), to do the following:
        % - split the line of text into words
        % - remove part-of-speech tags
        % - remove any empty strings
        % The function returns a cell array of words from that line
        words = process_line_of_text(line);
        
        %convert all words of the line to lowercase
        words = lower(words);
        
        for i = 1:length(words)
            wrd = words{i};
            if isKey(wordlist,wrd)
                ID1 = wordlist(wrd);
            else
                ID1 = wordlist('UNK');
            end
            preceding = words(max(i-w,1):i-1);
            following = words(i+1:min(i+w,length(words)));
            fullcontext = [preceding, following];
            for i=1:length(fullcontext)
                cwrd = fullcontext{i};
                if isKey(wordlist,cwrd)
                    ID2 = wordlist(cwrd);
                else
                    ID2 = wordlist('UNK');
                end
                counts(ID1,ID2) = counts(ID1,ID2) + 1;
            end
        end
        
      end
      
    end
    
    % Close the file
    fclose(file);
    
  end
  
end

end

