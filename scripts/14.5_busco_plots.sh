#!/bin/bash
#SBATCH --job-name=extractmRNA
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=4 
#SBATCH --mem=16G
#SBATCH --time=6:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/14.5_busco_plots/output_14.5_busco_plots_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/14.5_busco_plots/error_14.5_busco_plots_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end,fail

#14.5_busco_plots
#plot busco results

#directories
WORKDIR="/data/users/aikiror/genomeAnnotation"
COURSEDIR="${WORKDIR}/CDS_annotation"

#folder already made bc location with all .txt is needed for generate_plot.py
BUSCO_dir="/data/users/aikiror/genomeAnnotation/output/14.5_busco_output"

#mkdir -p $OUTPUTDIR
cd $BUSCO_dir
#load module
module load BUSCO/5.4.2-foss-2021a

generate_plot.py -wd $BUSCO_dir
