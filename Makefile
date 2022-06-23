IDX=refs/grinch-genome.fa
grinch:
	wget -nc http://data.biostarhandbook.com/rnaseq/data/grinch.tar.gz

up:grinch
	tar zxvf grinch.tar.gz

seqkit: 
	refs/grinch-genome.fa
	seqkit stats reads/*.fq
	seqkit stats refs/grinch-genome.fa
	wc -l refs/grinch-ann*

refs/grinch-genome.fa.fai: refs/grinch-genome.fa
	samtools faidx refs/grinch-genome.fa

ids:up 
	parallel echo {1}{2} ::: Cranky Wicked ::: 1 2 3 > ids
	hisat2-build ${IDX} ${IDX}

BAM:ids
	mkdir -p bam
	cat ids | parallel "hisat2 --max-intronlen 2500 -x ${IDX} -U reads/{}.fq  | samtools sort > bam/{}.bam"
	cat ids | parallel samtools index bam/{}.bam

FC:
	featureCounts -a refs/grinch-annotations_3.gtf -o counts.txt bam/C*.bam bam/W*.bam
