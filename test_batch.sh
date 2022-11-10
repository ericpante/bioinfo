#!/bin/bash

for i in "$@" ; do
    n=$(grep "@SRR*" $i | wc -l)
    echo "$i contains $n sequences"
done


