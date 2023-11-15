#! /bin/bash

consensus_dir=//mitos/2_MitoConsensus
my_sample=T.alb.aff.ZA_F289_UNL_174002_P001_WC11_i5-510_i7-131_S2453

# # the ref genome folder was downloaded from Zenobo for MITOS2: https://zenodo.org/record/4284483#.Y2O6jC2ZPUI
REF=/mitos/3_Mitos_trial

# Mitos result folder for this trial
OUTPUT1=/mitos/3_Mitos_trial

# You need to create a subdirectory for each sample, later we would rename the output files adding the corresponding sampleID

for i in $my_sample ; do
echo "creating outputfolder for ... " ${i}
sample_ID="$(echo ${i})"

Out_sample=/Users/Shared/MitoGenome_museum/3_Mitos_trial/
mkdir ${Out_sample}/${sample_ID}

OUTPUT2=${OUTPUT1}/${sample_ID}

echo "running mitos for ... " ${i}
docker exec -it elastic_hodgkin runmitos.py \
-i $consensus_dir/${sample_ID}_FullMitoRenamed.fasta \
--linear -c 05 --best \
--refdir $REF  \
-r $REF/refseq89m  \
-o $OUTPUT2
echo "annotation done"

# modify file name to include Sample_ID
# the OUTPUT folder need to be redefined as we're not using the docker for MITOS anymore:

echo "naming output files"

OUTPUT3=/Users/Shared/MitoGenome_museum/3_Mitos_trial/${sample_ID}

cd ${OUTPUT3}
for ext in mitos seq gff geneorder fas faa bed; do
mv result.${ext} "$sample_ID"_MITOS.result.${ext}

echo "done"

done
done
