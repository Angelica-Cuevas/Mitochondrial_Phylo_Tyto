#!/bin/sh -l
#SBATCH --account=jgoudet_barn_owl
#SBATCH --job-name=mafft

# Wall clock limit (hh:mm:ss):
#SBATCH --time=12:00:00

# Processor and memory usage:
#SBATCH --output=slurm-%j.base
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=8G
#SBATCH --partition=bigmem

# notify end of job
#SBATCH --mail-user=apulido@unil.ch
#SBATCH --mail-type=FAIL
#SBATCH --mail-type=END

# module purge
module load MAFFT/7.490-GCC-10.3.0-with-extensions


# run this script as:
#    for i in $(cat sample_list_mitos.2nd.run.txt); do
#    sbatch G.Mitos_cox1_fixstart.sh ${i}
#    done

INPUT=/cluster/work/users/angelimc/Bryozoa/project1_mitogenomes_ribosome/Genes_for_Alignments
OUTPUT=/cluster/work/users/angelimc/Bryozoa/project1_mitogenomes_ribosome/Alignments
previous_align=/cluster/work/users/angelimc/Bryozoa/project1_mitogenomes_ribosome/Alignments/published_alignments
List=/cluster/work/users/angelimc/Bryozoa/Scripts

##*******************************************##
## protein-coding genes - nucleotide format
##*******************************************##
for gene in $(cat ${List}/genes_published.txt) ; do

mafft --auto --add ${INPUT}/AminoAcid/${gene}_all_Samples_copy.faa --reorder ${previous_align}/${gene}.fas > ${OUTPUT}/${gene}_added.samples_alignment.faa

done

#
# Strategy:
#  FFT-NS-2 (Fast but rough)
#  Progressive method (guide trees were built 2 times.)
#  
# If unsure which option to use, try 'mafft --auto input > output'.
# For more information, see 'mafft --help', 'mafft --man' and the mafft page.
# 
# The default gap scoring scheme has been changed in version 7.110 (2013 Oct).
# It tends to insert more gaps into gap-rich regions than previous versions.
# To disable this change, add the --leavegappyregion option.

