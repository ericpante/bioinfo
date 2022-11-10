#!/bin/bash
n=$(grep "@SRR*" $1 | wc -l)
echo "$1 contains $n sequences"

