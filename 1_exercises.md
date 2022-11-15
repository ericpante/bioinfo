# Unix Shell and BASH exercices

## Exercise 1

Based on file SRR1754715 from SRA (RADseq Pedicularis sect. Cyathophora: https://www.ncbi.nlm.nih.gov/sra/?term=SRR1754715). 
Let's have a look at the first sequence of the file to remind us of the format of fasta and fastq. 
FASTQ :
```
@SRR1754715.1.1 GRC13_0027_FC:4:1:12560:1179 length=74
TGCAGGAAGGAGATTTTCGNACGTAGTGNNNNNNNNNNNNNNGCCNTGGATNNANNNGTGTGCGTGAAGAANAN
+SRR1754715.1.1 GRC13_0027_FC:4:1:12560:1179 length=74
??????????????????????????????????????????????????????????????????????????
```
FASTA :
```
>SRR1754715.1.1 GRC13_0027_FC:4:1:12560:1179 length=74
TGCAGGAAGGAGATTTTCGNACGTAGTGNNNNNNNNNNNNNNGCCNTGGATNNANNNGTGTGCGTGAAGAANAN
```

Write a bash script (executable `file.sh` file) that converts fastq into fasta. 
-> script input: "fastq"
-> script output: "fasta"
ex. using `grep` et `sed`
make use of bash-defined variables. 

------------------------------------------------------------------------

## Exercise 2

*use saucisson <-> seitan according to yout preferences.*

1. create a directory called `saucisson`. 
2. in `saucisson` : split the file in x files containing 10,000 sequences (not lines) each. 
3. out of `saucisson`: write a script that spits our the number of sequences in each of the file contained in saucisson`. 

------------------------------------------------------------------------

## Exercise 3

create a function to run fastqc and parse its results in a tabular format. 

1. make a summary as such : 

```
PASS    Basic Statistics        SRR1754715.fastq
PASS    Per base sequence quality       SRR1754715.fastq
PASS    Per tile sequence quality       SRR1754715.fastq
PASS    Per sequence quality scores     SRR1754715.fastq
FAIL    Per base sequence content       SRR1754715.fastq
WARN    Per sequence GC content SRR1754715.fastq
PASS    Per base N content      SRR1754715.fastq
PASS    Sequence Length Distribution    SRR1754715.fastq
FAIL    Sequence Duplication Levels     SRR1754715.fastq
WARN    Overrepresented sequences       SRR1754715.fastq
PASS    Adapter Content SRR1754715.fastq
```

2. make a summary as such : 

```
SRR1754715.fastq 696994 74 44 P P P P F W P P F W P
```

------------------------------------------------------------------------

## Exercise 4

create a function to parse a vcf file and keep variants according to the number of alleles (a) within individuals, (b) among individuals. 


