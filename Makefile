grinch.tar.gz:
	wget -nc http://data.biostarhandbook.com/rnaseq/data/grinch.tar.gz

refs/grinch-genome.fa: grinch.tar.gz
	tar zxvf grinch.tar.gz