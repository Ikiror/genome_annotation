#!/bin/bash
#SBATCH --job-name=processPangenome
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=20 
#SBATCH --mem=32G 
#SBATCH --time=24:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/23_process_pangenomeRun/output_23_process_pangenomeRun_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/23_process_pangenomeRun/error_23_process_pangenomeRun_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end

#23_process_pangenomeRun

WORKDIR="/data/users/aikiror/genomeAnnotation"
RSCRIPT="/data/users/aikiror/genomeAnnotation/scripts/process_pangenome.R"
OUTPUT_DIR="${WORKDIR}/output/23_process_pangenomeRun"

mkdir -p $OUTPUT_DIR

#change location to output dir
cd $OUTPUT_DIR

#load R module
module load R-bundle-IBU/2023121400-foss-2021a-R-4.3.2

# Run your R script
Rscript ${RSCRIPT} 
