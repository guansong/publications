
all: Java98.ps Java98.pdf Java98/Java98.html

Java98.dvi : Java98.tex Java98.bib
	latex Java98
	bibtex Java98
	latex Java98
	latex Java98

Java98.ps : Java98.dvi
	dvips Java98.dvi -o Java98.ps

Java98.pdf : Java98.ps
	ps2pdf Java98.ps Java98.pdf

Java98/Java98.html : Java98.dvi
	latex2html Java98

clean:
	rm -f Java98.ps Java98.pdf *.aux *.bbl *.blg *.dvi *.log
	rm -rf Java98

