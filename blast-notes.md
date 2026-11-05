# BLAST gene-finding notes: WW7

## What BLAST does

BLAST finds locally similar sequences by comparing a query with a sequence
database. `blastn` compares nucleotide query to nucleotide database;
`blastp` compares protein query to protein database; `makeblastdb` formats
FASTA sequences into a local database that a search program can use. BLAST
similarity is evidence of sequence relatedness, not by itself proof of a
biological function.

## Part 1: WW7 16S rRNA

The GFF3 search for `Name=16S ribosomal RNA` found four 16S rRNA features:

| Locus tag | Coordinates on contig_1 | Strand |
|---|---:|:---:|
| FDKCGL_00236 | 249522-251043 | - |
| FDKCGL_01056 | 1078037-1079558 | - |
| FDKCGL_01060 | 1084916-1086437 | - |
| FDKCGL_02727 | 2825094-2826615 | + |

Bacteria may have multiple rRNA operons so they can increase ribosome
production during rapid growth; extra copies can also provide redundancy.
For the exercise, I selected the first copy, FDKCGL_00236. Its GFF3 interval
is 1-based and inclusive, so its length is
`251043 - 249522 + 1 = 1522 nt`.

The selected gene is on the minus strand. Extracting those genomic bases
alone gives the opposite orientation from the gene transcript, so I used
SeqKit `seq -r -p -t DNA`: `-r` reverses, `-p` complements, and `-t DNA`
specifies DNA pairing. The resulting 1,522-nt sequence was identical to
FDKCGL_00236 in `WW7_a01.ffn`.

### NCBI 16S BLAST interpretation

I searched the extracted sequence on NCBI BLAST using the **16S ribosomal
RNA sequences (Bacteria and Archaea)** database. Top hits were:

| Organism | Query cover | Percent identity | E-value |
|---|---:|---:|---:|
| *Curtobacterium pusillum* | 99% | 99.34% | 0.0 |
| *Curtobacterium flaccumfaciens* | 97% | 99.80% | 0.0 |
| *Curtobacterium herbarum* | 99% | 98.49% | 0.0 |

These results suggest the genus *Curtobacterium*. Query coverage indicates
how much of the query aligned; percent identity is the fraction of identical
positions in the alignment; the E-value estimates the number of chance hits
this strong expected in the searched database. An E-value displayed as `0.0`
is an extremely small value rounded/displayed as zero, not a literal
probability of zero.

The results do not securely identify a species. Closely related bacteria can
have nearly identical 16S rRNA genes, and the strongest percent identity can
trade off against query coverage. Additional genes or genome-wide comparisons
are often needed for species-level resolution.

## Part 2: local AcdS protein search

I downloaded the FASTA sequence for UniProtKB **P30297**, a 338-aa
1-aminocyclopropane-1-carboxylate deaminase (AcdS/ACC deaminase) from
*Pseudomonas* sp. strain 6G5, and saved it as `data/WW7_AcdS_query.faa`.
The sequence is an amino-acid query. Some bacteria associated with plants use
ACC deaminase to consume ACC, a precursor to the plant stress hormone
ethylene.

`makeblastdb` formatted the 3,299 predicted protein sequences in
`data/WW7_a01.faa` as a local protein database. `blastp` searched that
database with P30297 and wrote tabular output using these columns:

| Column | Meaning |
|---|---|
| `qseqid` | Query FASTA sequence identifier |
| `sseqid` | Subject/WW7 protein identifier |
| `pident` | Percent identical amino acids in the alignment |
| `length` | Alignment length in amino acids |
| `qlen` | Full query protein length |
| `slen` | Full subject protein length |
| `qcovhsp` | Percent of the query covered by this high-scoring pair (HSP) |
| `evalue` | Expected chance matches this strong or stronger; smaller is stronger evidence |
| `bitscore` | Normalized alignment score; larger is stronger |

The tabular output was empty, with no reported AcdS-like WW7 hit. My
interpretation is that this reference did not find a sufficiently similar
protein in WW7, so I doubt WW7 has an obvious AcdS-like gene based on this
search. This is useful negative evidence: it narrows what is supported by
this sequence comparison and can guide further investigation. It does not
prove the gene is absent. A highly divergent homolog might be missed, a gene
could be missing from the assembly or annotation, or other reference
sequences, profile/domain searches, or functional experiments could provide
additional evidence. A genus-level 16S result or plant/soil association alone
does not predict whether a particular strain carries `acdS`.

## Reproducible commands

The commented commands are in [`blast_workflow.sh`](./blast_workflow.sh).
The UniProt query sequence and generated BLAST database/search output are
inputs or results and are not included in the source-control commit.
