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
We will use cleaned, 
