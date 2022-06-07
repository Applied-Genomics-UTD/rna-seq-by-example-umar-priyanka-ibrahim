# The index to the genome
IDX=refs/genome.fa

# Build the index
hisat2-build $IDX $IDX

# Create the transcript alignment BAM file.
hisat2 -x $IDX -f -U refs/transcripts.fa | samtools sort > refs/transcripts.bam

# Index the BAM file
samtools index refs/transcripts.bam
hisat2 -x refs/genome.fa -1 reads/BORED_1_R1.fq -2 reads/BORED_1_R2.fq | samtools sort > BORED_1.bam
hisat2 -x refs/genome.fa -1 reads/BORED_2_R1.fq -2 reads/BORED_2_R2.fq | samtools sort > BORED_2.bam
hisat2 -x refs/genome.fa -1 reads/BORED_3_R1.fq -2 reads/BORED_3_R2.fq | samtools sort > BORED_3.bam
hisat2 -x refs/genome.fa -1 reads/EXCITED_1_R1.fq -2 reads/EXCITED_1_R2.fq | samtools sort > EXCITED_1.bam
hisat2 -x refs/genome.fa -1 reads/EXCITED_2_R1.fq -2 reads/EXCITED_2_R2.fq | samtools sort > EXCITED_2.bam
hisat2 -x refs/genome.fa -1 reads/EXCITED_3_R1.fq -2 reads/EXCITED_3_R2.fq | samtools sort > EXCITED_3.bam
