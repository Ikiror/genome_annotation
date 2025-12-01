#!/bin/bash
#SBATCH --job-name=createBedFile
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=4 
#SBATCH --mem=32G
#SBATCH --time=6:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/19_create_bed_file/output_19_create_bed_file_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/19_create_bed_file/error_19_create_bed_file_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end,fail

WORKDIR="/data/users/aikiror/genomeAnnotation"
OUTPUTDIR="$WORKDIR/output/19_create_bed_file"
FILTERED_GFF3=""/data/users/aikiror/genomeAnnotation/output/11_filterGFFfile/filtered.genes.renamed.gff3
Accession="Est0"
BED_FILE="Est0.bed"

mkdir -p $OUTPUTDIR
cd $OUTPUTDIR

#extract gene features from GFF3
grep -P "\tgene\t" $FILTERED_GFF3 > temp_genes.gff3

#format into bed file
awk 'BEGIN{OFS="\t"} {split($9,a,";"); split(a[1],b, "="); print $1, $4-1, $5, b[2]}' temp_genes.gff3 > $BED_FILE
