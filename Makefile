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

all: thesis.pdf wordcount.txt $(STANDALONE)

##############################################################################
# rules for building standalone chapters.

STANDALONE_SOURCES := $(wildcard */*-standalone.tex)
STANDALONE         := $(STANDALONE_SOURCES:.tex=.pdf)

%-standalone.pdf: %.tex
	latexmk -pdf -output-directory="$(@D)" $(subst pdf,tex,$@)

# fake cleanup targets
$(addprefix clean-,$(STANDALONE)):
	latexmk -output-directory="$(subst clean-,,$(@D))" -c $(subst clean-,,$@)

$(addprefix purge-,$(STANDALONE)):
	latexmk -output-directory="$(subst purge-,,$(@D))" -C $(subst purge-,,$@)

standalone:       $(STANDALONE)
clean-standalone: $(addprefix clean-,$(STANDALONE))
purge-standalone: $(addprefix purge-,$(STANDALONE))

.PHONY: standalone clean-standalone purge-standalone

##############################################################################

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
	
clean: clean-standalone
	latexmk -c
	rm -f wordcount.abstract \
	      wordcount.summary  \
	      wordcount.total

purge: purge-standalone
	latexmk -C
	rm -f wordcount.*
	find . -regex ".*\.\(bbl\|glsdefs\|nlg\|not\|ntn\|tdo\|xml\)" -type f -delete

.PHONY: all clean purge
