# Data folders

All mitogenomic data for the different species of tyto can be found in 

```
/Users/Shared/MitoGenome_museum
```

Here you will find files with the `*.slurm` extension, files with `*param` and folders. All `.slurm` files are scripts. Scripts are a series of commands that tell specific programs what to execute in the data. [Here](https://astrobiomike.github.io/unix/scripting) is again the tutorial to scripting. It will definitely help you to understand our scripts, but more importantly you will learn how to build your own scripts.
Ok, back to the files and folders. The files ending in `.param` are usually list, of our samples for example, that are used by the scripts to know which samples files it needs to look for to run the commands.

In the `/Users/Shared/MitoGenome_museum` folder you also find a `0_README_Mito_Pipeline` file, that you can also find in this repository. This file is the explanation of the pipeline (steps) we are going to follow to analyse our data.

### And finally the folders:

for now we have the following folders: 
- 0_DATA
- 1_Map
- 2_MitoConsensus

But while you follow the pipeline and run more analyses new folders will be generated. For now:

In `0_DATA` you have the reference mitogenome of T.alba. Here it's the `.fasta` file and another series of files, including the index, of the reference mitogenome.

In `1_Map` there are the `*.bam` files and their indexes. `*.bam` are generated after we map the reads to the T.alba ref mitogenome. these files hold the information of the position of where our reads mapped to the reference. Each sample has one `*.bam` file and its index , a `*bai` file. Now since these are too big, I didn't copy all of the samples here. They are stored in the university cluster, but we don't need them for now. What we need to start working is the files generated after we mapped the reads to the reference (see details of the pipeline in the 0_README_MitoConsensus file), and those are the consensus per sample, which you can find in the next folder:

In `2_MitoConsensus`, as the name hints this folder contains the mitogenomic consensus. After mapping the reads of each sample to the reference mitogenome, we identify variants (those positions where each sample (species) differentiate from the reference. After that, using the variants information, a consensus per sample is built, which correspond to the mitogenome of each of our samples.
The final consensus files are those ending in `*_FullMitoRenamed.fasta`
