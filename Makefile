# Source TeX files with text in, which should contribute to word-counts.
# (Note: abstract is handled separately)
TEXT_SOURCES := \
	./introduction/introduction.tex         \
	./chapter1/chapter1.tex                 \
	./conclusion/conclusion.tex             \

# Other TeX files that should not contribute to word-counts.
OTHER_SOURCES := \
	./thesis.tex                            \
	./abstract/abstract.tex                 \
	./acknowledgements/acknowledgements.tex \
	./appendixa/appendixa.tex               \
	./notation/notation.tex                 \

SOURCES := $(TEXT_SOURCES) $(OTHER_SOURCES)

all: thesis.pdf wordcount.txt

thesis.pdf: wordcount.abstract wordcount.summary wordcount.total $(SOURCES)
	latexmk --pdf

wordcount.txt: $(TEXT_SOURCES)
	texcount -sum=1,0,1 -inc $^ >$@

wordcount.abstract: abstract/abstract.tex
	texcount -sum=1,0,1 -1 -nc $^ >$@

wordcount.summary: $(TEXT_SOURCES)
	texcount -sum=1,0,1 -brief -nc $^ >$@

wordcount.total: $(TEXT_SOURCES)
	texcount -sum=1,0,1 -1 -nc $^ >$@
	
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
