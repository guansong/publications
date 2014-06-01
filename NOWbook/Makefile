all: phbook.ps phbook.pdf phbook/phbook.html

phbook.dvi : phbook.tex zgs.tex zgs.bib
	latex phbook
	bibtex zgs
	latex phbook
	latex phbook

phbook.ps : phbook.dvi
	dvips phbook.dvi -o phbook.ps

phbook.pdf : phbook.ps
	ps2pdf phbook.ps phbook.pdf

phbook/phbook.html : phbook.dvi
	latex2html phbook

clean:
	rm -f phbook.ps phbook.pdf *.aux *.bbl *.blg *.dvi *.log *.toc
	rm -rf phbook


