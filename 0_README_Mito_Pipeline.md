## 1. map the reads

``
awk '{print "sbatch 1_AlignMito.slurm "$0}' 1_AlignMito.param | bash
``

### 1.1 Calculate the coverage and mean depth using samtools

#### DEPTH
Please see the samtools [documentation](http://www.htslib.org/doc/samtools.html) to understand which tools we are using here. 

To get the mean depth in each position you can ``samtools depth`` which will give you the depth per site (in column 3), but you need to average that across the whole mitogenome as and you can also calculate the standard deviation:

``
samtools depth -a mybamfile.bam  |  awk '{sum+=$3; sumsq+=$3*$3} END { print "Average = ",sum/NR; print "Stdev = ",sqrt(sumsq/NR - (sum/NR)**2)}'
``

Here NR will be the total number of sites. However, the calculation should be done by dividing over the the extact number of sites present in the reference genome we used (Tyto alba mitogenome). That infomation is also within the bamfile of each individual and you can get it using:

``
samtools view -H mybamfile.bam | grep -P '^@SQ' | cut -f 3 -d ':' | awk '{sum+=$1} END {print sum}'
``
You should have gotten "17092" base pair in for all bamfiles. Thus replace NR in the calculation of the depth (the ``samtools depth`` line above) to get an accurate estimate of the depth.

#### COVERAGE
There is also an easier way to obtain coverage and depth using ``samtools coverage mybamfile.bam``. This [tool](http://www.htslib.org/doc/samtools-coverage.html) can also generate a histogram with the covarage across the genome.

## 2. get the consensus 

``
awk '{print "sbatch 2_ExtractMito.slurm "$2}' 1_AlignMito.param | bash
``

## 3. rename each sequence in the header 

``
for File in 2_MitoConsensus/*.fasta; do
echo $File
Name=`basename -s "_FullMito.fasta" $File`
echo ">"${Name} > 2_MitoConsensus/${Name}_FullMitoRenamed.fasta
tail -n +2 $File >> 2_MitoConsensus/${Name}_FullMitoRenamed.fasta
done
``

## 4. Identify the first and last gene present in the coding region of each mito-consensus (using MITOS)

As MITOS is not develop tobe used in an iMAC, the IT department helped us to create a docker where we could installed the software.
I wrote a script called `3_Mitos_annotation.sh` that allow you access MITOS and run it from your iMAC terminal (as always using a remote access from you own machine).
Right now the script only works for a single sample. Modify it to run a few (a subset of) samples, so you ger familiar with how mitos run and the output youi ger from annotating the mito-genome.

run the 3_Mitos_annotation.sh script as:
``
    bash 3_Mitos_annotation.sh 
``

## 5. Repetitive elements present in the consensus mitogenomes should be removed
You need to index the mitoconsensus fasta file using samtools as:
``
samtools faidx my_mitoconsensus_FullMitoRenamed.fasta
``
Then using the information (genes and repetitive elements coordinates) generated by Mitos, select only the coding regions with samtools as:
``
  samtools faidx my_mitoconsensus_FullMitoRenamed.fasta header:1-250
``
where :1-250 correspond to the coordiantes (start-end) of the region you want to select

## 6. Alignment of all mito-consensus is generated using MATTF

## 7. Build a phylogenetic tree using maximum likelihood, using RAxML
