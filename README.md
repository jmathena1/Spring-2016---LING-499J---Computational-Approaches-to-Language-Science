# Spring-2016---LING-499J---Computational-Approaches-to-Language-Science
Final Project in LING 499J at the University of Maryland in Spring 2016 -- All Coding done in Matlab by myself with lots of help from 
Dr. Naomi Feldman (UMD) and Dr. Allyson Ettinger (UChicago).

Summary: In this project, I made a change to a model that used Vectors to represent word meaning by using a corpus of words 
and calculating how often each word appeared within a pre-determined distance of another word.  The original model did not use parts of 
speech (POS) in generating the co-occurrence counts, which I believe to be a shortcoming of said model. The new model retains the POS tags 
in the corpus so that it can better capture words that have different parts of speech and/or meanings while their written form remains the 
same.  I evaluated the old model without POS tags to the new model with POS tags by comparing the similarity judgements each model produced
to actual human similarity judgements in order to determine which model produces judgments that are closer to humans.

Installation:
  1. Download the entire contents of the "Final Project" folder found on the homepage of the repository.
  2. Ensure that all contents are in the same local folder.
  3. Open MATLAB.
  4. Set the working directory to the local folder containing the "Final Project" files.
  5. Ensure that the "train" folder is located in the local set as the working directory.
  6. Run "cooc.mat". This function takes a vocab and a number (window size) as its input and outputs a co-occurrence matrix for all the 
     words in vocab as well as a map indexing every vocab word in the corpus.
  7. Run "process_matrix.mat". This function converts the co-occurrence counts to positive pointwise mutual information over a set number of 
     columns, which are determined by which of the columns in the raw matrix have the highest variance
  8. Run "cossim.mat". This function takes two vectors from a reduced matrix and outputs the cosine of the angle between them.
  9. Run "evalsim.mat". This function takes one of the reduced vectors, the wordlist output by coocmat_mat, and a human similarity dataset 
     as inputs and outputs a spearman rank correlation coefficient between the model’s similarity judgments and human dataset.  The 
     function calls cossim.m to calculate the model’s similarity judgement before comparing them to the human judgements.
Credits:
  Dr. Allyson Ettinger
  Dr. Naomi Feldman

License:

GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007

Copyright (C) 2007 Free Software Foundation, Inc. https://fsf.org/ Everyone is permitted to copy and distribute verbatim copies of this 
license document, but changing it is not allowed.
