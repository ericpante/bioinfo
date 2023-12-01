# EXAM 2023 - BIOINFORMATICS

You must have created a GitHub account and invited `ericpante` to it. Please prepare a main file in MarkDown to explain your answers and provide your code. 
Please add your scripts as separate files in the GitHub repository. All code must be able to run on ubuntu linux, as set up in the informatics labs at IUEM. The raw data consist in the last three files from the SRA project n. SRP021469. 

## Useful links
- NCBI tools and databases are here: https://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&PAGE_TYPE=BlastDocs&DOC_TYPE=Download 
- `trimmomatic` is here: http://www.usadellab.org/cms/?page=trimmomatic
- `FastQC` is here: http://www.usadellab.org/cms/?page=trimmomatic
- `ipyrad` manual is here: https://ipyrad.readthedocs.io/en/master/ 
- the `markdown` guide is here: https://www.markdownguide.org
- GitHub is this site :-)

## Useful tips

You may want to work from the informatics lab or from a live ubuntu USB session, but make sure your code runs in the informatics lab. Get a `bash` shell cheat sheet to help you. Set up your working directory as such: `~/bioinfo` is your main directory. `~/bioinfo/rawdata` contains the `fastq` downloaded and unzipped from ncbi. `~/bioinfo/cleandata` contains reads sorted by `trimmomatic`. the `FastQC` files can be stored in the directory corresponding to its iput `fastq` files. `~/bioinfo/noITS` contains cleaned reads without ITS sequences (your input for Ex. 2). `~/bioinfo/ipyrad` contains your ipyrad analysis; set up your subdirectories as proposed in the `ipyrad` manual. 

## Exercise 1. 

Install and test FastQC and the blast toolkit. Retrieve and set-up the ncbi ITS database for Eukaryotes. Write a script to run automatically `FastQC` on `.fastq` files present in a directory, and store the results in a `tab` delimited text file, run `trimmomatic` and clean the reads with the settings provided in the exemple command line for SE reads; re-run fastQC on the same files. Prepare a summary table in `markdown` with the result of FastQC before and after cleaning by trimmomatic. Please explain the percentage of data removed and explain. Remove all reads matching ITS sequencing using the blast toolkit. 

## Exercice 2. 

Use the cleaned data from exercise 1 to run `ipyrad`. Install `ipyrad` and dependencies. Create a `params` file for SE sdRAD reads obtained using Pst1. Use this file as a template: https://github.com/ericpante/bioinfo/blob/main/param-test.txt. Construct a catalog of loci with the default settings, branch your analysis (see `ipyrad` manual) and rerun only changing the `clust_threshold` parameter to 90%, 95%, 99%. Summarize as a `markdown`table describe the results; propose an interpretation for the results.
