## Introduction

We are going to perform a full analysis of RADseq data, from initial QC to SNP analysis, using `ipyrad` (Eaton and Overcast 2020). Data come from the Eaton & Ree (2013) single-end RAD data set. This link gives the background ; please have a look at the paper. https://ipyrad.readthedocs.io/en/master/API-assembly/cookbook-empirical-API-1-pedicularis.html. 

Eaton DAR, Overcast I. ipyrad: Interactive assembly and analysis of RADseq datasets. Bioinformatics. 2020 Apr 15;36(8):2592-2594. doi: 10.1093/bioinformatics/btz966. PMID: 31904816.

Eaton DAR, Ree RH. Inferring Phylogeny and Introgression using RADseq Data: An Example from Flowering Plants (Pedicularis: Orobanchaceae), Systematic Biology, Volume 62, Issue 5, September 2013, Pages 689–706, https://doi.org/10.1093/sysbio/syt032

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

Now let's set the scene for the analysis. 
1. Set ut a directory called `ipyrad` in your `$HOME`
2. add a `rawdata` subdirectory
3. add a `filtered` subdirectory
4. add an ànalysis`subdirectory
5. place your scripts at the root of your project directory, called ìpyrad`

## Lecture on library types

We will see in lecture how we can build different library types to get more sequence data from one run. Different libraries can have single-end (SE) reads, paired-end (PE) reads, reads with mated-pairs (MP). We will also review the different flavors of RAD (eg. sdRAD, ddRAD, etc.). 

## Getting the raw data through the SRA-toolkit (for information only - please don't run this-)

Let's get the data from SRA using their toolkit. Here is the SRA link : https://www.ncbi.nlm.nih.gov/sra. Here is the accession number : SRP021469. Get the `SRR_Acc_List.txt` to use with the toolkit

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
export PATH=$PATH:$PWD/sratoolkit.3.0.0-xxx/bin # xxx: replace by your version.
```
4. Test it. 
```
which fastq-dump
```

Now we can use the kit to get multiple SRR data files. 
```
prefetch ACCESSION ## or --option-file SRR_Acc_List.txt for a list
fastq-dump ACCESSION ACCESSION ACCESSION ACCESSION ...
```

## Getting the data through ipyrad

ipyrad has a wrapper to fetch the data from SRA. Use the following command to get the Eaton and Ree data. 
```
ipyrad --download SRP021469 rawdata/
```

## Running the ipyrad analysis workflow

Now set up a new assembly named after the biological model system: 
```
ipyrad -n pedicularis
```
Please open the `params-pedicularis.txt` and study the param file. We'll divide up the steps and the params among us, and in 15' we'll each take turn to explain to the others how the "our parameter" works. 

Let's run ipyrad with the chosen parameters : 
```
ipyrad -p params-pedicularis.txt -s 1234567 -r
```
We'll look at the report and the outfiles. Please open the files named `pedicularis_stats.txt` and `pedicularis.loci`. Now put your seatbelt on: we'll look at the `pedicularis.vcf` file. Here is the doc to read it: https://samtools.github.io/hts-specs/VCFv4.2.pdf. 
