
all: languages.ps languages.pdf languages/languages.html

languages.dvi : languages.tex languages.bib
	latex languages
	bibtex languages
	latex languages
	latex languages

languages.ps : languages.dvi
	dvips languages.dvi -o languages.ps

languages.pdf : languages.ps
	ps2pdf languages.ps languages.pdf

languages/languages.html : languages.dvi
	latex2html languages

clean:
	rm -f languages.ps languages.pdf *.aux *.bbl *.blg *.dvi *.log *.toc
	rm -rf languages

