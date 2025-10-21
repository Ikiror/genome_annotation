#!/bin/bash
#SBATCH --job-name=clade_separation
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=20 
#SBATCH --mem=64G 
#SBATCH --time=48:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/02_clade_separation/output_cladeSeparation_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/02_clade_separation/error_cladeSeparation_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end

#directories
WORKDIR="/data/users/aikiror/genomeAnnotation"
OUTPUT_DIR="${WORKDIR}/output/02_clade_separation"

#make path to output dir if it doesnt exist
mkdir -p ${OUTPUT_DIR}

#path to container (TE-sorter) 
CONTAINER="/data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif"

#change working dir to output dir if cant specify in command
cd "$OUTPUT_DIR"

#change file path to match actual output
# % identity of two LTRs from full length LTRs-RTs
#fasta file
INPUT="${WORKDIR}/output/01_EDTA/pacbio_hifi_Est-0.p_ctg.fa.mod.EDTA.raw/pacbio_hifi_Est-0.p_ctg.fa.mod.LTR.raw.fa"

assembly.fasta.mod.EDTA.raw/assembly.fasta.mod.LTR.raw.fa
#split full length LTR-RTs (long terminal repeat retro transposon) into clades
apptainer exec --bind /data/ ${CONTAINER} TEsorter ${INPUT} -db rexdb-plant

#srun -p pibu_el8 apptainer exec /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif TEsorter --help