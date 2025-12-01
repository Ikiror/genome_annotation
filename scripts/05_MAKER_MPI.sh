#!/bin/bash
#SBATCH --job-name=MPI
#SBATCH --partition=pibu_el8 
#SBATCH --mem=120G 
#SBATCH --nodes=1
#SBATCH --time=7-0
#SBATCH --ntasks-per-node=50
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/05_MAKER_MPI/output_05_MAKER_MPI_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/05_MAKER_MPI/error_05_MAKER_MPI_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end

#run MAKER w MPI
#directories
WORKDIR="/data/users/aikiror/genomeAnnotation/output/04_MAKER_control"
COURSEDIR="/data/users/aikiror/genomeAnnotation/CDS_annotation"
OUTPUT_DIR="/data/users/aikiror/genomeAnnotation/output/05_MAKER_MPI"

#make output dir path if the path doesnt exist
mkdir -p "${OUTPUT_DIR}"

#change into outputdir path
cd ${OUTPUT_DIR}

#location of the repeatmasker
REPEATMASKER_DIR="/data/users/aikiror/genomeAnnotation/CDS_annotation/softwares/RepeatMasker"

#make path available
export PATH=$PATH:"/data/users/aikiror/genomeAnnotation/CDS_annotation/softwares/RepeatMasker"

#load modules
module load OpenMPI/4.1.1-GCC-10.3.0
module load AUGUSTUS/3.4.0-foss-2021a

#run
mpiexec --oversubscribe -n 50 apptainer exec \
    --bind $SCRATCH:/TMP --bind $COURSEDIR --bind /data --bind $AUGUSTUS_CONFIG_PATH --bind $REPEATMASKER_DIR \
    ${COURSEDIR}/containers/MAKER_3.01.03.sif \
    maker -mpi --ignore_nfs_tmp -TMP /TMP ${WORKDIR}/maker_opts.ctl ${WORKDIR}/maker_bopts.ctl ${WORKDIR}/maker_evm.ctl ${WORKDIR}/maker_exe.ctl
