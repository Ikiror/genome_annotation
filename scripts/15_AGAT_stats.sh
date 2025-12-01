#!/bin/bash
#SBATCH --job-name=AGATstats
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=4 
#SBATCH --mem=16G
#SBATCH --time=6:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/15_AGAT_stats/output_15_AGAT_stats_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/15_AGAT_stats/error_15_AGAT_stats_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end,fail

#This script runs AGAT to generate stats about the performed gene annot.

#directories
WORKDIR="/data/users/aikiror/genomeAnnotation"
CONTAINER="/containers/apptainer/agat-1.2.0.sif"
OUTPUTDIR="$WORKDIR/output/15_AGAT_stats"

#make path to outputdir
mkdir -p $OUTPUTDIR

#path to filtered gff
FILTERED_GFF="$WORKDIR/output/11_filterGFFfile/filtered.genes.renamed.gff3"

#change dir
cd $OUTPUTDIR

#run agat
apptainer exec --bind /data/ $CONTAINER agat_sp_statistics.pl -i $FILTERED_GFF -o annotation.stat