## Exercise 1

See `get_sequence_number.sh` and `get_sequence_number_batch.sh`

```
mkdir saucisson
cd saucisson
split -l 40000 -d SRR1754715.fastq SRR1754715_
cd ..
bash test_batch.sh ./saucisson/SRR1754715_*
