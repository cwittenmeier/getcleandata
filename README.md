# README
I assume that you have the original datasets available, so i just provide the parts, 
that are part of the solution of the exercise. I quickly describe here the parts of 
the solution and how they are connected to each other:

* **CodeBook.md** This document describes how the two resulting dataframes "mergedataframe.txt" 
and "finalmeanframe.txt" are structured and how they can be derived from the original datasets 
provided by the instructors. This document can be read relative independently from the code 
and its comments in run_analysis.R. Please note that the Codebook describes the structure of 
both dataframes mergeddataframe.txt and finalmeandataframe.txt. You have to read both 
descriptions to understand the structure of the later one. 

* **run_analysis.R** consists of three sections:
	* **Section 1** consists of the method **execute()**. It contains all main steps, that has been 
	executed to build the two resulting datasets **mergedataframe.txt** and **finalmeanframe.txt**.
    This method calls other helper-methods of **Section 2** and optionally some test-methods of **Section 3**. 
    To understand, how the R-Script run_analysis.R works, just take a look at the code and its comments. 
    (This description is not contained in this README.md, but in the extensive code-comments.)      
    * **Section 2** consists of many helper-methods that do the work of combining and rearranging the initial datasets.
    If you want to know, how the steps in Section 1 are realized in detail, this is the right place to look at.
    * **Section 3 ** is not part of the solution. It contains just some test-methods, that can be called from the 
	**execute()**-Method of Section 1 for verifying the results. (Some takes a long time to be executed.)    
* **mergedataframe.txt** is the resulting dataframe of the parts 1-4 of the exercise.
* **finalmeanframe.txt** is the resulting dataframe of the parts 5 of the exercise.


