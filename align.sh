# The index to the genome
IDX=refs/genome.fa

# Build the index
hisat2-build $IDX $IDX

# Create the transcript alignment BAM file.
hisat2 -x $IDX -f -U refs/transcripts.fa | samtools sort > refs/transcripts.bam

# Index the BAM file
samtools index refs/transcripts.bam