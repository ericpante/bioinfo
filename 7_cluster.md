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





