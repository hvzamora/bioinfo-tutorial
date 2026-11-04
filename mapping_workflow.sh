#!/usr/bin/env bash
set -euo pipefail

# Run this script from any directory after activating the bioinfo-mapping environment.
repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$repo_dir"

outdir="results/mapping"
mkdir -p "$outdir"

# Trim adapters and filter the paired reads; keep both mates synchronized.
fastp \
  -i data/WW7_subset_R1.fastq.gz \
  -I data/WW7_subset_R2.fastq.gz \
  -o "$outdir/WW7_R1.trimmed.fastq.gz" \
  -O "$outdir/WW7_R2.trimmed.fastq.gz" \
  --html "$outdir/fastp.html" \
  --json "$outdir/fastp.json" \
  --thread 4

# Map the trimmed paired-end reads to the reference in minimap2 short-read mode.
minimap2 -ax sr -t 4 \
  data/WW7_a01.fna \
  "$outdir/WW7_R1.trimmed.fastq.gz" \
  "$outdir/WW7_R2.trimmed.fastq.gz" \
  > "$outdir/WW7.sam"

# Convert SAM to BAM and sort by reference coordinate for indexing and IGV.
samtools sort -@ 4 -O BAM \
  -o "$outdir/WW7.sorted.bam" \
  "$outdir/WW7.sam"

# Create indexes used by samtools and IGV for fast region access.
samtools index "$outdir/WW7.sorted.bam"
samtools faidx data/WW7_a01.fna

# Summarize alignment status and per-reference coverage.
samtools flagstat "$outdir/WW7.sorted.bam"
samtools coverage "$outdir/WW7.sorted.bam"
