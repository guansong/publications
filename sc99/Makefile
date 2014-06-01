
all: project.ps project.pdf project/project.html

project.dvi : project.tex project.bib
	latex project
	bibtex project
	latex project
	latex project

project.ps : project.dvi
	dvips project.dvi -o project.ps

project.pdf : project.ps
	ps2pdf project.ps project.pdf

project/project.html : project.dvi
	latex2html project

clean:
	rm -f project.ps project.pdf *.aux *.blg *.dvi *.log
	rm -rf project

