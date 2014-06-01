
all: based.ps based.pdf based/based.html

based.dvi : based.tex
	latex based
	latex based

based.ps : based.dvi
	dvips based.dvi -o based.ps

based.pdf : based.ps
	ps2pdf based.ps based.pdf

based/based.html : based.dvi
	latex2html based

clean:
	rm -f based.ps based.pdf *.aux *.bbl *.blg *.dvi *.log *.toc
	rm -rf based

