## Introduction

We are going to perform a full analysis of RADseq data, from initial QC to SNP analysis, using `ipyrad` (Eaton and Overcast 2020). 

Eaton DAR, Overcast I. ipyrad: Interactive assembly and analysis of RADseq datasets. Bioinformatics. 2020 Apr 15;36(8):2592-2594. doi: 10.1093/bioinformatics/btz966. PMID: 31904816.

## Setting up your work station

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

ipyrad should be up and running. 

## Lecture on library types

We will see in lecture how we can build different library types to get more sequence data from one run. Different libraries can have single-end (SE) reads, paired-end (PE) reads, reads with mated-pairs (MP). We will also review the different flavors of RAD (eg. sdRAD, ddRAD, etc.). 

