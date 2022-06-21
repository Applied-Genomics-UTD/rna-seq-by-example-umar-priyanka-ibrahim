grinch.tar.gz:
	wget -nc http://data.biostarhandbook.com/rnaseq/data/grinch.tar.gz

refs/grinch-genome.fa: 
	tar zxvf grinch.tar.gz