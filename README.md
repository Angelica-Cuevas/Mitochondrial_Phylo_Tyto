# Mitochondrial_Phylo_Tyto
## Building a mitochondrial phylogeny for Tyto species

In this repository you will find information regarding the data available, how to acees the computer (iMac) remotely and a pipeline (in progress) for performing a Maximun Likelihood (RAxmL) tree for several species of Tyto owls. The pipeline will be build by you, with our help. Example scripts will be uploaded to help you write your code and build your own scripts. But of course we're here to help you, so if you have any questions or need help, just reach out!

### This repository's folders
Here you will find basic example scripts that will give you a head start. I will upload some scripts for you to start working.

### Using the terminal and shell
Working with genomic data usually requires demanding computing resources and each command can take hours or even days. Also genomic data is usually stored in large files, thus the best way to analyse your data is using High performance computing - HPC (aka a cluster: is a collection of many separate servers (computers)). Usually institutions like your university will have or have access a HPC cluster. Now, to be able to analyse your genomic data in a cluster you need to access it remotely from your own computer. For this we need to comunicate with the cluster via a terminal program and the [shell](https://en.wikipedia.org/wiki/Shell_(computing)).

Terminal programs are available for all operating systems: Mac OSX and Linux already have an application called “Terminal”, while Windows needs some additional installation because most windows systems do not have a terminal program. One alternative for a windows machine is installing [Putty](https://www.putty.org/)

Go to http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html to donwload PUTTY and select the corresponding bit installer that is compatible with your machine (either 32-bit or 64-bit Windows installer). 


### An easy Unix tutorial if you're not very familiar with the command-line
Last year I, together with other members of the evomics workshop, developed a easy to follow introduction to Unix ([here](https://evomics.org/learning/population-and-speciation-genomics/2022-population-and-speciation-genomics/unix-primer/)). It is ideal that you follow this tutorial if you're not familiar with unix and the command-line. Since we will mostly work in the command-line it is important that you become familiar with the basics of unix and scripting. 

Here another very nice unix tutorial: https://astrobiomike.github.io/unix/unix-intro
After following these unix tutorials I'm sure you're more familiar with working in the command-line and in general with unix. Now you need to start learning a bit more about scriptting, which basically is just putting a series of commands into an executable file, a script, so you can run your analyses just by executing a script instead of running them one by one in the terminal window.

I recomend you to go through this scripting tutorial, it's a nice introduction and it will definitely help you when you have to build your own scripts: https://astrobiomike.github.io/unix/scripting

### How to access the iMAC remotely
For the analysis of the mitogenome of the Tyto species we will work on a iMac that is located on one of our offices. But as mentioned before we will also access it remotely (as if we were to access a HPC cluster)

Open a terminal and use "ssh" (secure shell) to access the iMac remotely:

```
ssh username@pcdee4323.unil.ch
Password:
```

A password will be asked. Type your password, even if it seems like you're not typing anything, you are indeed entering your password, so once you finish typing just press ENTER.

... and that's it all, now you're communicating with another computer (out iMAC) remotely from your own machine!

### Data folders

#### Where to find the data and what do we have in the data folders?

Once you access the iMac remotely you will be in your home directoy

```
/Users/myusername
```
at any time you can go to your home directory using ` cd $HOME ` or ` cd ~ `

The mithocondrial sequencing data is located in the following directory

```
/Users/Shared/MitoGenome_museum/
```
you can work and produce your results in this or your home directory. It's up to you.

More detailed information about the data folders in the [Data_folders_README](Data_folders.md)

### The PIPELINE

In order to buld a phylogenetic tree (our goal) a series of steps processing our mitogenomic data need to be follow. These steps are called the PIPELINE. In the course of running the pipeline new output files will be generated that is stored in their corresponding folders (the Data folders). The `0_README_MitoConsensus` file explain our pipeline. 

In short: 
1. Raw reads (sequences) are mapped to the reference mitogenome of Tyto alba
2. Variants of each samples are identified and a mitogenome consensus per samples is built using the reference mitogenome and the variants information specific to each sample.
3. Rename each sequence in the header.
4. Identify the first and last gene present in the coding region of each mito-consensus (using MITOS)
5. Repetitive elements present in the consensus mitogenomes should be removed
6. An alignment of all mito-consensus is generated (using MATTF)
7. We will build a phylogenetic tree using maximum likelihood, thus we will used RAxML

Be aware that steps 1, 2 and 3 were already done for you! So you already have the mitoconsensus per sample in the `2_MitoConsensus` folder

###
