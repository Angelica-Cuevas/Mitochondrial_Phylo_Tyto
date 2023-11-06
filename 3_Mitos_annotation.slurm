#! /bin/bash

#SBATCH -p cpu
#SBATCH --time=05:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --job-name=mitos
#SBATCH -e TEMP/%x_%A_%a.stderr
#SBATCH -o TEMP/%x_%A_%a.stdout
#SBATCH --account jgoudet_barn_owl

module purge

module load singularity
export SINGULARITY_BINDPATH="/scratch,/users,/work"


# run this script as:
#    for i in $(cat 1_samples_list.param); do
#    sbatch 3_Mitos_annotation.slurm ${i}
#    done


INPUT=/work/FAC/FBM/DEE/jgoudet/barn_owl/Common/museum/2_MitoGenome/2_MitoConsensus
OUTPUT1=/work/FAC/FBM/DEE/jgoudet/barn_owl/Common/museum/2_MitoGenome/3_MITOS_annotation


# # the ref genome folder was downloaded from Zenobo for MITOS2: https://zenodo.org/record/4284483#.Y2O6jC2ZPUI
REF=/work/FAC/FBM/DEE/jgoudet/barn_owl/Common/museum/2_MitoGenome/3_MITOS_annotation/refseq89m


# I need to create subdirectory for each sample, because as far as I can see I can't independently add the sampleID to the output files

sample_MT="$(echo ${1})"

mkdir ${OUTPUT1}/${sample_MT}

OUTPUT2=${OUTPUT1}/${sample_MT}

singularity run /dcsrsoft/singularity/containers/mitos-2.1.3.sif runmitos.py -i ${INPUT}/${sample_MT}_FullMitoRenamed.fasta \
 --linear -c 05 --best --refdir refseq89m -r ${REF} -o ${OUTPUT2}

#Russell comment:
##Mitos table gives wrong placement for first nucleotide so need to move forward 1: 
##awk 'BEGIN {FS="\t"} {if($1 ~ ">") {print} else {if($1 >=0) $1=$1+1; if($2 >=0)$2=$2+1; print}}' 1134.tb
# However I'm unsure how to interpret this!!!!


#modify file name to include Sample_ID

cd ${OUTPUT2}
for ext in mitos seq gff geneorder fas faa bed; do
mv result.${ext} "$sample_MT"_MITOS.result.${ext}
done