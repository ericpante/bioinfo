#!/bin/bash

# USAGE:
# parsing_vcf.sh FILE.vcf

# how many samples
grep "#CHROM" toy.vcf | sed -r 's/.{52}//' | awk {print "NF"}

# total number of alleles
cat toy.vcf | sed '/^#/d' | tr -s " " | cut -d " " -f 5 | sed 's/,//g' | awk '{print length+1}'

# number of allele / sample
cat toy.vcf | sed '/^#/d' | tr -s " " | cut -d " " -f 10 | cut -d ":" -f 3 | sed 's/[^0]//g' | awk '{print 4-length}'

h