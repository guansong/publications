
all: hpspmd.ps hpspmd.pdf hpspmd/hpspmd.html

hpspmd.dvi : hpspmd.tex hpspmd.bib \
             title.tex abstract.tex intro.tex \
             section1.tex section2.tex section3.tex section4.tex 
	latex hpspmd
	bibtex hpspmd
	latex hpspmd
	latex hpspmd

hpspmd.ps : hpspmd.dvi
	dvips hpspmd.dvi -o hpspmd.ps

hpspmd.pdf : hpspmd.ps
	ps2pdf hpspmd.ps hpspmd.pdf

hpspmd/hpspmd.html : hpspmd.dvi
	latex2html hpspmd

clean:
	rm -f hpspmd.ps hpspmd.pdf *.aux *.bbl *.blg *.dvi *.log *.toc
	rm -rf hpspmd


