Exercise 1. 

Install and test FastQC and the blast toolkit. Retrieve and set-up the ncbi ITS database for Eukaryotes. Write a script to run automatically `FastQC` on `.fastq` files present in a directory, and store the results in a `tab` delimited text file, run `trimmomatic` and clean the reads with the default settings and re-run fastQC on the same files. Prepare a summary table in markdown with the result of FastQC before and after cleaning by trimmomatic. Please explain the percentage of data removed and explain. Remove all reads matching ITS sequencing using the blast toolkit. 

Exercice 2. 

Use the data from exercise 1 to run ipyrad. Install ipyrad and dependencies. create a `params` file for SE sdRAD reads obtained using Pst1. Construct a catalog of loci that are match the following conditions (...). Explain the why the number of recruited loci differs among the parameter values used for depth of coverage and percent similarity. 
