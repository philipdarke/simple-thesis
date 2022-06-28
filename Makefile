all: pdf clean

pdf:
	texcount abstract/* *.tex -sum=1,0,1 -inc -out=wordcount.txt
	texcount abstract/* -sum=1,0,1 -1 -out=wordcount.abstract
	texcount introduction/* chapter*/* conclusion/* -sum=1,0,1 -brief -out=wordcount.summary
	texcount introduction/* chapter*/* conclusion/* -sum=1,0,1 -1 -out=wordcount.total
	latexmk --pdf
	
clean:
	latexmk -c
	rm wordcount.abstract
	rm wordcount.summary
	rm wordcount.total

purge:
	latexmk -C
	rm wordcount.*
	rm *.bbl
	rm *.glsdefs
	rm *.xml
	rm *.tdo
