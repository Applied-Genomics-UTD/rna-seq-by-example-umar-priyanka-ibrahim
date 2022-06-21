grinch.tar.gz:
	wget -nc http://data.biostarhandbook.com/rnaseq/data/grinch.tar.gz

refs/grinch-genome.fa: grinch.tar.gz
	tar zxvf grinch.tar.gz

seqkit: refs/grinch-genome.fa
	seqkit stats reads/*.fq
	seqkit stats refs/grinch-genome.fa
	wc -l refs/grinch-ann*

refs/grinch-genome.fa.fai: refs/grinch-genome.fa
	samtools faidx refs/grinch-genome.fa