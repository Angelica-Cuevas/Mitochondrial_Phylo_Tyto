#!/bin/bash

# this script will:

# 1. index all mitoconsensus (we have one mitoconsensus per individual)
# 2. identify the position of the last basepair of the gene trnE
# 		this is the last gene of the coding region in the mitogenome
#		This info comes from the results of MITOS (annotation software)
# 3. select the coding region of the mitogenome by cutting and extracting the sequence 
#		before(including) the last basepair of the gene trnE


OUTPUT_DIR=/Users/Shared/MitoGenome_museum/4_coding.region_seq

# 1. indexing mitogenomes:

consensus_dir=/Users/Shared/MitoGenome_museum/2_MitoConsensus
samples_list=/Users/Shared/MitoGenome_museum/1_samples_list.param

cd $consensus_dir

for i in $(cat $samples_list) ; do
echo "indexing ... " ${i}
samtools faidx ${i}_FullMitoRenamed.fasta
done


# 2. identify the position of the last basepair of the gene trnE

mito_dir=/Users/Shared/MitoGenome_museum/3_MITOS_annotation_RESULTS

cd $mito_dir

for i in $(cat $samples_list) ; do
basedpair=$(grep "trnE"  $mito_dir/${i}_MITOS.result.bed | cut -f 3)

echo "last basepair for ... " ${i} " is " $basedpair

# 3. extract the coding region (from 1st base pair to the last basepair of gene trnE)

cd $OUTPUT_DIR

echo "extarcting coding region for ... " ${i}

samtools faidx $consensus_dir/${i}_FullMitoRenamed.fasta ${i}:1-$basedpair > ${i}_CD.fasta

done

echo "done"
