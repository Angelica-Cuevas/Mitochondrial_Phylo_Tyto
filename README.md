# Mitochondrial_Phylo_Tyto
Building a mitochondrial phylogeny for Tyto species:

In this repository you will find information regarding the data available, how to acees the computer (iMac) remotely and a pipeline (in progress) for running a Maximun Likelihood (RAxmL) tree for several species of Tyto owls. The pipeline will be build by you, with my our help. Help scripts will be uploaded to help you write your code, but I hope you build your own scripts. Of course we're here to help you, so if you have any questions, just reach out!

### repository's folders
Here you will find basic scripts that will give you a head start for building your own code. I will upload some example scripts for you to start working.

### Using the terminal and shell
Working with genomic data usually requires demanding computing resources and each command can take hours or even days. Also genomic data is usually stored in large files, thus the best way to analyse your data is using High performance computing - HPC (aka a cluster: is a collection of many separate servers (computers)). Usually institutions like your university will have or have access a HPC cluster. Now, to be able to analyse your genomic data in a cluster you need to access it remotely from your own computer. For this we need to comunicate with the cluster via a terminal program and the "shell" (https://en.wikipedia.org/wiki/Shell_(computing)).

Terminal programs are available for all operating systems: Mac OSX and Linux already have an application called “Terminal”, while Windows needs some additional installation because most windows systems do not have a terminal program. One alternative for a windows machine is installing Putty: https://www.putty.org/

Go to http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html to donwload PUTTY and select the corresponding bit installer corresponding to your machine (either 32-bit or 64-bit Windows installer). 


### A very easy Unix tutorial if you're not very familiar with the command-line
Last year I, together with other members of the evomics workshop, developed a easy to follow introduction to the Unix. It is ideal that you follow it if you're not familiar with unix and the command-line. Since we will mostly work in the command-line this tutorial will be very useful for when you start developing your own scripts: https://evomics.org/learning/population-and-speciation-genomics/2022-population-and-speciation-genomics/unix-primer/

Here another very nice introduction-to-scripting tutorial I will recomend you follow:
https://astrobiomike.github.io/unix/scripting

### How to access the iMAC remotely
For the analysis of the mitogenome of the Tyto species we will work on a iMac that is located on one of our offices. But as mentioned before we will also access it remotely (as if we were to access a HPC cluster)

Open a terminal and use "ssh" (secure shell) to access the iMac remotely:

`
ssh username@pcdee4323.unil.ch
`

a password will be asked. Type your password, even if it seems like you're not typing anything, you are indeed entering your password, so once you finish typing your password just press ENTER.

... and that's it you're not communicating with another computer (out iMAC) remotely from your own machine!

### Data folders

Where to find the data and what do we have in the data folders?


### 
