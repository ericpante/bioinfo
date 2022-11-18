#!/bin/bash

# USAGE:
# parsing_vcf.sh FILE.vcf

total.n.alleles=$(cat toy.vcf | sed  '/^#/d' | tr -s " " | cut -d " " -f 5 | sed 's/,//g' | awk '{print length +1}')
echo '$total.n.alleles'
