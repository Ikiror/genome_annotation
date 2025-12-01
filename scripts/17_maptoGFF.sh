#!/bin/bash
#SBATCH --job-name=proteinAlignment
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=4 
#SBATCH --mem=16G
#SBATCH --time=6:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/17_maptoGFF/output_17_maptoGFF_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/17_maptoGFF/error_17_maptoGFF_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end,fail

#map the protein putative functions to the MAKER produced GFF3 and FASTA files

#directories
WORKDIR="/data/users/aikiror/genomeAnnotation"
OUTPUTDIR="$WORKDIR/output/17_maptoGFF_w_longest_sequences"
COURSEDIR="$WORKDIR/CDS_annotation"

MAKERBIN="${COURSEDIR}/softwares/Maker_v3.01.03/src/bin"

prefix="pacbio_hifi_Est-0.p_ctg"
#make path to outputdir if it doesnt exist
mkdir -p $OUTPUTDIR

UNIPROT_FASTA="$COURSEDIR/data/uniprot/uniprot_viridiplantae_reviewed.fa"

MAKER_PROTEIN_FASTA="/data/users/aikiror/genomeAnnotation/output/13_extractLongest/longest_protein_seq_per_gene.fasta"
#MAKER_PROTEIN_FASTA="$WORKDIR/output/12_extract_mRNA/pacbio_hifi_Est-0.p_ctg.all.maker.proteins.renamed.filtered.fasta"
MAKER_GFF="$WORKDIR/output/11_filterGFFfile/filtered.genes.renamed.gff3"

BLAST_OUTPUT="$WORKDIR/output/16_proteinAlignement/blastp_output_uniprot_w_longest_sequences"
BLAST_BESTHITS="$WORKDIR/output/16_proteinAlignement/blastp_output_uniprot_w_longest_sequences.besthits"
#change to outputdir
cd $OUTPUTDIR

cp $MAKER_PROTEIN_FASTA ${prefix}_maker_proteins.fasta.Uniprot
cp $MAKER_GFF ${prefix}_filtered.maker.filtered.gff3.Uniprot
$MAKERBIN/maker_functional_fasta $UNIPROT_FASTA $BLAST_BESTHITS $MAKER_PROTEIN_FASTA > ${prefix}_maker_proteins.filtered.fasta.Uniprot

$MAKERBIN/maker_functional_gff $UNIPROT_FASTA $BLAST_OUTPUT $MAKER_GFF > ${prefix}_filtered.maker.gff3.Uniprot.gff3

