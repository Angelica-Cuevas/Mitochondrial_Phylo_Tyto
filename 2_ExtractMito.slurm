#! /bin/bash

#SBATCH -p cpu
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --job-name=AlignOwl
#SBATCH -e TEMP/%j_stderr
#SBATCH -o TEMP/%j_stdout
#SBATCH --account jgoudet_barn_owl

NbThreads=10

##########################################
#
#  awk '{print "sbatch 2_ExtractMito.slurm "$2}' 1_AlignMito.param | bash
#
#########################################

module load gcc bcftools htslib

outPATH=/work/FAC/FBM/DEE/jgoudet/barn_owl/Common/museum/2_MitoGenome/
mkdir ${outPATH}/2_MitoConsensus/

IndName=$1
Ref='/work/FAC/FBM/DEE/jgoudet/barn_owl/Common/museum/2_MitoGenome/0_DATA/MitoOneCopy/RefMito_TytoAlba_DupliOneCopy.fasta'

echo ${IndName}

bcftools mpileup --ignore-RG -A -m 250 --min-MQ 60 --max-depth 5000 -L 50000 -f $Ref  ${outPATH}/1_Map/${IndName}_mapped.bam | bcftools call -c --ploidy 1 | bgzip -c > ${outPATH}/2_MitoConsensus/${IndName}.vcf.gz
tabix ${outPATH}/2_MitoConsensus/${IndName}.vcf.gz
cat $Ref | bcftools consensus ${outPATH}/2_MitoConsensus/${IndName}.vcf.gz > ${outPATH}/2_MitoConsensus/${IndName}_FullMito.fasta



