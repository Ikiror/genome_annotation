#!/bin/bash
#SBATCH --job-name=proteinAlignment
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=4 
#SBATCH --mem=16G
#SBATCH --time=6:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/16_proteinAlignement/output_16_proteinAlignement_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/16_proteinAlignement/error_16_proteinAlignement_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end,fail

#this script will align proteins against the seqs of func. validated proteins w known functions found in the uniprot db

#directories
WORKDIR="/data/users/aikiror/genomeAnnotation"
CONTAINER="/containers/apptainer/agat-1.2.0.sif"
OUTPUTDIR="$WORKDIR/output/16_proteinAlignement"
COURSEDIR="$WORKDIR/CDS_annotation"

#make path to outputdir
mkdir -p $OUTPUTDIR

#uniprot database
UNIPROT_FASTA="$COURSEDIR/data/uniprot/uniprot_viridiplantae_reviewed.fa"
#PROTEIN_FASTA="$WORKDIR/output/12_extract_mRNA/pacbio_hifi_Est-0.p_ctg.all.maker.proteins.renamed.filtered.fasta"
PROTEIN_FASTA="/data/users/aikiror/genomeAnnotation/output/13_extractLongest/longest_protein_seq_per_gene.fasta"

#change dir
cd $OUTPUTDIR

#load module
module load BLAST+/2.15.0-gompi-2021a
makeblastdb -in $UNIPROT_FASTA -dbtype prot 
#^this step is already done

blastp -query $PROTEIN_FASTA -db $UNIPROT_FASTA \
    -num_threads 10 -outfmt 6 -evalue 1e-5 -max_target_seqs 10 -out blastp_output_uniprot_w_longest_sequences

# Now sort the blast output to keep only the best hit per query sequence
sort -k1,1 -k12,12g blastp_output_uniprot_w_longest_sequences | sort -u -k1,1 --merge > blastp_output_uniprot_w_longest_sequences.besthits