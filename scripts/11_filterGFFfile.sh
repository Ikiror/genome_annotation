#!/bin/bash
#SBATCH --job-name=filterGFF
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=4 
#SBATCH --mem=16G
#SBATCH --time=6:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/11_filterGFFfile/output_11_filterGFFfile_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/11_filterGFFfile/error_11_filterGFFfile_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end,fail

#this script will filter the GFF for quality and for gene features

#directories
WORKDIR="/data/users/aikiror/genomeAnnotation"
OUTPUTDIR="$WORKDIR/output/11_filterGFFfile"
COURSEDIR="$WORKDIR/CDS_annotation"
MAKERBIN="${COURSEDIR}/softwares/Maker_v3.01.03/src/bin"

mkdir -p $OUTPUTDIR

IPRSCAN_GFF="$WORKDIR/output/10_updateGFF_w_interproscan/iprscanOutput/pacbio_hifi_Est-0.p_ctg.all.maker.noseq.renamed.iprscan.gff"
gffPrefix="pacbio_hifi_Est-0.p_ctg.all.maker.noseq"

#change to outputdir
cd $OUTPUTDIR

#quality filtering
perl $MAKERBIN/quality_filter.pl -s $IPRSCAN_GFF > ${gffPrefix}_iprscan_quality_filtered.gff
# In the above command: -s Prints transcripts with an AED <1 and/or Pfam domain if in gff3

#filtering gff for gene features
# We only want to keep gene features in the third column of the gff file
grep -P "\tgene\t|\tCDS\t|\texon\t|\tfive_prime_UTR\t|\tthree_prime_UTR\t|\tmRNA\t" ${gffPrefix}_iprscan_quality_filtered.gff > filtered.genes.renamed.gff3
# Check
cut -f3 filtered.genes.renamed.gff3 | sort | uniq