#!/bin/bash
#SBATCH --job-name=TE_vis
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=20 
#SBATCH --mem=32G 
#SBATCH --time=24:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/09_TE_visualization_R_run/output_09_TE_visualization_R_run_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/09_TE_visualization_R_run/error_09_TE_visualization_R_run_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end

WORKDIR="/data/users/aikiror/genomeAnnotation"
RSCRIPT="/data/users/aikiror/genomeAnnotation/scripts/09_TE_annotation_03-annotation_circlize.R"
OUTPUT_DIR="${WORKDIR}/output/09_TE_visualization_R_run_alt_lgd"

mkdir -p $OUTPUT_DIR

#change location to output dir
cd $OUTPUT_DIR

#load R module
module load R-bundle-IBU/2023121400-foss-2021a-R-4.3.2

# Run your R script
Rscript ${RSCRIPT} ${OUTPUT_DIR}
