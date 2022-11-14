#!/bin/bash

## USAGE
## run_fastqc SRR1754715.fastq

# 1. Run fastqc
~/Downloads/FastQC/./fastqc $1

# 2. Prep folder
name=$(echo "SRR1754715.fastq" | cut -d '.' -f 1)
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
# chmod a+x batch_fastqc.sh 
