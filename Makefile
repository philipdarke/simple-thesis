# Source TeX files with text in, which should contribute to word-counts.
# (Note: abstract is handled separately)
TEXT_SOURCES := \
	./introduction/introduction.tex         \
	./conclusion/conclusion.tex             \
	$(wildcard ./chapter*/chapter*.tex)     \

# Other TeX files that should not contribute to word-counts.
OTHER_SOURCES := \
	./thesis.tex                            \
	./abstract/abstract.tex                 \
	./acknowledgements/acknowledgements.tex \
	./notation/notation.tex                 \
	$(wildcard ./appendix*/appendix*.tex)   \

SOURCES := $(TEXT_SOURCES) $(OTHER_SOURCES)

all: thesis.pdf wordcount.txt

thesis.pdf: wordcount.abstract wordcount.summary wordcount.total $(SOURCES)
	latexmk --pdf

wordcount.txt: $(TEXT_SOURCES)
	texcount -sum=1,0,1 -inc $^ >$@

wordcount.abstract: abstract/abstract.tex
	texcount -sum=1,0,1 -1 -q $^ >$@

wordcount.summary: $(TEXT_SOURCES)
	texcount -sum=1,0,1 -brief -q $^ >$@

wordcount.total: $(TEXT_SOURCES)
	texcount -sum=1,0,1 -1 -q $^ >$@
	
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
