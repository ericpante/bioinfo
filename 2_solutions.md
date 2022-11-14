## Exercise 1

To convert a fastq to fasta, using the previously learned command, see script `fastq2fasta.sh`. 

## Exercise 2

See `get_sequence_number.sh` and `get_sequence_number_batch.sh` as separate script files. 

Type the following commands. 
```
mkdir saucisson # create saucisson or seitan
cd saucisson # go into the created folder
split -l 40000 -d SRR1754715.fastq SRR1754715_ # 10,000 sequences needed, ie 40,000 fastq lines
cd .. # step back
chmod a+x get_sequence_number_batch.sh # make script executable
bash get_sequence_number_batch.sh ./saucisson/SRR1754715_* # run script
```

## Exercise 3

We created three scripts, which will work in concert. `parsing_fastqc.sh` parses the output of fastqc into a tabular format and returns it in standard output. `run_fastq.sh` launches fastqc, unzips the output and calls `parsing_fastqc.sh` that performs the parsing. The `batch_fastqc.sh`script is a module to use `run_fastq.sh` in batch mode, ie to parse multiple fastq files from a folder. All three scripts are in the `bioinfo/ folder. 
