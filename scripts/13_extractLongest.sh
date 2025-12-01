#!/bin/bash
#SBATCH --job-name=extractLongest
#SBATCH --partition=pibu_el8 
#SBATCH --cpus-per-task=4 
#SBATCH --mem=16G
#SBATCH --time=6:00:00 
#SBATCH --output=/data/users/aikiror/genomeAnnotation/logAndReports/13_extractLongest/output_13_extractLongest_%j.o
#SBATCH --error=/data/users/aikiror/genomeAnnotation/logAndReports/13_extractLongest/error_13_extractLongest_%j.e
#SBATCH --mail-user=amo.ikiror@students.unibe.ch
#SBATCH --mail-type=end,fail

#this script will extract the longest seq per gene
WORKDIR="/data/users/aikiror/genomeAnnotation"
OUTPUTDIR="${WORKDIR}/output/13_extractLongest"
COURSEDIR="${WORKDIR}/CDS_annotation"

#path to fasta files
PROTEIN_FASTA="$WORKDIR/output/12_extract_mRNA/pacbio_hifi_Est-0.p_ctg.all.maker.proteins.renamed.filtered.fasta"
TRANSCRIPT_FASTA="$WORKDIR/output/12_extract_mRNA/pacbio_hifi_Est-0.p_ctg.all.maker.transcripts.renamed.filtered.fasta"

#make outputdir
mkdir -p $OUTPUTDIR

#change directories
cd $OUTPUTDIR

#load module
module load SeqKit/2.6.1
#sort fasta sequences by length; reverse order so longest first

#protein
# seqkit sort --by-length --reverse $PROTEIN_FASTA | seqkit head -n 1 > longest_protein_sequence.fasta
# seqkit sort --by-length --reverse $TRANSCRIPT_FASTA | seqkit head -n 1 > longest_transcript_sequence.fasta

# Extract longest isoform per gene
# seqkit fx2tab "$PROTEIN_FASTA" \
# | awk -F'\t' '{
#     split($1,a," "); 
#     split(a[1],b,"-"); 
#     gene=b[1];
#     len=length($3);
#     header=$1;
#     seq=$3;
#     print gene "\t" len "\t" header "\t" seq
# }' \
# | sort -k1,1 -k2,2nr \
# | awk '!seen[$1]++ {
#     print ">"$3"\n"$4
# }' > "${OUTPUTDIR}/longest_protein_seq_per_gene.fasta"

# Transcript longest isoform per gene
# seqkit fx2tab "$TRANSCRIPT_FASTA" \
# | awk -F'\t' '{
#     split($1,a," "); 
#     split(a[1],b,"-"); 
#     gene=b[1];
#     len=length($3);
#     header=$1;
#     seq=$3;
#     print gene "\t" len "\t" header "\t" seq
# }' \
# | sort -k1,1 -k2,2nr \
# | awk '!seen[$1]++ {
#     print ">"$3"\n"$4
# }' > "${OUTPUTDIR}/longest_transcript_seq_per_gene.fasta"

# seqkit fx2tab "$TRANSCRIPT_FASTA" \
# | awk -F'\t' '{split($1,a," "); split(a[1],b,"-"); print b[1] "\t" length($3) "\t" a[1] "\t" $3}' \
# | sort -k1,1 -k2,2nr \
# | awk '!seen[$1]++ {print ">"$3"\n"$4}' \
# > "${OUTPUTDIR}/longest_transcript_seq_per_gene.fasta"

seqkit fx2tab "$PROTEIN_FASTA" \
| awk -F'\t' '{len=length($2); split($1,a,"-R"); gene=a[1]; if(len>max[gene]){max[gene]=len; seq[gene]=$0}} END{for(i in seq) print seq[i]}' \
| seqkit tab2fx > "${OUTPUTDIR}/longest_protein_seq_per_gene.fasta"

seqkit fx2tab "$TRANSCRIPT_FASTA" \
| awk -F'\t' '{len=length($2); split($1,a,"-R"); gene=a[1]; if(len>max[gene]){max[gene]=len; seq[gene]=$0}} END{for(i in seq) print seq[i]}' \
| seqkit tab2fx > "${OUTPUTDIR}/longest_transcript_seq_per_gene.fasta"
