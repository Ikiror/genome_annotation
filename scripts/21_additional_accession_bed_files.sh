#!/bin/bash
#SBATCH --job-name=createBedFile
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=4 
#SBATCH --mem=32G
#SBATCH --time=6:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/21_additional_accession_bed_files/output_21_additional_accession_bed_files_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/21_additional_accession_bed_files/error_21_additional_accession_bed_files_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end,fail

#this script will generate the bed files of the additional accessions
#21_additional_accession_bed_files

WORKDIR="/data/users/aikiror/genomeAnnotation"
OUTPUTDIR="$WORKDIR/output/21_additional_accession_bed_files"
BED_DIR="$WORKDIR/output/19_create_bed_file/genespace_workingDir/bed"
FILTERED_GFF3="$WORKDIR/output/11_filterGFFfile/filtered.genes.renamed.gff3"

#Accession names
Are_6_Accession="Are-6"
Ice_1_Accession="Ice-1"
Taz_0_Accession="Taz-0"

#path to gffs
Are_6GFF="/data/users/aikiror/genomeAnnotation/CDS_annotation/data/Lian_et_al/gene_gff/selected/Are-6.EVM.v3.5.ann.protein_coding_genes.gff"
Ice_1GFF="/data/users/aikiror/genomeAnnotation/CDS_annotation/data/Lian_et_al/gene_gff/selected/Ice-1.EVM.v3.5.ann.protein_coding_genes.gff"
Taz_0GFF="/data/users/aikiror/genomeAnnotation/CDS_annotation/data/Lian_et_al/gene_gff/selected/Taz-0.EVM.v3.5.ann.protein_coding_genes.gff"

#make dir to outputdir and change dir
mkdir -p $OUTPUTDIR
cd $OUTPUTDIR

#Are-6
#extract gene features from GFF3
grep -P "\tgene\t" ${Are_6GFF} > ${Are_6_Accession}_temp_genes.gff3
#format into bed file
awk 'BEGIN{OFS="\t"} {split($9,a,";"); split(a[1],b, "="); print $1, $4-1, $5, b[2]}' ${Are_6_Accession}_temp_genes.gff3 > ${Are_6_Accession}.bed

#Ice-1
#extract gene features from GFF3
grep -P "\tgene\t" ${Ice_1GFF} > ${Ice_1_Accession}_temp_genes.gff3
#format into bed file
awk 'BEGIN{OFS="\t"} {split($9,a,";"); split(a[1],b, "="); print $1, $4-1, $5, b[2]}' ${Ice_1_Accession}_temp_genes.gff3 > ${Ice_1_Accession}.bed

#Taz_0
#extract gene features from GFF3
grep -P "\tgene\t" ${Taz_0GFF} > ${Taz_0_Accession}_temp_genes.gff3
#format into bed file
awk 'BEGIN{OFS="\t"} {split($9,a,";"); split(a[1],b, "="); print $1, $4-1, $5, b[2]}' ${Taz_0_Accession}_temp_genes.gff3 > ${Taz_0_Accession}.bed

#copy bed file to genespace working dir
cp $OUTPUTDIR/${Taz_0_Accession}.bed $BED_DIR/${Taz_0_Accession}.bed
cp $OUTPUTDIR/${Ice_1_Accession}.bed $BED_DIR/${Ice_1_Accession}.bed
cp $OUTPUTDIR/${Are_6_Accession}.bed $BED_DIR/${Are_6_Accession}.bed
