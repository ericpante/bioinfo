# introduction to the terminal and the shell 

## getting started and basic commands

if you need to install software on ubuntu, check out `apt-get` https://doc.ubuntu-fr.org/apt-get. 
to ease your work, consider installing `homebrew` (https://docs.brew.sh/Homebrew-on-Linux) and `fish` (https://fishshell.com). 

work in class - getting acquainted with the following commands:
- getting the docs: `man` (enter `q`to quit the manual)
- nagivating across folders: `pwd`, `ls`, `cd`, `tree`, `du -h`
- creating a file: `touch`, redirecting standard output with `>`, creating folder `mkdir`
- copying `cp`, moving `mv`, removing `rmdir`, `rm`
- printing the content of a file: `cat` for zipped files : `zcat`
- understanding and changing file permissions (`chmod`)
- working with archives: `tar` and tarballs
- compressing `gzip` and decompressing `gunzip`
- file download: `wget`
- wildcards (characters with special meanings) and globbing: `?`, `*`, `!`, `[...]`...
- piping: `|`
- scripting: `.sh`
- variables: `$PATH`, `$HOME`, `$1`, `$@`...

## getting `fastq`data

have a look at the NIH Small Read Archive: https://www.ncbi.nlm.nih.gov/sra/?term=SRR1754715 
SRR1754715 is a `fastq` file from SRA (RADseq Pedicularis sect. Cyathophora). you can get the data manually through the SRA interface but we are going to do it through the terminal. 

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

## looking at raw genomic data through `fastq`

check out the footprint of the file with `gzip SRR1754715.fastq`and `gunzip SRR1754715.fastq` and looking at file size with `ls -lh *SRR1754715*`. what is the compression ratio ? what does `-lh`do ? 

let's look at the raw data: `cat SRR1754715.fastq | head`. what is `head` ? what is the `pipe`doing ? 

```
@SRR1754715.1 GRC13_0027_FC:4:1:12560:1179 length=74
TGCAGGAAGGAGATTTTCGNACGTAGTGNNNNNNNNNNNNNNGCCNTGGATNNANNNGTGTGCGTGAAGAANAN
+SRR1754715.1 GRC13_0027_FC:4:1:12560:1179 length=74
IIIIIIIGIIIIIIFFFFF#EEFE<?################################################
@SRR1754715.2 GRC13_0027_FC:4:1:15976:1183 length=74
TGCAGTTGTAAATACAAATATCCCAAAANNNNGNNNNNNNTNTAATATTTTGNAANNTTGAGGGGTGTGATNTN
+SRR1754715.2 GRC13_0027_FC:4:1:15976:1183 length=74
GGGGHHHHHHHHHHHHHDHGHHHHCAAA##############################################
@SRR1754715.3 GRC13_0027_FC:4:1:19092:1179 length=74
TGCAGGCTCTGACAAAGAANTCGACTGANNNNNNNNNNNNNNCACNGGTTCNNGNNNATGTCAATGTGGTANAN
```

check out the start of the `fastq` sequence ; what is the `TGCA`motif ? 

how would you check the number of sequences contained in this file ? `wc -l < SRR1754715.fastq` and divide by 4. 

```
nseq=$((`wc -l < SRR1754715.fastq` / 4))
echo $nseq
```

here is another way: use `grep`to find a pattern that matches the sequence names: `grep "^@SRR" SRR1754715.fastq | wc -l`

### `fastqc` for quality control

we are going to look at the data through the terminal and analyse its quality through `fastqc`. get the program (GUI and command-line) at https://www.bioinformatics.babraham.ac.uk/projects/fastqc/. First use the GUI to assess the quality (discussion in class) and then try to run the analysis from the terminal. 

```
epante@NORVEGE ~/D/bioinfo> ./fastqc SRR1754715.fastq
null
Started analysis of SRR1754715.fastq
Approx 5% complete for SRR1754715.fastq
[...]
Approx 95% complete for SRR1754715.fastq
Analysis complete for SRR1754715.fastq
epante@NORVEGE ~/D/bioinfo> 
```

running the app from the terminal has the advantage of allowing batch analysis of files : consider the following script called `batch_fqc.sh`, calling the sub-routine `run_fastqc.sh` (please read through and look at the different scripts and subscripts prior to executing):

```#!/bin/bash

## USAGE
## run_fastqc SRR1754715.fastq

# 1. Run fastqc
~/Downloads/FastQC/./fastqc $1

# 2. Prep folder
name=$(echo $1 | cut -d '.' -f 1)
suff="_fastqc"
fold="$name$suff"

echo "Unzipping..."
unzip -o $fold 
echo "...done."
echo ""

# Parse result
echo "Parsing..."
~/Downloads/./parsing_fastqc.sh $fold/fastqc_data.txt > Results_fastq_parsing.txt
echo "...done."
# chmod a+x run_fastqc.sh
```

and then

```
#!/bin/bash           # interpret the script in bash
                      # 'batch_fqc.sh file1.fq file2.fq file3.fq' to execute
for i in "$@" ; do    # for each file listed as arguments, do
    ./run_fastqc.sh $i   # runs fastqc for each item of the for loop (var 'i' is incremented)
done                  # close the loop
```

`$@` is an array-like construct of all positional parameters, here `{$1, $2, $3}`.

now we can parse the results of `fastqc` into a table : 
https://github.com/ericpante/bioinfo/blob/main/parsing_fastqc.sh 

### other handy scripts for `fastq` manipulation

an example of file format convertion from `fastq`to `fasta` using `grep`and `sed`:
```
#!/bin/bash
grep -A1 "@SRR*" $1 | sed 's/@SRR/>SRR/g' | sed '/--/d'
```
what does the `-A1`argument does ? why use two `sed` calls? 
an example of batch calculation of sequence numbers from the `fastq` file format:
```
#!/bin/bash
for i in "$@" ; do
    n=$(grep "@SRR*" $i | wc -l)
    echo "$i contains $n sequences"
done
```
what would you change to make this script work for `fasta`? for either file format? 
