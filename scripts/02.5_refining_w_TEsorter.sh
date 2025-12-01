#!/bin/bash
#SBATCH --job-name=TEclassification
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=20 
#SBATCH --mem=64G 
#SBATCH --time=48:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/02.5_refining_w_TEsorter/output_02.5_refining_w_TEsorter_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/02.5_refining_w_TEsorter/error_02.5_refining_w_TEsorter_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end

#02.5_refining_w_TEsorter

#directories
WORKDIR="/data/users/aikiror/genomeAnnotation"
OUTPUT_DIR="${WORKDIR}/output/02.5_refining_w_TEsorter"
INPUT="$WORKDIR/output/01.6_EDTA/pacbio_hifi_Est-0.p_ctg.fa.mod.EDTA.TElib.fa"

#path to container (TE-sorter) 
CONTAINER="/data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif"

module load SeqKit/2.6.1
#make path to output dir if it doesnt exist
mkdir -p ${OUTPUT_DIR}

#change working dir to output dir
cd "$OUTPUT_DIR"


#Extract Sequences
# Extract Copia sequences
seqkit grep -r -p "Copia" $INPUT > Copia_sequences.fa
# Extract Gypsy sequences
seqkit grep -r -p "Gypsy" $INPUT > Gypsy_sequences.fa

#Run TEsorter
apptainer exec --bind $WORKDIR $CONTAINER TEsorter \
    Copia_sequences.fa -db rexdb-plant

apptainer exec --bind $WORKDIR $CONTAINER TEsorter \
    Gypsy_sequences.fa -db rexdb-plant