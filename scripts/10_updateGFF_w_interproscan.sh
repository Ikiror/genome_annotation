#!/bin/bash
#SBATCH --job-name=updateGFFandAED
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=4 
#SBATCH --mem=16G
#SBATCH --time=8:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/10_updateGFF_w_interproscan/output_10_updateGFF_w_interproscan_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/10_updateGFF_w_interproscan/error_10_updateGFF_w_interproscan_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end,fail

#update GFF w interproscan results
#calculate AED values

#directories
WORKDIR="/data/users/aikiror/genomeAnnotation"
OUTPUTDIR="$WORKDIR/output/10_updateGFF_w_interproscan"
COURSEDIR="$WORKDIR/CDS_annotation"
MAKERBIN="${COURSEDIR}/softwares/Maker_v3.01.03/src/bin"

mkdir -p $OUTPUTDIR

#location output will go
IPR_OUTPUT="$OUTPUTDIR/iprscanOutput"
AED_OUTPUT="$OUTPUTDIR/AEDOutput"

mkdir -p $OUTPUTDIR
mkdir -p $IPR_OUTPUT
mkdir -p $AED_OUTPUT

IPRSCAN="$WORKDIR/output/08_InterProScan/output.iprscan"
RENAMED_GFF="/data/users/aikiror/genomeAnnotation/output/07_rename_genes/finalFilteredAnnotations/pacbio_hifi_Est-0.p_ctg.all.maker.noseq.renamed.gff"
gffPrefix="pacbio_hifi_Est-0.p_ctg.all.maker.noseq"

cd $IPR_OUTPUT

#incorporate interproscan func. annot. into the gff3 file
$MAKERBIN/ipr_update_gff ${RENAMED_GFF} ${IPRSCAN} > ${gffPrefix}.renamed.iprscan.gff

cd $AED_OUTPUT
#calculate AED values
perl $MAKERBIN/AED_cdf_generator.pl -b 0.025 ${RENAMED_GFF} > ${gffPrefix}.renamed.gff.AED.txt