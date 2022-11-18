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
4. add an `analysis`subdirectory
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
ipyrad -p params-pedicularis.txt -s 12 -r
ipyrad -p params-pedicularis.txt -s 34567 -r
```
We'll look at the report and the outfiles. Please open the files named `pedicularis_stats.txt` and `pedicularis.loci`. Now put your seatbelt on: we'll look at the `pedicularis.vcf` file. Here is the doc to read it: https://samtools.github.io/hts-specs/VCFv4.2.pdf. 

## First run

Run in triplicate : choose a file and split it in three chuncks : `split -l929328 SRR1754715.fastq slice`. Check the number of sequences for each replicate with `grep` and `wc`(with a pipe) as seen previously. 

Create your `param` file : `ipyrad -n test` creates `param-test.txt`. I've put an example in the github. Parameters by default, except of course paths. Let's make vary the depth of coverage for parameters [11] and [12] ; check and change parameter [13] accordingly. Since we have 3 slices, let's set [21] to 3. `ipyrad`needs a few minutes to perform the run using `ipyrad -p params-test.txt -s1234567 -r` and gives some info on the run (`-r`flag). Here is what's produced (all files starting with preffix `test` : 

```
epante@NORVEGE ~/D/pedicularis> ls -lrth
total 64
drwxr-xr-x   5 epante  staff   160B Nov 18 14:06 raw/
-rw-r--r--   1 epante  staff   3.0K Nov 18 14:07 params-test.txt
-rw-r--r--   1 epante  staff    79B Nov 18 14:07 test_s1_demultiplex_stats.txt
drwxr-xr-x   6 epante  staff   192B Nov 18 14:07 test_edits/
drwxr-xr-x   7 epante  staff   224B Nov 18 14:09 test_clust_0.85/
drwxr-xr-x   9 epante  staff   288B Nov 18 14:09 test_consens/
drwxr-xr-x  10 epante  staff   320B Nov 18 14:09 test_across/
drwxr-xr-x   7 epante  staff   224B Nov 18 14:09 test_outfiles/
-rw-r--r--   1 epante  staff    18K Nov 18 14:09 test.json
```

`test.json`is produced during step one and is your assembly file (see manual). folders give result / data files for different steps (eg `test_outfiles`for step 7). the program provides a great roadmap to files at the end of the run : 

```
step 1: ./test_s1_demultiplex_stats.txt
step 2: ./test_edits/s2_rawedit_stats.txt
step 3: ./test_clust_0.85/s3_cluster_stats.txt
step 4: ./test_clust_0.85/s4_joint_estimate.txt
step 5: ./test_consens/s5_consens_stats.txt
step 6: ./test_across/test_clust_database.fa
step 7: ./test_outfiles/test_stats.txt
```

## Playing with the parameters 

Let's keep all parameters as before but make the depth vary ([11] and [12]). Record the following information : 
1. 

### Result table (+/- SE)




| [11] param   |var        | sum_var    |pis  sum_pis| He         |
|--------------|-----------|------------|------------|------------|
| 6            |           |            |            |            |
| 12           |           |            |            |            |
| 24           |           |            |            |            |
| 50           | 1         | 3          | 0          | 0.027119   |
| 100          |75         | 0          |75          | 0.007      |
| 500          |0          |0           |0           |0           |

    6    |     23    |    93      |     0      |     0      |  He : 0.03277


