#!/bin/bash
#SBATCH --job-name=extractmRNA
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=4 
#SBATCH --mem=16G
#SBATCH --time=6:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/12_extract_mRNA/output_12_extract_mRNA_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/12_extract_mRNA/error_12_extract_mRNA_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end,fail

#extract mRNA seq; filter fasta file
WORKDIR="/data/users/aikiror/genomeAnnotation"
OUTPUTDIR="${WORKDIR}/output/12_extract_mRNA"
COURSEDIR="${WORKDIR}/CDS_annotation"

RENAMED_TRANSCRIPT="$WORKDIR/output/07_rename_genes/finalFilteredAnnotations/pacbio_hifi_Est-0.p_ctg.all.maker.transcripts.renamed.fasta"
RENAMED_PROTEIN="$WORKDIR/output/07_rename_genes/finalFilteredAnnotations/pacbio_hifi_Est-0.p_ctg.all.maker.proteins.renamed.fasta"
FILTERED_GFF="/data/users/aikiror/genomeAnnotation/output/11_filterGFFfile/filtered.genes.renamed.gff3"
transcriptPrefix="pacbio_hifi_Est-0.p_ctg.all.maker.transcripts"
proteinPrefix="pacbio_hifi_Est-0.p_ctg.all.maker.proteins"

mkdir -p $OUTPUTDIR

cd $OUTPUTDIR

#load module
module load UCSC-Utils/448-foss-2021a
module load MariaDB/10.6.4-GCC-10.3.0

grep -P "\tmRNA\t" $FILTERED_GFF | awk '{print $9}' | cut -d ';' -f1 | sed 's/ID=//g' > list.txt

faSomeRecords $RENAMED_TRANSCRIPT list.txt ${transcriptPrefix}.renamed.filtered.fasta
faSomeRecords $RENAMED_PROTEIN list.txt ${proteinPrefix}.renamed.filtered.fasta