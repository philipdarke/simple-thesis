all: thesis.pdf clean

thesis.pdf:
	texcount abstract/* *.tex -sum=1,0,1 -inc -out=wordcount.txt
	texcount abstract/* -sum=1,0,1 -1 -out=wordcount.abstract
	texcount introduction/* chapter*/* conclusion/* -sum=1,0,1 -brief -out=wordcount.summary
	texcount introduction/* chapter*/* conclusion/* -sum=1,0,1 -1 -out=wordcount.total
	latexmk --pdf
	
clean:
	latexmk -c
	rm -f wordcount.abstract \
	      wordcount.summary  \
	      wordcount.total

purge:
	latexmk -C
	rm -f wordcount.* \
	      *.bbl 	  \
	      *.glsdefs   \
	      *.nlg       \
	      *.not       \
	      *.ntn       \
	      *.tdo       \
	      *.xml

.PHONY: all clean purge
