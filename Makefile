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

STANDALONE := $(wildcard */*-standalone.tex)

standalone: $(STANDALONE:.tex=.pdf)

%-standalone.pdf: %.tex
	# latexmk passes -auxdir= to pdflatex, which doesn't understand it,
	# so we need to redefine -pdflatex= to pass --output-directory. (We
	# still need -auxdir for latexmk)
	latexmk -pdf -pdflatex="pdflatex --output-directory $(@D) %O %S" -auxdir="$(@D)" $(subst pdf,tex,$@)

# fake cleanup targets
$(addprefix clean-,$(STANDALONE)):
	latexmk -auxdir=$(subst clean-,,$(@D)) -c $(subst clean-,,$@)

$(addprefix purge-,$(STANDALONE)):
	latexmk -auxdir=$(subst purge-,,$(@D)) -C $(subst purge-,,$@)

.PHONY: $(addprefix clean-,$(STANDALONE)) $(addprefix purge-,$(STANDALONE))

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
	
clean: $(addprefix clean-,$(STANDALONE))
	latexmk -c
	rm -f wordcount.abstract \
	      wordcount.summary  \
	      wordcount.total

purge: $(addprefix purge-,$(STANDALONE))
	latexmk -C
	rm -f wordcount.*
	find . -regex ".*\.\(bbl\|glsdefs\|nlg\|not\|ntn\|tdo\|xml\)" -type f -delete

.PHONY: all clean purge standalone
