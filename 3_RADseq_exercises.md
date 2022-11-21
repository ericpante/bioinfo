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

Let's have a look at `more test_stats.txt` ("Final stats file" in the ipyrad manual). 

```
epante@NORVEGE ~/D/p/test_outfiles> more test_stats.txt

## The number of loci caught by each filter.
## ipyrad API location: [assembly].stats_dfs.s7_filters

                           total_filters applied_order retained_loci
total_prefiltered_loci                 0             0          2255
filtered_by_rm_duplicates              3             3          2252
filtered_by_max_indels                 0             0          2252
filtered_by_max_SNPs                   0             0          2252
filtered_by_max_shared_het           232           232          2020
filtered_by_min_sample              1535          1535           485
total_filtered_loci                 1770          1770           485
```

We can see from the first table that 485 are retained in the final catalog, and that the biggest drop in the number of loci, while performing the analysis, occured when we asked for loci present in all three samples. Indeed, 1535 loci are lost at this step. 

```
## The number of loci recovered for each Sample.
## ipyrad API location: [assembly].stats_dfs.s7_samples

          sample_coverage
slicesaa              485
slicesab              485
slicesac              485
```
Sanity check : Same number of loci / sample. 

```
## The number of loci for which N taxa have data.
## ipyrad API location: [assembly].stats_dfs.s7_loci

   locus_coverage  sum_coverage
1               0             0
2               0             0
3             485           485
```
Sanity check : Same number of loci / sample.

```
The distribution of SNPs (var and pis) per locus.
## var = Number of loci with n variable sites (pis + autapomorphies)
## pis = Number of loci with n parsimony informative site (minor allele in >1 sample)
## ipyrad API location: [assembly].stats_dfs.s7_snps
## The "reference" sample is included if present unless 'exclude_reference=True'

   var  sum_var  pis  sum_pis
0  415        0  485        0
1   40       40    0        0
2   20       80    0        0
3    9      107    0        0
4    0      107    0        0
5    1      112    0        0
```
This is explained in the FAQ of the docs : https://ipyrad.readthedocs.io/en/master/faq.html?highlight=sum_var#how-do-i-interpret-the-distribution-of-snps-var-and-pis-per-locus-in-the-stats-txt-output-file. For us : 
1. There is no locus with parsimony-informative site (`pis`). 
2. Most of the retained loci (485) are actually monomorphic ; which makes sense because our three samples are subsets of the same file. 
3. There are 40 loci with 1 SNP, 20 loci with 2 SNPs, etc. In total, there are 112 SNPs (sum_var : 1x40+2x20+ ...). 

```
## Final Sample stats summary
          state  reads_raw  reads_passed_filter  clusters_total  clusters_hidepth  hetero_est  error_est  reads_consens  loci_in_assembly
slicesaa      7     232332               229906           77272              5913    0.032509   0.003706           4060               485
slicesab      7     232332               229873           77115              5891    0.032176   0.003744           4066               485
slicesac      7     232330               230217           76846              5895    0.032496   0.003622           4036               485


## Alignment matrix statistics:
snps matrix size: (3, 112), 30.06% missing sites.
sequence matrix size: (3, 32453), 0.36% missing sites.
```
To understand the results of this first run, we need to keep in mind that we split one file (`SRR1754715.fastq`) containing 696,994 reads into three files (slices), which contain 232,332, 232,332, 232,330 reads, respectively. We expect that we will not hit all loci in all slices, because coverage will vary from one slice to the other. Keeping only loci shared among all three slices, we should expect that all genotypes are the same. SNPs are therefore either sequencing errors that we mistaken for alleles (eg coverage parameter set to low), missed alleles due to coverage parameter set too high (allele dropout), or misassembly/alignment (eg inclusing of multi-copy region). Please see Mastretta Yanes et al 2014 for details (doi: 10.1111/1755-0998.12291).

## Playing with the parameters 

Let's keep all parameters as before but make the depth vary ([11] and [12]). Record the following information : 
1. the total number of retained loci (485 in previous example)
2. the total number of variants (112 in previous example)
3. heterozygocity (for your first slice; look at `s4_joint_estimate.txt`)
4. error rate of basecalling (for your first slice; look at `s4_joint_estimate.txt`)

To do this, `ipyrad` has a nice utility called branching. `ipyrad -p params-test.txt -b testcov12`will create a new "branch" called 'testcov12' with a new params called `params-testcov12.txt`. Change your coverage value in this new param file, and let's roll !

```
ipyrad -p params-testcov12.txt -s34567 -r -f
```

### Result table: varying coverage

|coverage  |n. loci   |SNPs   |He        |ER.      |
|----------|----------|-------|----------|---------|
|6         |485       |112    | 0.032509 | 0.003706|
|12        |192       |27     | 0.061877 | 0.004702|
|24        |110       |6      | 0.049671 | 0.004103|
|36        |95        |4      | 0.035705 | 0.003387|

For more information on this topic : https://ipyrad.readthedocs.io/en/master/assembly_guidelines.html?highlight=error%20rate#what-parameters-have-the-biggest-effect-on-accuracy-of-genotypes-what-parameter-testing-should-be-done-with-a-new-taxon-or-dataset

### Result table: varying clustering threshold

|clustering|n. loci   |SNPs   |He        |ER.      |
|----------|----------|-------|----------|---------|
|99%       |766       |0      |0.000825  |0.000131 |
|98%       | 708      |136    | 0,002823 | 0.000804|
|95%       |  627     |  199  | 0.008869 | 0.001766|
|90%       |          |       |          |         |
|85%       |485       |112    | 0.032509 | 0.003706|
