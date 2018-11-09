function [lexicon,totalcount,testlexicon] = read_unigrams(cutoff)

% Default is to replace all single-occurrence tokens with UNK
if (nargin < 1)
  cutoff = 1;
end

% This creates a hash that contains a map from words to counts
lexicon = containers.Map;

% Loop through all the files in the corpus
trainingfiles = dir('train');
for f=1:size(trainingfiles,1)
  % Find files that follow the naming convention
  if (~isempty(regexp(trainingfiles(f).name,'^c\w\d\d','ONCE')))
    % This is the name of the next corpus file to open
    trainingfile = strcat('train/',trainingfiles(f).name);
    % Open the file
    fid = fopen(trainingfile,'r');
    % Read in data from the file
    while (~feof(fid))
      % Read in the next line
      line = fgetl(fid);
      % If there's something on the line
      if ~isempty(line)
        % Split the words, and split off the part of speech
        line = regexprep(line,'/\S+','');
        words = strsplit(line);
        % Remove any empty strings
        words(strcmp('',words)) = [];
        % Loop through all the words in this line
        for i = 1:length(words)
          if isKey(lexicon,words{i})
            % Add one to their counts
            lexicon(words{i}) = lexicon(words{i})+1;
          else
            % The count is one
            lexicon(words{i}) = 1;
          end
        end
      end
    end
    % Close the file
    fclose(fid);
  end
end

% List all the existing lexical items
mykeys = keys(lexicon);

% Create an UNK lexical item
lexicon('UNK') = 0;

% Keep a running count of the total number of word tokens
totalcount = 0;
% Loop through all the existing lexical items
for key = 1:length(mykeys)
  % Add the count
  totalcount = totalcount + lexicon(mykeys{key});
  % Check whether they've been seen fewer than 5 times
  if lexicon(mykeys{key}) < cutoff
    % If so, transfer their counts to UNK
    lexicon('UNK') = lexicon('UNK')+lexicon(mykeys{key});
    % And remove them from the lexicon
    remove(lexicon, mykeys{key});
  end
end


% % This creates a hash that contains a map from words to counts
% testlexicon = containers.Map;
% 
% % Loop through all the files in the corpus
% testfiles = dir('test');
% for f=1:size(testfiles,1)
%   % Find files that follow the naming convention
%   if (~isempty(regexp(testfiles(f).name,'^c\w\d\d','ONCE')))
%     % This is the name of the next corpus file to open
%     testfile = strcat('test/',testfiles(f).name);
%     % Open the file
%     fid = fopen(testfile,'r');
%     % Read in data from the file
%     while (~feof(fid))
%       % Read in the next line
%       line = fgetl(fid);
%       % If there's something on the line
%       if ~isempty(line)
%         % Split the words, and split off the part of speech
%         line = regexprep(line,'/\S+','');
%         words = strsplit(line);
%         % Remove any empty strings
%         words(strcmp('',words)) = [];
%         % Loop through all the words in this line
%         for i = 1:length(words)
%           if isKey(testlexicon,words{i})
%             % Add one to their counts
%             testlexicon(words{i}) = testlexicon(words{i})+1;
%           else
%             % The count is one
%             testlexicon(words{i}) = 1;
%           end
%         end
%       end
%     end
%     % Close the file
%     fclose(fid);
%   end
% end
