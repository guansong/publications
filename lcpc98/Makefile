
all: considerations.ps considerations.pdf considerations/considerations.html

considerations.dvi : considerations.tex considerations.bib
	latex considerations
	bibtex considerations
	latex considerations
	latex considerations

considerations.ps : considerations.dvi
	dvips considerations.dvi -o considerations.ps

considerations.pdf : considerations.ps
	ps2pdf considerations.ps considerations.pdf

considerations/considerations.html : considerations.dvi
	latex2html considerations

clean:
	rm -f considerations.ps considerations.pdf *.aux *.bbl *.blg *.dvi *.log *.toc
	rm -rf considerations

