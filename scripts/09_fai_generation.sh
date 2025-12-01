#!/bin/bash
#SBATCH --job-name=faiGen
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=4 
#SBATCH --mem=32G
#SBATCH --time=12:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/09_fai_generation/output_09_fai_generation_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/09_fai_generation/error_09_fai_generation_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end,fail

#this script will generate the fasta index 

#directories
WORKDIR="/data/users/aikiror/genomeAnnotation"
OUTPUTDIR=/data/users/aikiror/genomeAnnotation/assemblyData
FASTA="/data/users/aikiror/genomeAnnotation/assemblyData/pacbio_hifi_Est-0.p_ctg.fa"

#load module
module load SAMtools/1.13-GCC-10.3.0

#change directories
cd $OUTPUTDIR

samtools faidx ${FASTA}
