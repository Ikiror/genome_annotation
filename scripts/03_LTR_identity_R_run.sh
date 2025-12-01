#!/bin/bash
#SBATCH --job-name=clade_separation
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=20 
#SBATCH --mem=64G 
#SBATCH --time=48:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/03_full_length_LTRs_identity/output_LTRs_identity_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/03_full_length_LTRs_identity/error_LTRs_identity_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end

#this script will run the R script that will plot the number of LTR retrotransposons in each clade with their corresponding clade identity
#03_full_length_LTRs_identity.R

#directories
WORKDIR="/data/users/aikiror/genomeAnnotation"
RSCRIPT="${WORKDIR}/scripts/03_full_length_LTRs_identity.R"
OUTPUT_DIR="${WORKDIR}/output/03_LTR_identity_R_run"

#make path to output dir if it doesnt exist
mkdir -p $OUTPUT_DIR

#change location to output dir
cd $OUTPUT_DIR

#load R module
module load R-bundle-CRAN/2023.11-foss-2021a

# Run your R script
Rscript ${RSCRIPT} ${OUTPUT_DIR}
