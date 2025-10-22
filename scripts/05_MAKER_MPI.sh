#!/bin/bash
#SBATCH --job-name=MPI
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=4 
#SBATCH --mem=120G 
#SBATCH --nodes=1
#SBATCH --time=7-0
#SBATCH --ntasks-per-node=50
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/05_MAKER_MPI/output_05_MAKER_MPI_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/05_MAKER_MPI/error_05_MAKER_MPI_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end

#directories
WORKDIR="/data/users/aikiror/genomeAnnotation"
COURSEDIR="${WORKDIR}/CDS_annotation"
REPEATMASKER_DIR="${COURSEDIR}/softwares/RepeatMasker"
MAKER_FOLDER="${WORKDIR}/output/04_MAKER_control"

export PATH=$PATH:${REPEATMASKER_DIR}

OUTPUT_DIR="${WORKDIR}/05_MAKER_MPI"

#make path to outdir if it doesnt exist
mkdir -p $OUTPUT_DIR

#load modules
module load OpenMPI/4.1.1-GCC-10.3.0
module load AUGUSTUS/3.4.0-foss-2021a

mpiexec --oversubscribe -n 50 apptainer exec \
    --bind $SCRATCH:/TMP --bind $COURSEDIR --bind $AUGUSTUS_CONFIG_PATH --bind $REPEATMASKER_DIR \
    ${COURSEDIR}/containers/MAKER_3.01.03.sif \
    maker -mpi --ignore_nfs_tmp -TMP /TMP ${MAKER_FOLDER}/maker_opts.ctl ${MAKER_FOLDER}/maker_bopts.ctl \
    ${MAKER_FOLDER}/maker_evm.ctl ${MAKER_FOLDER}/maker_exe.ctl


