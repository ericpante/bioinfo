séquencer P1 au P2

*synchronized* files R1 and R2
```
SEQ_R1.fastq.gz
@ABCD...sdfgsdfgs... R1
ATGCATGCATGCATGCATGCATGCATGC

SEQ_R2.fastq.gz
@ABCD...sdfgsdfgs... R2
ATGGGCGATGGGCGATGGGCGATGGGCG
```

paired reads : *concatenated* sequences R1R2
```
SEQ_R1R2.fastq.gz

@ABCD...sdfgsdfgs... R1
ATGCATGCATGCATGCATGCATGCATGC
...
@ABCD...sdfgsdfgs... R2
ATGGGCGATGGGCGATGGGCGATGGGCG
