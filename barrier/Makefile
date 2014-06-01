###############################################################################
# $Date: 2003-06-28 19:02:13 $
###############################################################################

TARGET =barrier

MODULES=barrier.tex barrier.bib \
	title.tex abstract.tex \
	section1.tex barriers.eps \
	section2.tex \
		power4mcm.eps \
	section3.tex \
		fetchandadd.eps distcounter.eps \
		paddeddistcounter.eps combined.eps \
	section4.tex \
		stcx.eps lsource.eps l2miss.eps l3miss.eps \
		power4performance.eps power3performance.eps \
	section5.tex \
	epilog.tex

###############################################################################
# Makefile for general latex related.
###############################################################################

SHELL   = /bin/sh
DEBUG   = 

LATEX   = latex
BIBTEX  = bibtex
DVIPS   = dvips -z
XDVI    = xdvi -s 0
FIG2DEV = fig2dev
GNUPLOT = gnuplot

PS2PDF  = ps2pdf

ISPELL  = ispell

GHOSTVIEW  = ghostview
XPDF       = xpdf 
LATEX2HTML = latex2html

.SUFFIXES:
.SUFFIXES: .tex .bib .dvi .ps .pdf .fig .plt .eps

.tex.dvi:
	$(LATEX) $*
	$(BIBTEX) $*
	$(LATEX) $*
	$(LATEX) $*

.dvi.ps:
	$(DVIPS) $*.dvi -o $*.ps

.ps.pdf:
	$(PS2PDF) $*.ps $*.pdf

.fig.eps:
	$(FIG2DEV) -L eps $*.fig $*.eps

.plt.eps:
	$(GNUPLOT) $*.plt > $*.eps

default: dvi

all: ps pdf spell

view: dvi
	$(XDVI) $(TARGET).dvi &

psview: ps 
	$(GHOSTVIEW) $(TARGET).ps &

pdfview: pdf
	$(XPDF) $(TARGET).pdf &


spell:
	@echo
	@for i in $(MODULES); do echo  ------ $$i; cat $$i | $(ISPELL) -l -t -p $(TARGET).dic; done

$(TARGET).dvi: $(MODULES)

dvi: $(TARGET).dvi

ps: $(TARGET).ps

pdf: $(TARGET).pdf

html: $(TARGET)/$(TARGET).html

# leaving generated eps as our plugin
clean:
	rm -f $(TARGET).ps $(TARGET).pdf *.dvi 
	rm -f *.aux *.bbl *.blg *.out *.log *.toc *.bak *.tmp *~
	rm -rf $(TARGET)

# for web
$(TARGET)/$(TARGET).html: $(TARGET).dvi
	$(LATEX2HTML) $(TARGET)

###############################################################################
# detailed dependency
###############################################################################

