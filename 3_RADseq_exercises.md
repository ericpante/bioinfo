## Introduction

We are going to perform a full analysis of RADseq data, from initial QC to SNP analysis, using `ipyrad` (Eaton and Overcast 2020). 

Eaton DAR, Overcast I. ipyrad: Interactive assembly and analysis of RADseq datasets. Bioinformatics. 2020 Apr 15;36(8):2592-2594. doi: 10.1093/bioinformatics/btz966. PMID: 31904816.

## Setting up your workstation

1. On the university computers, log into Ubuntu. Alternatively, run your live Lubuntu from your USB drive. 
2. Install `conda` using the following commands (source: https://ipyrad.readthedocs.io/en/master/3-installation.html#longform). The full instructions are on the `ipyrad` website. 

```
# Fetch the miniconda installer with wget
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

# Install miniconda into $HOME/miniconda3
#  * Type 'yes' to agree to the license
#  * Press Enter to use the default install directory
#  * Type 'yes' to initialize the conda install
bash Miniconda3-latest-Linux-x86_64.sh

# Refresh your terminal session to see conda
bash

# test that conda is installed. Will print info about your conda install.
conda info

# install ipyrad
conda install ipyrad -c conda-forge -c bioconda

# additional conda settings recommended by the authors
conda create -n ipyrad
conda activate ipyrad
conda install ipyrad -c conda-forge -c bioconda

# setting conda-forge as your default conda channel 
conda config --add channels conda-forge
conda config --set channel_priority strict
```

`ipyrad` should be up and running. 

## Lecture on library types

We will see in lecture how we can build different library types to get more sequence data from one run. Different libraries can have single-end (SE) reads, paired-end (PE) reads, reads with mated-pairs (MP). We will also review the different flavors of RAD (eg. sdRAD, ddRAD, etc.). 

## Getting the raw data through the SRA-toolkit. 

Let's set the scene. 
1. Set ut a directory called `ipyrad` in your `$HOME`
2. add a `rawdata` subdirectory
3. add a `filtered` subdirectory
4. add an ànalysis`subdirectory
5. place your scripts at the root of your project directory, called ìpyrad`

Let's get the data. These come from the Eaton & Ree (2013) single-end RAD data set. 

Deren A. R. Eaton, Richard H. Ree, Inferring Phylogeny and Introgression using RADseq Data: An Example from Flowering Plants (Pedicularis: Orobanchaceae), Systematic Biology, Volume 62, Issue 5, September 2013, Pages 689–706, https://doi.org/10.1093/sysbio/syt032

This link gives the background ; please have a look at the paper. https://ipyrad.readthedocs.io/en/master/API-assembly/cookbook-empirical-API-1-pedicularis.html. You can get the data from SRA, as seen in another exercise. Here is the link : https://www.ncbi.nlm.nih.gov/sra. Here is the accession number : SRP021469. Get the `SRR_Acc_List.txt`

We will use the SRA tool kit. Here is the HowTos: https://github.com/ncbi/sra-tools/wiki/HowTo:-fasterq-dump and https://github.com/ncbi/sra-tools/wiki/08.-prefetch-and-fasterq-dump

1. Get the toolkit: 
```
wget --output-document sratoolkit.tar.gz https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz
```
2. Extract the tookit from tarball
```
tar -vxzf sratoolkit.tar.gz
```
3. Add the toolkit to the `$PATH` (for this session only)
```
export PATH=$PATH:$PWD/sratoolkit.3.0.0-mac64/bin
```
4. Test it. 
```
which fastq-dump
```

Now we can use the kit to get multiple SRR data files. 
```
prefetch --option-file SRR_Acc_List.txt
fastq-dump ACCESSION
```

## Getting the data through ipyrad. 

ipyrad has a wrapper to fetch the data from SRA. Use the following command to get the Eaton and Ree data. 
```
ipyrad --download SRP021469 example_empirical_data/
```
