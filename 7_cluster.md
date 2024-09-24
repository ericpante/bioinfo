## instructions for working with the cluster

### `ssh` connection 

We will be working with the [IFB cluster](https://www.france-bioinformatique.fr/cluster-ifb-core/)
To start a session on the Terminal, and make a connection with `ssh`
```
ssh tpxxxxxx@core.cluster.france-bioinformatique.fr
```
Replace the "x" by your account number. The cluster documentation is [here](https://ifb-elixirfr.gitlab.io/cluster/doc/quick-start/).

### loading toolbox

Tools are conveniently packaged as "modules". Checkout the list of modules using `module avail`. To work with `fastqc`, load the module as follows: 
```
module load fastqc/0.12.1
```
check that it is loaded and ready to run with the following command:
```
fastqc -h # displays the help page for fastqc
```
Checkout the tools for analyzinf RADseq data with `module search rad`, which should return, among others, `ipyrad/0.9.95` and `stacks/2.65`.

### lauching jobs and checking results

### cluster use for population genomics

Stacks2 [tutorial](https://gist.github.com/Astahlke/bb9db6bee8bd225ee35353e47f4f2f9f) by [Amanda Stahlke](https://gist.github.com/Astahlke) from 2019 Conservation Genetics workshop. The dataset was published [here](https://moodlemer.univ-brest.fr/moodle/pluginfile.php/82126/mod_resource/content/0/Stahlke_etal_2021_Diorhabda.pdf). The draft reference genome (Acc SAMN23038877) is [here](https://www.ncbi.nlm.nih.gov/biosample/SAMN23038877/) and the raw reads (BioProject Acc PRJNA728708) are [here](https://www.ncbi.nlm.nih.gov/sra/?term=PRJNA728708). We will focus on this part of the dataset, called SRR14527637, and 

Get the data with [sratool](https://github.com/ncbi/sra-tools/wiki/08.-prefetch-and-fasterq-dump)
```
module load sra-tools/3.1.0
prefetch SRR14527637
fasterq-dump SRR14527637
```

