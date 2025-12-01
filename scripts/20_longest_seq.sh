#!/bin/bash
#SBATCH --job-name=getLongestSeq
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=6:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/20_longest_seq/output_20_longest_seq_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/20_longest_seq/error_20_longest_seq_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end,fail

#this script will filter the naming of the longest seq per gene and remove the -RA, etc

#directories
WORKDIR="/data/users/aikiror/genomeAnnotation"
OUTPUTDIR="$WORKDIR/output/20_longest_seq"

#fasta file to be cleaned
INPUT_FASTA="/data/users/aikiror/genomeAnnotation/output/13_extractLongest/longest_protein_seq_per_gene.fasta"

#make path to outputdir
mkdir -p $OUTPUTDIR

#change path to outputdir
cd $OUTPUTDIR

#load module
module load SeqKit/2.6.1   # if needed

#filter
# seqkit fx2tab -n -s "$INPUT_FASTA" \
# | awk -F'\t' '{
#     name=$1; seq=$2;
#     sub(/[-–]R.*/,"",name);   # drop -RA/-RB etc (handles hyphen or en dash)
#     print ">"name"\n"seq
# }' > cleaned.fasta
sed -E 's/^>([^-]+)-R.*/>\1/' $INPUT_FASTA > cleaned.fasta
# awk 'BEGIN{OFS=" "} /^>/{split($1,a,/-R|–R/); $1=a[1]}1' "$INPUT_FASTA" > cleaned.fasta
