IDX=refs/grinch-genome.fa

All:SG
grinch:
	wget -nc http://data.biostarhandbook.com/rnaseq/data/grinch.tar.gz

refs/grinch-genome.fa:grinch
	tar zxvf grinch.tar.gz

seqkit:refs/grinch-genome.fa
	refs/grinch-genome.fa
	seqkit stats reads/*.fq
	seqkit stats refs/grinch-genome.fa
	wc -l refs/grinch-ann*

refs/grinch-genome.fa.fai:refs/grinch-genome.fa
	samtools faidx refs/grinch-genome.fa

ids:refs/grinch-genome.fa 
	parallel echo {1}{2} ::: Cranky Wicked ::: 1 2 3 > ids
	hisat2-build ${IDX} ${IDX}

BAM:ids
	mkdir -p bam
	cat ids | parallel "hisat2 --rna-strandness R --max-intronlen 2500 -x ${IDX} -U reads/{}.fq  | samtools sort > bam/{}.bam"
	cat ids | parallel samtools index bam/{}.bam

FC:BAM
	featureCounts -s 2 -a refs/grinch-annotations_3.gtf -o counts-sense.txt bam/C*.bam bam/W*.bam
	featureCounts -s 1 -a refs/grinch-annotations_3.gtf -o counts-anti.txt bam/C*.bam bam/W*.bam

SG:FC
	cat refs/grinch-annotations_2.gff | awk '$$3=="gene" { print $$0 }' > genes.gff
	bedtools coverage -S -a genes.gff -b bam/*.bam > coverage.txt
	cat coverage.txt | cut -f 9,13 | tr ";" "\t" | cut -f 1,3 | sort -k2,2rn > tin.txt
