# REDO EXAM - BIOINFORMATICS

You must create a GitHub account and invite `ericpante` to it. Please prepare a main file in MarkDown to explain your answers and provide your code. 
Please add your scripts as separate files in the GitHub repository. All code must be able to run on ubuntu linux, as set up in the informatics labs at IUEM. The raw data consist in the first three files from the SRA project n. SRP021469. 

## Useful links
- NCBI tools and databases are here: https://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&PAGE_TYPE=BlastDocs&DOC_TYPE=Download 
- `trimmomatic` is here: http://www.usadellab.org/cms/?page=trimmomatic
- `FastQC` is here: http://www.usadellab.org/cms/?page=trimmomatic
- `ipyrad` manual is here: https://ipyrad.readthedocs.io/en/master/ 
- the `markdown` guide is here: https://www.markdownguide.org
- Github is this site :-)

## Useful tips

You may want to work from the informatics lab or from a live ubuntu USB session, but make sure your code runs in the informatics lab. Get a `bash` shell cheat sheet to help you. Set up you working directory as such: `~/bioinfo` is your main directory. `~/bioinfo/rawdata` contains the `fastq` downloaded and unzipped form ncbi. `~/bioinfo/cleandata` contains reads sorted by `trimmomatic`. the `FastQC` files can be stored in the directory corresponding to its iput `fastq` files. `~/bioinfo/noITS` contains cleaned reads without ITS sequences (your input for Ex. 2). ~/bioinfo/ipyrad` contains your ipyrad analysis; set up your subdirectories as proposed in the `ipyrad` manual. 

## Exercise 1. 

Install and test FastQC and the blast toolkit. Retrieve and set-up the ncbi ITS database for Eukaryotes. Write a script to run automatically `FastQC` on `.fastq` files present in a directory, and store the results in a `tab` delimited text file, run `trimmomatic` and clean the reads with the settings provided in the exemple command line for SE reads; re-run fastQC on the same files. Prepare a summary table in markdown with the result of FastQC before and after cleaning by trimmomatic. Please explain the percentage of data removed and explain. Remove all reads matching ITS sequencing using the blast toolkit. 

## Exercice 2. 

Use the cleaned data from exercise 1 to run ipyrad. Install ipyrad and dependencies. create a `params` file for SE sdRAD reads obtained using Pst1. Construct a catalog of loci that are match the following conditions (...). Explain the why the number of recruited loci differs among the parameter values used for depth of coverage and percent similarity.
