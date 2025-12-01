#!/bin/bash
#SBATCH --job-name=extractmRNA
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=4 
#SBATCH --mem=16G
#SBATCH --time=6:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/14_BUSCO/output_14_BUSCO_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/14_BUSCO/error_14_BUSCO_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end,fail

#this script will run busco to assess genome or annotation completeness

#directories
WORKDIR="/data/users/aikiror/genomeAnnotation"
OUTPUTDIR="${WORKDIR}/output/14_BUSCO"
COURSEDIR="${WORKDIR}/CDS_annotation"

#path to the longest seq per gene
LONGEST_PROTEIN="/data/users/aikiror/genomeAnnotation/output/13_extractLongest/longest_protein_seq_per_gene.fasta"
LONGEST_TRANSCRIPT="/data/users/aikiror/genomeAnnotation/output/13_extractLongest/longest_transcript_seq_per_gene.fasta"
TRINITY_FASTA="/data/users/aikiror/genomeAnnotation/assemblyData/04_trinity.Trinity.fasta"

#make path to outputdir
mkdir -p $OUTPUTDIR

#change dir
cd $OUTPUTDIR

#load module
module load BUSCO/5.4.2-foss-2021a

#add to output file name to avoid overwriting
busco -i $LONGEST_PROTEIN -l brassicales_odb10 -o busco_output_proteins -m proteins
busco -i $LONGEST_TRANSCRIPT -l brassicales_odb10 -o busco_output_transciptome -m transcriptome
busco -i $TRINITY_FASTA -l brassicales_odb10 -o busco_output_trinity -m transcriptome