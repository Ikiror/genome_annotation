#!/bin/bash
#SBATCH --job-name=MAKER
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=4 
#SBATCH --mem=8G 
#SBATCH --time=12:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/04_MAKER_control/output_04_MAKER_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/04_MAKER_control/error_04_MAKER_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end

#directories
WORKDIR="/data/users/aikiror/genomeAnnotation"
OUTPUT_DIR="${WORKDIR}/04_MAKER_control"

#make path to outdir if it doesnt exist
mkdir -p $OUTPUT_DIR

#change path to outdir
cd "$OUTPUT_DIR"

CONTAINER="/data/courses/assembly-annotation-course/CDS_annotation/containers/MAKER_3.01.03.sif"

apptainer exec --bind ${WORKDIR} ${CONTAINER} maker -CTL
