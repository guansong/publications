
all: europar.ps europar.pdf europar/europar.html

europar.dvi : europar.tex europar.bib
	latex europar
	bibtex europar
	latex europar
	latex europar

europar.ps : europar.dvi
	dvips europar.dvi -o europar.ps

europar.pdf : europar.ps
	ps2pdf europar.ps europar.pdf

europar/europar.html : europar.dvi
	latex2html europar

clean:
	rm -f europar.ps europar.pdf *.aux *.bbl *.blg *.dvi *.log
	rm -rf europar

