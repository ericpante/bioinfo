# REDO EXAM - BIOINFORMATICS

You must create a GitHub account and invite `ericpante` to it. Please prepare a main file in MarkDown to explain your answers and provide your code. 
Please add your scripts as separate files in the GitHub repository. All code must be able to run on ubuntu linux, as set up in the informatics labs at IUEM. The raw data consist in the first three files from the SRA project n. SRP021469. 

## Useful links
- NCBI tools and databases are here: https://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&PAGE_TYPE=BlastDocs&DOC_TYPE=Download 
- Trimmomatic is here: http://www.usadellab.org/cms/?page=trimmomatic
- FastQC is here: http://www.usadellab.org/cms/?page=trimmomatic

## Exercise 1. 

Install and test FastQC and the blast toolkit. Retrieve and set-up the ncbi ITS database for Eukaryotes (). Write a script to run automatically `FastQC` on `.fastq` files present in a directory, and store the results in a `tab` delimited text file, run `trimmomatic` and clean the reads with the settings provided in the exemple command line for SE reads; re-run fastQC on the same files. Prepare a summary table in markdown with the result of FastQC before and after cleaning by trimmomatic. Please explain the percentage of data removed and explain. Remove all reads matching ITS sequencing using the blast toolkit. 

## Exercice 2. 

Use the data from exercise 1 to run ipyrad. Install ipyrad and dependencies. create a `params` file for SE sdRAD reads obtained using Pst1. Construct a catalog of loci that are match the following conditions (...). Explain the why the number of recruited loci differs among the parameter values used for depth of coverage and percent similarity.
