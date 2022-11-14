#!/bin/bash

## USAGE
## run_fastqc SRR1754715.fastq

for i in "$@" ; do
    run_fastqc $i
done
