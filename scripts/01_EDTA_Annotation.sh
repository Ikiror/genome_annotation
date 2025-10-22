#!/bin/bash
#SBATCH --job-name=EDTA.5 
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=20 
#SBATCH --mem=64G 
#SBATCH --time=48:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/01.6_EDTA/output_EDTA_01.6_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/01.6_EDTA/error_EDTA_01.6_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end

#this script will run EDTA and perfrom annotation on an assembly

#directories
WORKDIR=/data/users/aikiror/genomeAnnotation
OUTPUT_DIR="${WORKDIR}/output/01.6_EDTA"

#path to container (EDTA)
CONTAINER="/data/courses/assembly-annotation-course/CDS_annotation/containers/EDTA2.2.sif"

#first run indicates java command couldnt be found
JAVA_HOME="/srv/ss/sib/ibu/rocky8/2023072800/software/Java/18.0.2.1"

#make path to outdir if it doesnt exist
mkdir -p $OUTPUT_DIR

#change path to outdir
cd "$OUTPUT_DIR"

#fasta file
INPUT_FASTA="${WORKDIR}/assemblyData/pacbio_hifi_Est-0.p_ctg.fa"

#CDS annotation
CDS_annotation="/data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10_cds_20110103_representative_gene_model_updated"

apptainer exec --bind /data,${JAVA_HOME}:${JAVA_HOME} \
    --env JAVA_HOME=${JAVA_HOME} \
    --env PATH="/opt/conda/envs/EDTA/bin:/usr/local/bin:/usr/bin:/bin:${JAVA_HOME}/bin" \
    ${CONTAINER} \
    /opt/conda/envs/EDTA/bin/EDTA.pl \
    --genome ${INPUT_FASTA} --species others --step all \
    --sensitive 1 \
    --cds ${CDS_annotation} \
    --anno 1 \
    --threads 20 \
    --overwrite 1

#make data visible to the container
#link java path to the same path and make visible to the container

#if error is killed for more than 30 minutes,increase memory
#killed indicates that there is a particular sequence it is trying to work through thats 
#giving it lots of trouble and it elected to stop working on that and move on to the next
