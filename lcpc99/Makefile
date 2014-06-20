
all: translation.ps translation.pdf translation/translation.html

translation.dvi : translation.tex translation.bib \
                  section1.eps     section2.eps
	latex translation
	bibtex translation
	latex translation
	latex translation

translation.ps : translation.dvi
	dvips translation.dvi -o translation.ps

translation.pdf : translation.ps
	ps2pdf translation.ps translation.pdf

translation/translation.html : translation.dvi
	latex2html translation

clean:
	rm -f translation.ps translation.pdf *.aux *.blg *.dvi *.log
	rm -rf translation

