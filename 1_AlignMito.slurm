#!/bin/bash
#SBATCH --partition cpu
#SBATCH --time=15:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=15
#SBATCH --mem=50G
#SBATCH --job-name=map
#SBATCH --account jgoudet_barn_owl
#SBATCH -e TEMP/%A.stderr
#SBATCH -o TEMP/%A.stdout

set -x

##############################################################
#
#   awk '{print "sbatch 1_AlignMito.slurm "$0}' 1_AlignMito.param | bash
#
##############################################################

# Source usefull modules
module load gcc bwa samtools
module load picard/2.26.2
module load openjdk qualimap

myPATH=/work/FAC/FBM/DEE/jgoudet/barn_owl/Common/museum/1_Reads2Bam/
outPATH=/work/FAC/FBM/DEE/jgoudet/barn_owl/Common/museum/2_MitoGenome/

my_sample=$1

mkdir  ${outPATH}/1_Map/

# Input Files Mapping
in_forward=${myPATH}/1_Trim/"$my_sample"_R1_paired.fq.gz
in_reverse=${myPATH}/1_Trim/"$my_sample"_R2_paired.fq.gz

assembled=${myPATH}/1_Trim/"$my_sample".assembledTrim.fq.gz

in_UF_forward=${myPATH}/1_Trim/"$my_sample"_R1_unpaired.fq.gz
in_UR_reverse=${myPATH}/1_Trim/"$my_sample"_R2_unpaired.fq.gz

ref='/work/FAC/FBM/DEE/jgoudet/barn_owl/Common/museum/2_MitoGenome/0_DATA/MitoOneCopy/RefMito_TytoAlba_DupliOneCopy.fasta'

#### 0 change the prefix name for output_files
# prefix=$(grep "$my_sample" 1_AlignMito.param | awk -F" " '{print $2}')
prefix=$2

# Output Files
PEmapped=${outPATH}/1_Map/"$prefix"_PE_mapped.bam
SEmapped=${outPATH}/1_Map/"$prefix"_SE_mapped.bam

UPF_mapped=${outPATH}/1_Map/"$prefix"_UPF_mapped.bam
UPR_mapped=${outPATH}/1_Map/"$prefix"_UPR_mapped.bam

mapped=${outPATH}/1_Map/"$prefix"_mapped.bam
marked=${outPATH}/1_Map/"$prefix"_marked.bam

#### 1 Mapping
# 1.1 PE reads
bwa mem -M -t 15 -R $(echo "@RG\tID:PE_$prefix\tSM:$prefix\tLB:$prefix\tPL:ILLUMINA") $ref $in_forward $in_reverse | samtools sort -@ 15 -O bam -o $PEmapped -

# 1.2 Assembled reads
bwa mem -M -t 15 -R $(echo "@RG\tID:SE_$prefix\tSM:$prefix\tLB:$prefix\tPL:ILLUMINA") $ref $assembled | samtools sort -@ 15 -O bam -o $SEmapped -

# 1.3 Unpaired, forward and reverse
bwa mem -M -t 15 -R $(echo "@RG\tID:UF_$prefix\tSM:$prefix\tLB:$prefix\tPL:ILLUMINA") $ref $in_UF_forward | samtools sort -@ 15 -O bam -o $UPF_mapped -
bwa mem -M -t 15 -R $(echo "@RG\tID:UR_$prefix\tSM:$prefix\tLB:$prefix\tPL:ILLUMINA") $ref $in_UR_reverse | samtools sort -@ 15 -O bam -o $UPR_mapped -

# Merge the bamfiles
samtools merge -f -@ 15 -o $mapped $PEmapped $SEmapped $UPF_mapped $UPR_mapped
samtools index $mapped

##### 2 Mark duplicates
# picard MarkDuplicates -I ${mapped} -O ${marked} -M ${myPATH}/2_Map/"$prefix"_marked.stat
# samtools index ${marked}

##### 3 Get quality of the bam
# mkdir ${myPATH}/2_Map/"$prefix"_qualimap
# qualimap bamqc -sd -c -bam ${marked} \
#               -outdir ${myPATH}/2_Map/"$prefix"_qualimap \
#               -outfile ${myPATH}/2_Map/"$prefix"_qualimap/"$prefix".qualimap \
#               -outformat PDF:HTML --java-mem-size=10G \
#                -nt 15

#### 4 Clean the mess
rm $PEmapped $SEmapped
rm $UPF_mapped  $UPR_mapped
