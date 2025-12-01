#!/bin/bash
#SBATCH --job-name=bestBlastHit
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=4 
#SBATCH --mem=32G
#SBATCH --time=6:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/18_best_blast_hit/output_18_best_blast_hit_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/18_best_blast_hit/error_18_best_blast_hit_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end,fail


WORKDIR="/data/users/aikiror/genomeAnnotation"
COURSEDIR="$WORKDIR/CDS_annotation"
OUTPUTDIR="$WORKDIR/output/18_best_blast_hit"
COURSEDIR="$WORKDIR/CDS_annotation"

FILT_MAKER_PROTEIN_FASTA="/data/users/aikiror/genomeAnnotation/output/13_extractLongest/longest_protein_seq_per_gene.fasta"

#FILT_MAKER_PROTEIN_FASTA="$WORKDIR/output/12_extract_mRNA/pacbio_hifi_Est-0.p_ctg.all.maker.proteins.renamed.filtered.fasta"
REPRESENTATIVE_GENE_MODEL="${COURSEDIR}/data/TAIR10_pep_20110103_representative_gene_model"
#BLASTP_OUTPUT="$WORKDIR/output/16_proteinAlignement/blastp_output"

mkdir -p $OUTPUTDIR
cd $OUTPUTDIR

module load BLAST+/2.15.0-gompi-2021a

blastp -query $FILT_MAKER_PROTEIN_FASTA -db $REPRESENTATIVE_GENE_MODEL \
    -num_threads 10 -outfmt 6 -evalue 1e-5 -max_target_seqs 10 -out blastp_output_TAIR10_w_longest_sequences2
# Now sort the blast output to keep only the best hit per query sequence
sort -k1,1 -k12,12g blastp_output_TAIR10_w_longest_sequences2 | sort -u -k1,1 --merge > blastp_output_TAIR10_w_longest_sequences2.besthits