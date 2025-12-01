#!/bin/bash
#SBATCH --job-name=genespaceRun
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=4 
#SBATCH --mem=32G
#SBATCH --time=6:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/22_genespaceRun/output_22_genespaceRun_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/22_genespaceRun/error_22_genespaceRun_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end,fail

#22_genespaceRun
WORKDIR="/data/users/aikiror/genomeAnnotation"
COURSEDIR="$WORKDIR/CDS_annotation"
OUTPUTDIR="/data/users/aikiror/genomeAnnotation/output/22_genespaceRun"
GENESPACEDIR="$WORKDIR/output/19_create_bed_file/genespace_workingDir"
CONTAINER="$COURSEDIR/containers/genespace_latest.sif"
genespaceRscript="$WORKDIR/scripts/genespace.R"

mkdir -p $OUTPUTDIR

cd $OUTPUTDIR

apptainer exec --bind $COURSEDIR --bind $WORKDIR --bind $SCRATCH:/temp $CONTAINER Rscript $genespaceRscript $GENESPACEDIR
