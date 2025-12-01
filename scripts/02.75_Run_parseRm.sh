#!/bin/bash
#SBATCH --job-name=parseRM_run
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=20 
#SBATCH --mem=32G 
#SBATCH --time=24:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/02.75_Run_parseRm/output_02.75_Run_parseRm_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/02.75_Run_parseRm/error_02.75_Run_parseRm_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end

#this script will help with the TE age estimation workflow
#this will run the R script that'll process the raw alignement outputs from RepeatMasker - calcs the corrected % of divergenece of each TE copy from its consensus seq
#02.75_Run_parseRm

#directories
WORKDIR="/data/users/aikiror/genomeAnnotation"
OUTPUT_DIR="${WORKDIR}/output/02.75_Run_parseRm"
INPUT="$WORKDIR/output/01.6_EDTA/pacbio_hifi_Est-0.p_ctg.fa.mod.EDTA.anno/pacbio_hifi_Est-0.p_ctg.fa.mod.out"

PERL_SCRIPT="$WORKDIR/scripts/02.75_parseRM.pl"

#make path to output dir if it doesnt exist
mkdir -p $OUTPUT_DIR

#change location to output dir
cd $OUTPUT_DIR

#load perl module
module add BioPerl/1.7.8-GCCcore-10.3.0

#run perl - parsing and binning divergence data
perl $PERL_SCRIPT -i $INPUT -l 50,1 -v