#!/bin/bash

## USAGE
## parsing_fastqc fastqc_data.txt

file=$(grep "^Filename" $1 | cut -f 2)
seq=$(grep "^Total Seq" $1 | cut -f 2)
len=$(grep "^Sequence len" $1 | cut -f 2)
gc=$(grep "^%GC" $1 | cut -f 2)

qc1=$(grep "Basic Statistics" $1 | cut -f 2 | cut -b 1)
qc2=$(grep "Per base sequence quality" $1 | cut -f 2 | cut -b 1)
qc3=$(grep "Per tile sequence quality" $1 | cut -f 2 | cut -b 1)
qc4=$(grep "Per sequence quality scores" $1 | cut -f 2 | cut -b 1)
qc5=$(grep "Per base sequence content" $1 | cut -f 2 | cut -b 1)
qc6=$(grep "Per sequence GC content" $1 | cut -f 2 | cut -b 1)
qc7=$(grep "Per base N content" $1 | cut -f 2 | cut -b 1)
qc8=$(grep "Sequence Length Distribution" $1 | cut -f 2 | cut -b 1)
qc9=$(grep "Sequence Duplication Levels" $1 | cut -f 2 | cut -b 1)

qc10=$(grep "Overrepresented sequences" $1 | cut -f 2 | cut -b 1)
qc11=$(grep "Adapter Content" $1 | cut -f 2 | cut -b 1)
echo "$file $seq $len $gc $qc1 $qc2 $qc3 $qc4 $qc5 $qc6 $qc7 $qc8 $qc9 $qc10 $qc11"

# chmod a+x parsing_fastqc.sh 
