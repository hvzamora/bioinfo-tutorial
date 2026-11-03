# Tutorials 1-6 review

## Topics I feel confident about

- **Micromamba environments and channels:** Environments isolate tools and their dependencies; channels are package repositories that micromamba searches for package files and metadata.
- **Git commits and pushes:** A commit records changes in local Git history, and a push sends commits to a remote repository.
- **Basic GFF3 structure:** The third column is the feature type, columns four and five are start and end, column seven is strand, and column nine contains attributes.
- **`wc -l` and `sort | uniq`:** `wc -l` counts lines; sorting groups identical lines so `uniq` can identify adjacent duplicates.
- **FastQC:** It produces quality-control reports; a decline in quality near read ends is worth evaluating but does not by itself make a dataset unusable.
- **Paired-end reads:** R1 and R2 should have matching counts because each pair represents reads from opposite ends of the same DNA fragment.

## Topics to revisit

- **`.gitignore`:** It excludes untracked paths from Git, but does not protect a file from edits or stop Git tracking a file that is already tracked. Generated or machine-specific files are better examples of what to ignore.
- **FASTA, FASTQ, and GFF3:** FASTA can contain nucleotide or protein sequences; FASTQ adds per-base quality scores to sequence records; GFF3 has nine tab-separated fields. Review the complete field meanings and the distinction between genes and sequencing reads.
- **Unix field handling:** GFF3 is tab-separated; `cut` uses tabs by default, so `cut -f 3` selects the third field. Review how to recognize delimiters and comment lines.
- **SeqKit:** `seqkit stats` summarizes records and lengths, while `seqkit seq -n` prints sequence names/identifiers rather than counting records.
- **Checking AI answers:** In addition to understanding and running a suggested command, verify its result independently—for example, compare with a second method or a small test file with a known answer.

## WW7 hands-on results

- CDS features in `WW7_a01.gff3`: **3,299**
- Longest protein in `WW7_a01.faa`: **2,551 amino acids**
- Reads in `WW7_subset_R1.fastq.gz`: **50,000**
- Reads in `WW7_subset_R2.fastq.gz`: **50,000**

## Draft note to my mentor

I reviewed Tutorials 1–6 and checked my understanding against the WW7 files: I found 3,299 CDS features, a longest protein of 2,551 amino acids, and 50,000 reads in each paired FASTQ file. I feel strongest about Git basics, core file/count concepts, and interpreting FastQC, and I plan to revisit `.gitignore`, FASTA/FASTQ/GFF3 details, Unix field selection, SeqKit options, and independently validating AI-generated commands.
