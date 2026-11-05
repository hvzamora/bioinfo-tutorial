#!/usr/bin/env bash
set -euo pipefail

# Run this script from any directory; outputs are written inside this project.
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

# One-time environment setup (already completed for this tutorial):
# micromamba install -n bioinfo-intro -c conda-forge -c bioconda blast

# Part 1: find the actual 16S rRNA features, not 16S-rRNA-modifying proteins.
grep -n 'Name=16S ribosomal RNA' data/WW7_a01.gff3

# GFF3 coordinates are 1-based and inclusive. This selects the first 16S copy:
# contig_1:249522-251043, minus strand. Reverse then complement to orient it
# in the gene's 5'-to-3' direction.
micromamba run -n bioinfo-intro bash -o pipefail -c \
  'seqkit grep -p contig_1 data/WW7_a01.fna | seqkit subseq -r 249522:251043 | seqkit seq -r -p -t DNA' \
  > data/WW7_16S_selected.fa

# Confirm the inclusive interval length (1522 nt).
micromamba run -n bioinfo-intro seqkit fx2tab -n -l data/WW7_16S_selected.fa

# Confirm the extracted sequence matches the annotated nucleotide feature.
micromamba run -n bioinfo-intro bash -o pipefail -c \
  'diff -s <(seqkit seq -s -w 0 data/WW7_16S_selected.fa) <(seqkit grep -p FDKCGL_00236 data/WW7_a01.ffn | seqkit seq -s -w 0)'

# Part 2: download UniProt P30297 in FASTA format using a browser and save it
# as data/WW7_AcdS_query.faa:
# https://rest.uniprot.org/uniprotkb/P30297.fasta

# Build a searchable protein database from WW7's predicted proteins.
mkdir -p results
micromamba run -n bioinfo-intro makeblastdb \
  -in data/WW7_a01.faa \
  -dbtype prot \
  -parse_seqids \
  -out results/WW7_proteins

# Search WW7 proteins with the UniProt AcdS query; the tabular columns are
# explained in blast-notes.md. This creates/overwrites the results TSV.
micromamba run -n bioinfo-intro blastp \
  -query data/WW7_AcdS_query.faa \
  -db results/WW7_proteins \
  -out results/WW7_AcdS_blastp.tsv \
  -outfmt '6 qseqid sseqid pident length qlen slen qcovhsp evalue bitscore' \
  -max_target_seqs 10
