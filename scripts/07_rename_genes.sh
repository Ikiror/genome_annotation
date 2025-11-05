#!/bin/bash
#SBATCH --job-name=renameGenes
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=4 
#SBATCH --mem=32G
#SBATCH --time=24:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/07_rename_genes/output_07_rename_genes_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/07_rename_genes/error_07_rename_genes_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end,fail

#this script will rename the genes

#directories
WORKDIR="/data/users/aikiror/genomeAnnotation"
COURSEDIR="${WORKDIR}/CDS_annotation"
OUTPUTDIR="${WORKDIR}/output/07_rename_genes"
UNFILTERED="${WORKDIR}/output/06_MAKER_to_GFF"

#make path to outputdir if it doesnt exist
mkdir -p ${OUTPUTDIR}

#specific location for the final filtered annotations
FINAL_FORM="${OUTPUTDIR}/finalFilteredAnnotations"

#make path to dir if it doesnt exist
mkdir -p ${FINAL_FORM}

#containers/modules/tools
MAKERBIN="${COURSEDIR}/softwares/Maker_v3.01.03/src/bin"
prefix="Est" #3 to 4 letter prefix to your accession


protein="${UNFILTERED}/pacbio_hifi_Est-0.p_ctg.all.maker.proteins.fasta" 
transcript="${UNFILTERED}/pacbio_hifi_Est-0.p_ctg.all.maker.transcripts.fasta"
gff="${UNFILTERED}/pacbio_hifi_Est-0.p_ctg.all.maker.noseq.gff"

#renamed files
RENAMED_GFF="${FINAL_FORM}/$(basename ${gff%.gff}).renamed.gff"
RENAMED_PROT="${FINAL_FORM}/$(basename ${protein%.fasta}).renamed.fasta"
RENAMED_TRANSCRIPT="${FINAL_FORM}/$(basename ${transcript%.fasta}).renamed.fasta"

#copy files to directory
cp ${gff} ${RENAMED_GFF}
cp ${protein} ${RENAMED_PROT}
cp ${transcript} ${RENAMED_TRANSCRIPT}

#change dir
cd ${FINAL_FORM}

#To assign clean, consistent IDs to the gene models, use MAKERʼs ID mapping tools
#update gff and fasta files; ensure that all gene models have consistent, clean IDs
${MAKERBIN}/maker_map_ids --prefix ${prefix} --justify 7 ${RENAMED_GFF} > id.map
${MAKERBIN}/map_gff_ids id.map ${RENAMED_GFF}
${MAKERBIN}/map_fasta_ids id.map ${RENAMED_PROT}
${MAKERBIN}/map_fasta_ids id.map ${RENAMED_TRANSCRIPT}