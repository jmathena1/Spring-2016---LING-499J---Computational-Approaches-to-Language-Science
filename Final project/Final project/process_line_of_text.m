function words = process_line_of_text(line)

% WORDS = PROCESS_LINE_OF_TEXT (LINE)
% 
% This is a helper function that splits a line of text into words, deletes
% its associated part-of-speech tags, and removes any empty strings before 
% returning the list of words as a cell array.  You can call it from any
% function or script that needs to process a text file.
% 
% Input arguments:
% LINE is a line of text that has been read in from a file using fgetl
% 
% Output arguments:
% WORDS is a cell array, where each cell contains a word from the line of text


% Delete all the part-of-speech labels
%line = regexprep(line,'/\S+','');

% Split the words at the white space
words = strsplit(line);

% Remove any empty strings
words(strcmp('',words)) = [];
