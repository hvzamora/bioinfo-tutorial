set -euo pipefail

# These commands (head and less) can be used to peek at the
# content of genomic files.
# >head< Prints the first 10 lines of the files.
head -n 10 data/WW7_a01.faa

# >less< Allows you to scroll through line by line.
less -N data/WW7_a01.faa
# Different files: WW7_a01.ffn, WW7_a01.fna, WW7_a01.gff3

# >wc -n< Used to count the number of newline-terminated lines in a
# sequence of a FASTA/FNA file or in an annotated genomic file
# like a GFF3 file.
wc -l data/WW7_a01.faa data/WW7_a01.ffn data/WW7_a01.fna data/WW7_a01.gff3

# >grep< Can generally be used to search for a specific
# string in a file. Specific applications include:
grep -v '^#' data/WW7_a01.gff3 | wc -l
# Counts the number of non-comment lines in a GFF3 file.
# The -v option inverts the match, so it counts lines that do
# not start with a #. This will essentially return the number
# of annotated features in the GFF3 file.

grep -v '^#' data/WW7_a01.gff3 | cut -f3 | sort | uniq -c | sort -nr
# Counts the number of unique feature types in a GFF3 file.
# The -f3 option tells cut to extract the third column
# (feature type) from the GFF3 file. The sort command sorts
# the feature types, and uniq -c counts the number of
# occurrences of each unique feature type. This essentially
# summarizes the feature-row counts by annotation type.

# >gzip< Can generally be used to compress and decompress
# gzipped files without having to save uncompressed copies.
gzip -cd data/WW7_subset_R1.fastq.gz | wc -l
# Can be used to get line counts. To calculate the read counts,
# divide the line counts by 4, since each read is represented
# by 4 lines in a FASTQ file (header, sequence, optional header,
# and quality score).

# >seqkit< Can be used to summarize sequence files, extract
# specific records, and extract subsequences.
seqkit stats data/WW7_a01.fna data/WW7_subset_R1.fastq.gz data/WW7_subset_R2.fastq.gz
# Summarizes the sequence files, including the number of
# sequences, total length, minimum and maximum lengths, and
# average length.

seqkit grep -p contig_1 data/WW7_a01.fna | seqkit stats
# Returns a summary of the specified contig.

seqkit subseq -r 1:1000 data/WW7_a01.fna | seqkit stats
# Returns a summary of bases 1 through 1000 from the record.

# >fastqc< Can be used to generate quality control reports
# for FASTQ files.
fastqc --outdir data \
  data/WW7_subset_R1.fastq.gz data/WW7_subset_R2.fastq.gz
# The output will be an .html file and a .zip file, containing
# the quality control report and raw data used, respectively. The
# --outdir option specifies the output directory for the report
# files. The default output directory is the current working
# directory.