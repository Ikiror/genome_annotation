#!/bin/bash
#SBATCH --job-name=plotDiv_run
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=20 
#SBATCH --mem=32G 
#SBATCH --time=24:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/02.85_run_plot_divergenece/output_02.85_run_plot_divergenece_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/02.85_run_plot_divergenece/error_02.85_run_plot_divergenece_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end

#02.85_run_plot_divergenece

WORKDIR="/data/users/aikiror/genomeAnnotation"
OUTPUT_DIR="${WORKDIR}/output/02.85_run_plot_divergenece"
RSCRIPT="$WORKDIR/scripts/02.85_plot_div.R"

mkdir -p $OUTPUT_DIR

#change location to output dir
cd $OUTPUT_DIR

#load R module
module load R-bundle-IBU/2023121400-foss-2021a-R-4.3.2

# Run your R script - visualize divergence of TEs across genome
Rscript ${RSCRIPT} 