# analysing RADseq data with Stacks2
Stacks2 is an analysis pipeline for RADseq sequences, tailored for population genetics data. 
The manual and download links are here: http://catchenlab.life.illinois.edu/stacks/ . 
To install the pipeline, download the file, move it to your working directory, and build the software: 
```
mv ~/Downloads/stacks-2.65.tar.gz ~/Desktop/bioinfo/
cd ~/Desktop/bioinfo/
tar xfvz stacks-2.65.tar.gz
cd stacks-2.65
./configure --prefix=$HOME/Desktop/bioinfo/
make
make install
```
Get the three following datasets (`SRR1754728`, `SRR1754720`, `SRR1754715`) and split them in 5 sub-datasets in order to get 15 files, 5 from each of 3 theoretical lineages. Use the `sratookit` to do so. To split the dataset, we will use `fastqsplitter`, which github repo is [here](https://github.com/LUMC/fastqsplitter) and doc is [here](https://fastqsplitter.readthedocs.io). 

Install using `conda`:
```conda install fastqsplitter -c conda-forge -c bioconda```

The program works like so:
```fastqsplitter -i SRR1754715.fastq.gz -o SRR1754715_1.fastq.gz -o SRR1754715_2.fastq.gz -o SRR1754715_3.fastq.gz```
Please do this for the three files. 



