#!/bin/bash
#SBATCH --job-name=InterProScan
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=4 
#SBATCH --mem=32G
#SBATCH --time=6:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/08_InterProScan/output_08_InterProScan_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/08_InterProScan/error_08_InterProScan_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end,fail

#this script will annotate the protein sequences with functional domains

#directories
WORKDIR="/data/users/aikiror/genomeAnnotation/"
OUTPUTDIR="${WORKDIR}/output/08_InterProScan"
COURSEDIR="${WORKDIR}/CDS_annotation"

#data and container path
INTERPROSCAN_DATA="${COURSEDIR}/data/interproscan-5.70-102.0/data:/opt/interproscan/data"
CONTAINER="$COURSEDIR/containers/interproscan_latest.sif"

PROTEIN_FASTA="/data/users/aikiror/genomeAnnotation/output/07_rename_genes/finalFilteredAnnotations/pacbio_hifi_Est-0.p_ctg.all.maker.proteins.renamed.fasta"

#make path to output if it doesnt exist
mkdir -p ${OUTPUTDIR}

#change locations to outputdir
cd ${OUTPUTDIR}

#run 
apptainer exec \
    --bind $INTERPROSCAN_DATA \
    --bind $WORKDIR \
    --bind $COURSEDIR \
    --bind $SCRATCH:/temp \
    $CONTAINER \
    /opt/interproscan/interproscan.sh \
    -appl pfam --disable-precalc -f TSV \
    --goterms --iprlookup --seqtype p \
    -i $PROTEIN_FASTA -o output.iprscan