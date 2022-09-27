all: thesis.pdf wordcount.txt

thesis.pdf: wordcount.abstract wordcount.summary wordcount.total
	latexmk --pdf

wordcount.txt:
	texcount abstract/* *.tex -sum=1,0,1 -inc -out=wordcount.txt

wordcount.abstract:
	texcount abstract/* -sum=1,0,1 -1 -out=wordcount.abstract

wordcount.summary:
	texcount introduction/* chapter*/* conclusion/* -sum=1,0,1 -brief -out=wordcount.summary

wordcount.total:
	texcount introduction/* chapter*/* conclusion/* -sum=1,0,1 -1 -out=wordcount.total
	
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
