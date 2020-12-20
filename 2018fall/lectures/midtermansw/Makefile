## -*- mode: Makefile -*-
##
## This is a sufficient `Makefile', but not a great one.
##
## "Normal" PDF is currently generated via `pdflatex'.  This is the route you
## take if you make `<doc>.pdf'.
##
## "Alternative" PDF is currently generated via `dvips' and `ps2pdf'.  This is
## the route you take if you make `<doc>-ps.pdf'.
##

###############################################################################

# The root documents, minus their `.tex' file name extensions.  Each of these
# is a (phony) Make target.  The first root file listed in `DOCUMENTS' is the
# default target.
#
DOCUMENTS	:= paper
DOC		:= $(firstword $(DOCUMENTS))

# "Extra" figures, not made from `.fig' or `.svg' files.  These must have file
# name extensions because we don't want to infer them.
#
EXTRAFIGEPS	:=
#
EXTRAFIGPDF	:=
#
EXTRAFIGWWW	:=

###############################################################################

TEXINPUTS	:= .:./figs:: 
BIBINPUTS	:= .::

export TEXINPUTS
export BIBINPUTS

LATEX		:= latex
PDFLATEX	:= pdflatex
BIBTEX		:= bibtex

DVIPS		:= dvips
PS2PDF		:= ps2pdf14
FIG2DEV		:= fig2dev
INKSCAPE 	:= inkscape
# EPSTOPDF	:= epstopdf
M4		:= m4
CP		:= cp

# See below for some long-winded comments about these options.
#
DVIPSFLAGS	:= -Ppdf -Pcmz -Pdownload35 -u ps2pk.map -tletter -G0
PS2PDFFLAGS	:= -sPAPERSIZE=letter -dPDFSETTINGS=/printer \
		   -dUseCIEColor \
		   -dEmbedAllFonts=true -dSubsetFonts=true -dMaxSubsetPct=100
PS2PDFFLAGS_EPS	:= -dEPSCrop -dPDFSETTINGS=/printer \
		   -dUseCIEColor \
		   -dEmbedAllFonts=true -dSubsetFonts=true -dMaxSubsetPct=100 

TEX4HT		:= tex4ht
T4HT		:= t4ht

# TEXBITS	should exclude the root files, but it does not.
TEXBITS		:= $(wildcard *.tex)
BIBBITS		:= $(wildcard *.bib)

FIGBITS		:= $(wildcard figs/*.fig)
SVGBITS 	:= $(wildcard figs/*.svg)
FIGEPS		:= $(FIGBITS:.fig=.eps) $(SVGBITS:.svg=.eps) $(EXTRAFIGEPS)
FIGPDF		:= $(FIGBITS:.fig=.pdf) $(SVGBITS:.svg=.pdf) $(EXTRAFIGPDF)
FIGWWW		:= $(FIGBITS:.fig=.png) $(SVGBITS:.svg=.png) $(EXTRAFIGWWW)

DEPS		:= $(wildcard *.cls) $(wildcard *.sty) $(wildcard *.cfg) \
		   $(TEXBITS) $(BIBBITS) \
		   Makefile

###############################################################################

# Some comments about some of the `DVIPSFLAGS' and `PS2PDFFLAGS'.
#
# -Pdownload35 --- Embed the standard PostScript fonts.  The USENIX author
# instructions (and many other conference instructions) ask that *all* fonts be
# embedded in PDF documents.  Note that you *must* use this option in order for
# `ps2pdf14' to produce working PDF.  Note that the the name of the embedded
# `Times' font is called `Nimbus'.  (See the `ps2pk.map' file.)
#
# -u ps2pk.map --- I think this is not required, but it doesn't hurt.  I think
# `dvips' consults it anyway.  I could be wrong; maybe it is required in some
# cases.
#
# -d... --- For the `ps2pdf' options the deal with font embedding, I believe
# that all of these are the standard values for modern versions of Ghostscript
# (7.05+).
#
# Note that you can use the `pdffonts' tool to check that all the fonts are
# embedded.
#
# Some random but handy URLs for these things:
#   <http://www.crhc.uiuc.edu/~mjmille2/howtos/latex-howtos/>
#   <http://www.cs.wisc.edu/~ghost/doc/gnu/7.05/Ps2pdf.htm>

###############################################################################

.DELETE_ON_ERROR:

.PHONY: all
all: $(DOC)

define def-doc-rule
  .PHONY: $1
  $1: $1.pdf
endef
$(foreach d,$(DOCUMENTS),$(eval $(call def-doc-rule,$d)))

.PHONY: ps
ps: $(DOC)-ps.ps

.PHONY: pdf
pdf: $(DOC).pdf

define def-ps-pdf-rule
  $1-ps.pdf: $1-ps.ps
	$$(PS2PDF) $$(PS2PDFFLAGS) $$<
endef
$(foreach d,$(DOCUMENTS),$(eval $(call def-ps-pdf-rule,$d)))

.PHONY: html
html: $(DOC)-www.html

define def-www-rule
  $1-www.html: $1-www.dvi
	$$(TEX4HT) $$(basename $$@)
	$$(T4HT) $$(basename $$@)
endef
# And if you have `wwwis' <http://bloodyeck.com/wwwis/>,
#	wwwis *.html
$(foreach d,$(DOCUMENTS),$(eval $(call def-www-rule,$d)))

####

$(addsuffix .pdf,$(DOCUMENTS)): $(DEPS) $(FIGPDF)
$(addsuffix -ps.dvi,$(DOCUMENTS)): $(DEPS) $(FIGEPS)
$(addsuffix -www.dvi,$(DOCUMENTS)): $(DEPS) $(FIGWWW)

# Why be subtle?
# Use a special job name to keep our output docs separate from those along the
# "normal" route to PDF.
%-ps.dvi: %.tex
	$(LATEX) -jobname $(basename $@) $(basename $<)
	- $(BIBTEX) $(basename $@)
	$(LATEX) -jobname $(basename $@) $(basename $<)
	$(LATEX) -jobname $(basename $@) $(basename $<)
	$(LATEX) -jobname $(basename $@) $(basename $<)

%-www.dvi: %-www.tex
	$(LATEX) -jobname $(basename $@) $(basename $<)
	- $(BIBTEX) $(basename $@)
	$(LATEX) -jobname $(basename $@) $(basename $<)
	$(LATEX) -jobname $(basename $@) $(basename $<)
	$(LATEX) -jobname $(basename $@) $(basename $<)

%.ps: %.dvi
	$(DVIPS) $(DVIPSFLAGS) $(basename $@) -o $@

# Why be subtle?
%.pdf: %.tex
	$(PDFLATEX) $(basename $<)
	- $(BIBTEX) $(basename $@)
	$(PDFLATEX) $(basename $<)
	$(PDFLATEX) $(basename $<)
	$(PDFLATEX) $(basename $<)

%.bbl: %.aux
	$(BIBTEX) $(basename $@)

####

%.eps: %.svg
	$(INKSCAPE) \
	$< \
	--export-eps=$@
# XXX HotOS

%.eps: %.jpg
	$(INKSCAPE) \
	$< \
	--export-eps=$@ \
	--export-text-to-path

%.eps: %.fig
	$(FIG2DEV) -L eps $< $@

%.pdf: %.fig
	$(FIG2DEV) -L pdf $< $@

# "-m 1.5 -S 4": magnify and smooth
%.png: %.fig
	$(FIG2DEV) -L png -m 1.5 -S 4 $< $@

## XXX Grab rest of crud from hotos11 Makefile.
#
# This method produces small PDFs that have tight bounding boxes.
$(SVGBITS:.svg=.pdf): %.pdf: %.eps
	$(PS2PDF) $(PS2PDFFLAGS_EPS) $< $@

###############################################################################

.PHONY: clean
clean:
	$(RM) *.aux *.bbl *.blg *.dvi *.log *.out *.backup *~ 
	$(RM) *-www.4ct *-www.4tc *-www.idv *-www.lg *-www.tmp *-www.xref \
	      tex4ht.fls

.PHONY: realclean
realclean: clean
	$(RM) *.eps *.pdf *.ps
	$(RM) *-www.css *-www*.html *-www*.png
	$(RM) $(FIGBITS:.fig=.eps) $(SVGBITS:.svg=.eps)
	$(RM) $(FIGBITS:.fig=.pdf) $(SVGBITS:.svg=.pdf)
	$(RM) $(FIGBITS:.fig=.png) $(SVGBITS:.svg=.png)

###############################################################################

## End of file.
