%--------------------BEGIN phstyle.cls------------------------------
%
% $Id: phstyle.cls,v 1.3 1999-02-08 21:25:30 zgs Exp $
%

% phstyle.cls -- Macros for formatting Prentice-Hall Books
%               -- Compiled by J.K. Shultis, Dec. 1993
%               -- Modified and enhanced for LaTeX2e mdh/rlm 1997/02

\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{phstyle}[1997/02/20 Prentice Hall Book Class, February 1997]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ProcessOptions%

%  Base everything on the default class 'article'.
\LoadClass{report}%


%================================================================================
% 1. Page layout dimensions
% 2. Parameters for float placement
% 3. Define new fonts for headings
% 4. Define LaTeX logos (usually ot needed)
% 5. Redefines the way "figure" amd "table" are formated in a \caption
% 6. Defines a \capt macro which defines (1) \captwidth, (2) \captsize
%    and \beforetableskip.
% 7. New Environemnts:  Eqnarray, reflist, exerlist
% 8. Defines and modifies FANCYHDS.STY for headers and foots
% 9. Change sectioning headings to bold sans serif fonts
%10. Turn off leader dots in Table of Contents
%======================================================================

\def\cleardoublepage{\clearpage\thispagestyle{empty}\if@twoside \ifodd\c@page\else \hbox{}\newpage\thispagestyle{empty}\if@twocolumn\hbox{}\newpage\thispagestyle{empty}\fi\fi\fi}

%====================== Page Layout
\oddsidemargin 0.750in   \evensidemargin 0.750in  \textwidth 5.00in
\topmargin     0.50in    \headheight     0.3in    \headsep  0.2in
\textheight    7.3in     %\footheight .2in        
\footskip      0.3in
\parskip       0ex       \marginparwidth 1.00in  \marginparsep 0.5in
%\setlength\arraycolsep{1pt}


%===================== Float placement parameters
\renewcommand{\topfraction}{.9}
\renewcommand{\bottomfraction}{.9}
\renewcommand{\textfraction}{.05}
\renewcommand{\floatpagefraction}{.05}

%====================== Define special fonts
\newfont{\BIG}{cminch}                             %--- One-inch font
\newfont{\sfbHuge}{cmssbx10 scaled\magstep5}       %-- 25pt sans serif bold
\newfont{\sfblarge}{cmssbx10 scaled\magstep1}      %-- 12pt sans serif bold
\newfont{\sfbeleven}{cmssbx10 scaled\magstephalf}  %-- 11pt sans serif bold
\newfont{\sfb}{cmssbx10}                           %-- 10pt sans serif bold
\newfont{\sfeight}{cmss8}                          %-- 8pt sans serif

\newfont{\defnem}{cmbxti10}                    %-- 10pt sans serif bold
\def\spacingset#1{\def\baselinestretch{#1}\small\normalsize}


%===================== LaTeX and TeX type logos
\newcount\TestCount
\def\La{\TestCount=\the\fam \leavevmode L\raise.42ex
         \hbox{$\fam\TestCount\scriptstyle\kern-.3em A$}}
\def\LaTeX{\La\kern-.15em\TeX}
\def\AllTeX{{(\La)\TeX}}


%
% -- Exercise environment ------------------------------------------------
%

\newcounter{exercisectr}[chapter]
  \def\theexercisectr{\arabic{chapter}.\arabic{exercisectr}}


\newenvironment{exercise}[1]{\renewcommand{\labelenumi}{(\alph{enumi})}%
  \refstepcounter{exercisectr}\bigskip\par%
%  \addcontentsline{loe}{exercise}{\protect\numberline{\theexercisectr}%
%      {\ignorespaces #1}}%
% Changed to the def of addcontentsline from latex.ltx
% Parms were directly entered, and \thepage part was commented out.
% see also computer
  \addtocontents{loe}{\protect\contentsline{exercise}%
        {\protect\numberline{\theexercisectr}{\ignorespaces #1}}{}}
  \noindent{\bfseries\mathversion{bold}Exercise~\theexercisectr: #1}
  \nopagebreak[4]\par\nopagebreak[4]}{\par}


\def\listofexercises{\@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
  \fi\chapter*{List of Exercises}
  \renewcommand\@pnumwidth{0em}
  \@starttoc{loe}\if@restonecol
  \twocolumn\fi}

\def\l@exercise{\noindent\@dottedtocline{1}{0em}{3.5em}}

%
% Theorem hack
%

\def\@begintheorem#1#2{\trivlist
   \item[\hskip \labelsep{\bfseries #1\ #2:}]\itshape}

%
% -- Computer Exercise environment -------------------------------------------
%


\newcounter{computerctr}[chapter]

\def\thecomputerctr{C\arabic{chapter}.\arabic{exercisectr}}

\def\compseparator{\bigskip\par\vbox{\noindent\rule{\textwidth}{1pt}%
        \section*{Computer Exercises}}}

\newenvironment{computer}[1]{\renewcommand{\labelenumi}{(\alph{enumi})}%
  \refstepcounter{exercisectr}\bigskip\par%
  \addtocontents{loe}{\protect\contentsline{exercise}%
        {\protect\numberline{C\theexercisectr}{\ignorespaces #1}}{}}
%  \addcontentsline{loe}{exercise}{\protect\numberline{\thecomputerctr}%
%  {\ignorespaces #1}}
  \noindent{\bf Exercise~\thecomputerctr: #1}\par\nopagebreak}{\par}



%===================== Redefine the \@makecaption command
   \long\def\@makecaption#1#2{\vskip 10\p@
%% \setbox\@tempboxa\hbox{#1: #2}%         %% original label definition
   \setbox\@tempboxa\hbox{\textbf{#1} #2}%   %% bold and . instead of :
   \ifdim \wd\@tempboxa >\hsize
%%     #1: #2\par                   %% original definition
       \textbf{#1} #2\par             %% bold and . instead of :
   \else
    \hbox to\hsize{\hfil\box\@tempboxa\hfil}%   %% original
%%      \hbox to\hsize{\box\@tempboxa\hfil}%             %% no centering
   \fi}

%===================== New caption macro
\newlength{\captsize}         \let\captsize=\footnotesize
\newlength{\captwidth}        \setlength{\captwidth}{\textwidth}
\newlength{\beforetableskip}  \setlength{\beforetableskip}{.5\baselineskip}
\newcommand{\capt}[1]{\begin{minipage}{\captwidth}
          \let\normalsize=\captsize
          \caption[#1]{#1}
          \end{minipage}\\ \vspace{\beforetableskip}}

%---------- Change Figure Label
\newcommand{\thefigurename}{Figure}   %-- set default: Figure
\def\fnum@figure{\thefigurename\ \thefigure}

%       This is to get the equation numbers in the form (section.equation),
%       and to have the equation counter reset every time the section 
%       counter is incremented.

\def\theequation{\thesection.\arabic{equation}}
\@addtoreset{equation}{section}

%===================== New Environments

%------ Reference List Macro
\newenvironment{reflist}{\begin{list}{}{\leftmargin 1em \labelwidth 0in
\labelsep 0in \itemsep 0ex  \rightmargin 0in}}{\end{list}}
\newcommand{\refitem}{\item \hspace*{-1em}}   %--- item for ref list
\newcommand{\SC}{\scriptsize}  %--- small capitals for reference lists


%------ New environment for better spacing in Eqnarray
\def\eqnarray{%
   \stepcounter{equation}%
   \def\@currentlabel{\p@equation\theequation}%
   \global\@eqnswtrue
   \m@th
   \global\@eqcnt\z@
   \tabskip\@centering
   \let\\\@eqncr
   $$\everycr{}\halign to\displaywidth\bgroup
       \hskip\@centering$\displaystyle\tabskip\z@skip{##}$\@eqnsel
      &\global\@eqcnt\@ne\hskip \arraycolsep \hfil${##}$\hfil
      &\global\@eqcnt\tw@ \hskip \arraycolsep
         $\displaystyle{##}$\hfil\tabskip\@centering
      &\global\@eqcnt\thr@@ \hb@xt@\z@\bgroup\hss##\egroup
         \tabskip\z@skip
      \cr
}





%\newenvironment{Eqnarray}{\arraycolsep 0.14em\begin{eqnarray}}{\end{eqnarray}}

% The hangitem environment -- like description, but text lines up with 
%    the item descriptor.  You give an additional argument containing text
%    of the width that you want indentations.
%
\def\hangitem#1{\list{}{\settowidth\labelwidth{#1}
        \leftmargin\labelwidth\advance\leftmargin\labelsep }}
\let\endhangitem\endlist

%------ Problem List Macro
\newcounter{probnum}
\newenvironment{exerlist}%
  {\begin{list}{\bf \theprobnum.}%
  {\usecounter{probnum} \itemsep 1ex  \leftmargin 2.0em \labelsep 0.5em
   \rightmargin 0in}}{\end{list}}




%===================== Define FANCYHDS.STY
% fancyheadings.sty version 1.1
% Fancy headers and footers.
% Piet van Oostrum, Dept of Computer Science, University of Utrecht
% Padualaan 14, P.O. Box 80.089, 3508 TB Utrecht, The Netherlands
% Telephone: +31-30-531806. piet@cs.ruu.nl (mcvax!hp4nl!ruuinf!piet)
% Sep 23, 1992.

\def\lhead{\@ifnextchar[{\@xlhead}{\@ylhead}}
\def\@xlhead[#1]#2{\gdef\@elhead{#1}\gdef\@olhead{#2}}
\def\@ylhead#1{\gdef\@elhead{#1}\gdef\@olhead{#1}}

\def\chead{\@ifnextchar[{\@xchead}{\@ychead}}
\def\@xchead[#1]#2{\gdef\@echead{#1}\gdef\@ochead{#2}}
\def\@ychead#1{\gdef\@echead{#1}\gdef\@ochead{#1}}

\def\rhead{\@ifnextchar[{\@xrhead}{\@yrhead}}
\def\@xrhead[#1]#2{\gdef\@erhead{#1}\gdef\@orhead{#2}}
\def\@yrhead#1{\gdef\@erhead{#1}\gdef\@orhead{#1}}

\def\lfoot{\@ifnextchar[{\@xlfoot}{\@ylfoot}}
\def\@xlfoot[#1]#2{\gdef\@elfoot{#1}\gdef\@olfoot{#2}}
\def\@ylfoot#1{\gdef\@elfoot{#1}\gdef\@olfoot{#1}}

\def\cfoot{\@ifnextchar[{\@xcfoot}{\@ycfoot}}
\def\@xcfoot[#1]#2{\gdef\@ecfoot{#1}\gdef\@ocfoot{#2}}
\def\@ycfoot#1{\gdef\@ecfoot{#1}\gdef\@ocfoot{#1}}

\def\rfoot{\@ifnextchar[{\@xrfoot}{\@yrfoot}}
\def\@xrfoot[#1]#2{\gdef\@erfoot{#1}\gdef\@orfoot{#2}}
\def\@yrfoot#1{\gdef\@erfoot{#1}\gdef\@orfoot{#1}}

\newdimen\headrulewidth
\newdimen\footrulewidth
\newdimen\plainheadrulewidth
\newdimen\plainfootrulewidth
\newdimen\headwidth
\newif\if@fancyplain \@fancyplainfalse
\def\fancyplain#1#2{\if@fancyplain#1\else#2\fi}

% Initialization of the head and foot text.

\headrulewidth 0.4pt
\footrulewidth\z@
\plainheadrulewidth\z@
\plainfootrulewidth\z@

\lhead[\fancyplain{}{\sl\rightmark}]{\fancyplain{}{\sl\leftmark}}
%  i.e. empty on ``plain'' pages \rightmark on even, \leftmark on odd pages
\chead{}
\rhead[\fancyplain{}{\sl\leftmark}]{\fancyplain{}{\sl\rightmark}}
%  i.e. empty on ``plain'' pages \leftmark on even, \rightmark on odd pages
\lfoot{}
\cfoot{\rm\thepage} % page number
\rfoot{}

% Put together a header or footer given the left, center and
% right text, fillers at left and right and a rule.
% The \lap commands put the text into an hbox of zero size,
% so overlapping text does not generate an errormessage.

\def\@fancyhead#1#2#3#4#5{#1\hbox to\textwidth{\vbox{\hbox
{\rlap{\parbox[b]{\textwidth}{\raggedright#2\strut}}\hfill
\parbox[b]{\textwidth}{\centering#3\strut}\hfill
\llap{\parbox[b]{\textwidth}{\raggedleft#4\strut}}}\headrule}}#5}


\def\@fancyfoot#1#2#3#4#5{#1\hbox to\textwidth{\vbox{\footrule
\hbox{\rlap{\parbox[t]{\textwidth}{\raggedright#2\strut}}\hfill
\parbox[t]{\textwidth}{\centering#3\strut}\hfill
\llap{\parbox[t]{\textwidth}{\raggedleft#4\strut}}}}}#5}

\def\headrule{{\if@fancyplain\headrulewidth\plainheadrulewidth\fi
\hrule\@height\headrulewidth\@width\textwidth \vskip-\headrulewidth}}

\def\footrule{{\if@fancyplain\footrulewidth\plainfootrulewidth\fi
\vskip-0.3\normalbaselineskip\vskip-\footrulewidth
\hrule\@width\headwidth\@height\footrulewidth\vskip0.3\normalbaselineskip}}

\def\ps@fancy{
\let\@mkboth\markboth
\@ifundefined{chapter}{\def\sectionmark##1{\markboth
{\uppercase{\ifnum \c@secnumdepth>\z@
 \thesection\hskip 1em\relax \fi ##1}}{}}
\def\subsectionmark##1{\markright {\ifnum \c@secnumdepth >\@ne
 \thesubsection\hskip 1em\relax \fi ##1}}}
%
{\def\chaptermark##1{\markboth {\uppercase{\ifnum \c@secnumdepth>\m@ne
 \@chapapp\ \thechapter. \ \fi ##1}}{}}
\def\sectionmark##1{\markright{\ifnum \c@secnumdepth >\z@
 \thesection. \ \fi ##1}}}
\ps@@fancy
\headwidth\textwidth}
\def\ps@fancyplain{\ps@fancy \let\ps@plain\ps@plain@fancy}
\def\ps@plain@fancy{\@fancyplaintrue\ps@@fancy}
\def\ps@@fancy{
\def\@oddhead{\@fancyhead\relax\@olhead\@ochead\@orhead\hss}
\def\@oddfoot{\@fancyfoot\relax\@olfoot\@ocfoot\@orfoot\hss}
\def\@evenhead{\@fancyhead\hss\@elhead\@echead\@erhead\relax}
\def\@evenfoot{\@fancyfoot\hss\@elfoot\@ecfoot\@erfoot\relax}
}
%------------------- Modify Headers for Prentice-Hall Book Style
%---------- Setup headers and footers
\pagestyle{fancyplain}
\plainfootrulewidth 0pt             %---- no foot rule for chapter page
\footrulewidth 0pt                  %---- no rule for foot
%--- Redefine Headers
\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}
%
\lhead[\fancyplain{}{\bf\thepage}]{\fancyplain{}{\sfeight\rightmark}}
%
%\rhead[\fancyplain{}{\footnotesize\sf\CHHEAD}]{\fancyplain{}{\bf\thepage}}
 \rhead[\fancyplain{}{\sfeight\leftmark}]{\fancyplain{}{\bf\thepage}}
%--- Empty footers on every page (except initial chapter page which has
%--- page number) and optionally a small date stamp
\cfoot[\fancyplain{}{}]{\fancyplain{}{}}
\rfoot[\fancyplain{}{}]{\fancyplain{\bf\thepage}{}}
\lfoot[\fancyplain{\bf\thepage}{}]{\fancyplain{}{}}
%-- replace the two lines above with the two below for a date stamp footer
%\rfoot[\fancyplain{\scriptsize \today}{\scriptsize \today}]{\fancyplain{\bf\thepage}{}}
%\lfoot[\fancyplain{\bf\thepage}{}]{\fancyplain{\scriptsize \today}{\scriptsize \today}}
%--- Change format of section header
%
% rlm added chaptermark 10/11/96
\def\sectionmark#1{\markright{\ifnum \c@secnumdepth >\z@
  {\sfeight Section}~\thesection\quad \fi #1}}
%
\def\chaptermark#1{\markboth{#1 \quad \@chapapp{}~\thechapter}{}}
\def\chaptersmark#1{\markboth{#1}{#1}}




%===================== Change Section Heads to Bold Sans Serif
% Create bolds sans serif sectioning headings.  Also the headings have
% been reduced in size with less space before and after the heading.
% Modified from macros given in BK10.STY
%
%----------------------------- part ---------------------------------
% no changes made to part

%------------------------- appendix -----------------------------------

\let\oldappendix\appendix
\def\appendix{\oldappendix\def\addchaptertoloe{}}

%------------------------- chapter -----------------------------------
\def\addchaptertoloe{%
        \addtocontents{loe}{\protect\addvspace{14pt}}%
        \addtocontents{loe}{\noindent {\bfseries Chapter~\thechapter}}%
        \addtocontents{loe}{\protect\addvspace{10pt}}%
}

\def\chapter{\clearpage \thispagestyle{plain} \global\@topnum\z@
\@afterindentfalse \secdef\@chapter\@schapter} 
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
 \refstepcounter{chapter}
 \typeout{\@chapapp\space\thechapter.}
 \addcontentsline{tocaag}{chapter}{\protect
 \numberline{\textnormal{\thechapter}}\textnormal{#1}}
 \addtocontents{tocaag}{\vskip-10pt}
 \addcontentsline{toc}{chapter}{\protect
 \numberline{\thechapter}#1}\else
 \addcontentsline{tocaag}{chapter}{\textnormal{#1}}
 \addtocontents{tocaag}{\vskip-10pt}
 \addcontentsline{toc}{chapter}{#1}\fi
 \chaptermark{#1}
 \addchaptertoloe
 \addtocontents{lof}{\protect\addvspace{10pt}}
\addtocontents{lot}{\protect\addvspace{10pt}} \if@twocolumn
\@topnewpage[\@makechapterhead{#2}] 
 \else \@makechapterhead{#2}
 \@afterheading \fi} 
%
\def\@schapter#1{\if@twocolumn \@topnewpage[\@makeschapterhead{#1}]
 \else \@makeschapterhead{#1}\chaptersmark{#1}
 \@afterheading\fi\addcontentsline{toc}{chapter}{#1}
                  \addcontentsline{tocaag}{chapter}{\textnormal{#1}}
		  \addtocontents{tocaag}{\vskip-10pt}}



\def\@makechapterhead#1{\vspace*{-20pt}{\parindent0pt\raggedright
\ifnum\c@secnumdepth>\m@ne\LARGE\sf\@chapapp{}~\thechapter\par
\vskip3pt\hrule\vskip3pt\hrule
\vskip30pt\fi\raggedleft\Huge\sfbHuge#1\par
\nobreak\vskip70pt}}%\chaptermark{#1}}

\def\@makeschapterhead#1{\vspace*{4pt}{\parindent0pt
\vskip3pt\hrule\vskip3pt\hrule
\vskip36pt\raggedleft\Huge\sfbHuge#1\par
\nobreak\vskip70pt}}%\chaptersmark{#1}}

%------------------------ section -----------------------------------
\def\section{\@startsection{section}{1}{\z@}{-3.5ex plus-1ex
  minus -.2ex}{1.8ex}{\large\sfblarge}}

%--------------------- subsection -----------------------------------
\def\subsection{\@startsection{subsection}{2}{\z@}{-2.75ex plus -1ex
    minus -.2ex}{1.2ex}{\large\sfblarge}}

%-------------------- subsubsection --------------------------------
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}{-2.75ex
  plus -1ex minus -.2ex}{1.2ex}{\normalsize\sfb}}

%----------------------- paragraph ----------------------------------
\def\paragraph{\@startsection{paragraph}{4}{\z@}{1.25ex plus
     1ex minus .2ex}{-1em}{\normalsize\sfb}}
%
%---------------------- subparagraph --------------------------------
\def\subparagraph{\@startsection{subparagraph}{4}{\parindent}{1.25ex
     plus 1ex minus .2ex}{-1em}{\normalsize\sfb}}



%====================== Turn off leader dots in Table of Contents
\renewcommand{\@dotsep}{500}


\def\tableofcontents{\@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
 \fi\thispagestyle{plain} \@makeschapterhead{Contents} 
 \@afterheading
 \@starttoc{toc}\if@restonecol\twocolumn\fi}


%\def\thebibliography#1{\chapter*{Bibliography}\list
%
% Change done by Toni Cortes (toni@ac.upc.es)
%
% We want a bibliography for each chapter, thus it cannot be a chapter
% by itself.
%
\def\thebibliography#1{\section{Bibliography}\list
% \addcontentsline{toc}{chapter}{Bibliography}
 {[\arabic{enumi}]}{\settowidth\labelwidth{[#1]\ \ \ }\leftmargin\labelwidth
 \advance\leftmargin\labelsep
 \usecounter{enumi}}
 \def\newblock{\hskip .11em plus .33em minus .07em}
 \sloppy\clubpenalty4000\widowpenalty4000
 \sfcode`\.=1000\relax}
\let\endthebibliography=\endlist

%% BIBLIOGRAPHY
%
%% separate citations with "], ["
\def\@citex[#1]#2{\if@filesw\immediate\write\@auxout{\string\citation{#2}}\fi
\def\@citea{}\@cite{\@for\@citeb:=#2\do {\@citea\def\@citea{],
[}\@ifundefined {b@\@citeb}{{\bf ?}\@warning {Citation `\@citeb' on
page \thepage \space undefined}}%
{\csname b@\@citeb\endcsname}}}{#1}}
 
\def\@cite#1#2{[{#1\if@tempswa, #2\fi}]}


%%%%%%%%%%%%%%%%%%%%%%%
%% Index ===>>>

% latex default

\renewenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \twocolumn[\@makeschapterhead{\indexname}]%
                \@mkboth{\uppercase{\indexname}}%
                        {\uppercase{\indexname}}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}
\renewcommand{\@idxitem}  {\par\hangindent 40\p@}
\renewcommand{\subitem}   {\par\hangindent 40\p@ \hspace*{20\p@}}
\renewcommand{\subsubitem}{\par\hangindent 40\p@ \hspace*{30\p@}}
\renewcommand{\indexspace}{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
%%% <<<=== end latex default Index

%%%%%%% Index Formatting

\def\testforadd{\addtoindex}

\def\seealso#1{\hskip16pt{\it See also\ }{#1}}

\def\ltr#1{\nobreak\vskip5pt
\hrule
\nobreak
\vskip3pt
{\bf#1}
\nobreak
\vskip5pt}


\newif\ifnosrtfile
\def\newinput#1{\openin1 #1 \ifeof1 \typeout{^^J^^JWarning:
There is no file #1.^^J^^J\space\space \string\printindex\space
will not work without a \jobname.srt file.^^J^^J
\space\space Please run your sorting program 
on \jobname.inx\space
to produce \jobname.srt.^^J^^J}\global\nosrtfiletrue\else
\global\nosrtfilefalse\closein1 \relax\input #1\fi}

\let\saveanglebracket>

{\catcode`>=\active
\gdef\printindex{
\catcode`>=\active%
\let>\doindex
\newinput{\jobname.srt} \catcode`\*=12 \catcode`>=12
\ifnosrtfile\let\doitnow\relax\else\let\doitnow\doindexending\fi
\doitnow
}

\gdef\doindexending{
\vskip-14pt
\endmulticols
\onecolumn
\thispagestyle{empty}
\pagestyle{empty}
\leftskip=0pt\vskip1sp}

}

{\catcode`>=\active%
\newif\if@restonecol
\gdef\doindex #1{
\clearpage
\multicols{2}[\chapter*{Index}]
\markboth{INDEX}{INDEX}
\bgroup
\let>\saveanglebracket
\footnotesize
\noindent\ \unskip
\vskip-\baselineskip
\parindent=-\indexwrap \leftskip=\indexwrap
%\def\,{\ifmmode\typeout{mmode^^J^^J}\mskip\thinmuskip\else\comma\fi}
% \addcontentsline{toc}{chapter}{\protect
% \numberline{Index\string\hss}}
\columnsep 35pt
\hfuzz=.5in
\def\checker{#1}
\widowpenalty0
\clubpenalty0
\parskip=0pt plus.001pt
\raggedright
\ifx\checker\testforadd\let\next=\relax\else\let\next=\beginindex\fi\next #1}
}


%%%%%%  Index Entries

\newwrite\innx

\immediate\openout\innx=\jobname.inx

\newif\ifsilent
\newif\ifnotsilent

\newcount\spcount
\def\oneast{\global\spcount=1}
\def\twoast{\global\spcount=2}

\def\astsplit#1*#2#3{\xdef\pagenumzeros{\ifnum\count0<100
\ifnum\count0<10 00\else 0\fi\fi}\if#2\relax%
\def\,{\noexpand\comma}%
\writeit{#1}%
\else\if#3\relax
\def\,{\noexpand\comma}%
\writeita{#1}\else
\def\,{\noexpand\comma}%
\writeitb{#1}\fi\fi%
\ifnotsilent#1\global\notsilentfalse\fi}

\def\pickup#1{\astsplit#1*\relax\relax}
\def\inx#1{\global\notsilenttrue\pickup{#1}}
\def\inxx#1{\astsplit#1*\relax\relax}

\def\romannums{\csname @roman\endcsname\c@page}

\def\writeit#1{\xdef\pagenumzeros{\ifnum\count0<100
\ifnum\count0<10 00\else 0\fi\fi}%
\ifx\thepage\romannums%
\write\innx{\noexpand#1 |{%
\pagenumzeros\the\count0\string\global\string\romanontrue}}\else
\write\innx{\noexpand#1 |{\pagenumzeros\the\count0}}\fi}

\def\writeita#1{\xdef\pagenumzeros{\ifnum\count0<100
\ifnum\count0<10 00\else 0\fi\fi}%
\ifx\thepage\romannums%
\write\innx{\noexpand#1 |{\pagenumzeros\the\count0
\oneast\string\global\string\romanontrue}}\else
\write\innx{\noexpand#1 |{\pagenumzeros\the\count0
\oneast}}\fi}

\def\writeitb#1{\xdef\pagenumzeros{\ifnum\count0<100
\ifnum\count0<10 00\else 0\fi\fi}%
\ifx\thepage\romannums%
\write\innx{\noexpand#1 |{\pagenumzeros\the\count0
\twoast\string\global\string\romanontrue}}\else
\write\innx{\noexpand#1 |{\pagenumzeros\the\count0
\twoast}}\fi}

\write\innx{\noexpand>}
\write\innx{\noexpand~}

%% end sending to index

%% start formatting index

%%% Index Macros
%%% Copyright 1992, Amy Hendrickson
%%% TeXnology, Inc.
%%% All rights reserved.


\def\indexit#1{{\it\expandafter\capthis #1}}
\def\indexbf#1{{\bf\expandafter\capthis #1}}
\def\indexsl#1{{\sl\expandafter\capthis #1}}
\def\indextt#1{{\tt\expandafter\capthis #1}}

\def\lcindexit#1{{\it #1}}
\def\lcindexbf#1{{\bf #1}}
\def\lcindexsl#1{{\sl #1}}
\def\lcindextt#1{{\tt #1}}


\def\module{}\def\rightmodule{}
\def\splittocstuff#1{\global\indxnum=#1}

\def\onward{}

\def\addtoindex{\par}
\def\endadd #1{\def\lfe{#1}\if\lfe\noexpand~
\let\more=\relax\let\lfe=\onecolumn\else
\ifx\lfe\munge\let\more=\relax\else
\ifx\lfe\testforadd\vskip1pt\let\more\relax\else
\par\let\more=\beginindex\fi\fi\fi
\expandafter\more\lfe}

\newcount\indxnum
\newcount\oldindxnum

\def\comma{,\ }
\def\go{}
\def\compare{}
\def\eatthree#1,#2,{}
\def\eattwo#1,{}
\def\oldthreecol{}
\def\oldtwocol{}
\def\oldonecol{}

\newbox\savenumbox

\def\eatcommas{\ifx\twocol\empty%
\let\eat=\relax
\else
   \ifx\threecol\empty\let\eat=\eattwo\else
      \let\eat=\eatthree
    \fi
\fi\eat}

\def\splitoff#1,#2,#3,{\gdef\onecol{#1}\gdef\twocol{#2}%
\gdef\threecol{#3}\eatcommas}
\def\endin{}
\def\testind{\endin}
\def\testadd{\addtoindex}
\def\oldcompare{}
\newif\ifendindex
\newif\ifsavenum
\newcount\saveindxnum
\newif\ifnnum
\newdimen\indexwrap
\newdimen\indexindent


\def\endindx{\vskip1sp\egroup
\@normalsize}

\newif\ifromanon


\gdef\beginindex #1 |#2 #3{%
\let~\relax 
\parindent=-\indexwrap \leftskip=\indexwrap%
\def\module{}\let\oldrightmodule=\rightmodule%
\def\rightmodule{}%
\setbox0=\hbox{\expandafter\splittocstuff{#2}}%
\global\oldindxnum=\saveindxnum\relax%
\def\changenums{\ifnum\spcount<1%
\ifsavenum\global\savenumfalse\hbox{\unhbox\savenumbox}\fi%
, {\module\ifromanon\expandafter\romannumeral\fi%
\number\indxnum\rightmodule}\else%
\ifnum\spcount=1% 
\ifsavenum\global\savenumfalse\hbox{\unhbox\savenumbox}\fi%
, \underbar{\module\ifromanon\expandafter\romannumeral\fi%
\number\indxnum\rightmodule}%
\relax\global\spcount=0%
\else\ifnum\spcount=2%
\ifsavenum\global\savenumfalse\hbox{\unhbox\savenumbox}\relax%
\global\spcount=0\fi%
\global\spcount=0, {\bf\module\ifromanon\expandafter\romannumeral\fi%
\number\indxnum\rightmodule}%
\fi\fi\fi}%
\def\comparenums{\ifnum\oldindxnum=0\changenums\else%%%%
\ifnum\indxnum=\oldindxnum%
\ifx\oldrightmodule\rightmodule\relax%
\else%
, {\module\ifromanon\expandafter\romannumeral\fi%
\number\indxnum\rightmodule}\fi%
\else%
\advance\oldindxnum by 1\relax%
\ifnum\indxnum=\oldindxnum%
\ifnum\spcount=1%
\gdef\numinbox{\underbar{\ifromanon\expandafter\romannumeral\fi%
\number\indxnum\rightmodule}}%
\global\nnumtrue%
\else%
\ifnum\spcount=2\gdef\numinbox{\bf\ifromanon\expandafter\romannumeral\fi%
\number\indxnum\rightmodule}%
\global\nnumtrue%
\else%
\gdef\numinbox{\ifromanon\expandafter\romannumeral\fi%
\number\indxnum\rightmodule}\fi\fi%
\setbox\savenumbox=\hbox{--\hskip1sp\numinbox}%
\global\spcount=0%
\global\savenumtrue%
    \else%
\ifsavenum\global\savenumfalse\hbox{\unhbox\savenumbox}\changenums%
\else%
\changenums\fi\fi\fi\fi}%
\def\compare{#1}% now compare words
\ifx\compare\oldcompare\comparenums% 
\else\splitoff#1,{},{},%
\ifx\onecol\oldonecol%
\ifx\twocol\empty%
\ifsavenum\global\savenumfalse\hbox{\unhbox\savenumbox}\fi%
\par\global\oldindxnum=0 
\expandafter\capthis\onecol\comparenums%
\xdef\lastonecol{\onecol}\else%% 
\ifx\twocol\oldtwocol%
\ifx\threecol\empty\else%
\ifx\threecol\oldthreecol\else%
\ifsavenum\global\savenumfalse\hbox{\unhbox\savenumbox}\fi%
\ifx\onecol\lastonecol\else\par\expandafter\capthis%
\onecol\xdef\lastonecol{\onecol}\fi%
\ifx\twocol\lasttwocol\else\par\hskip\indexindent\twocol%
\xdef\lasttwocol{\twocol}\fi%
\par\global\oldindxnum=0\relax%
\hskip2\indexindent\threecol\comparenums%% ***
\fi\fi\else%
\ifsavenum\global\savenumfalse\hbox{\unhbox\savenumbox}\fi%
\global\oldindxnum=0\relax
\ifx\threecol\empty% 
  \ifx\onecol\lastonecol\else\par%
\expandafter\capthis\onecol\xdef\lastonecol{\onecol}\fi%
  \par\hskip\indexindent\twocol\comparenums%% ***
  \xdef\lasttwocol{\twocol}%
\else%% this is just for error control, 
%% when author has new third level
%% but neglects second level entry.
\ifx\onecol\lastonecol\else\par%
\expandafter\capthis\onecol\xdef\lastonecol{\onecol}\fi%
\ifx\twocol\lasttwocol\else\par\hskip\indexindent\twocol%
\xdef\lasttwocol{\twocol}\fi%
\par\hskip2\indexindent\threecol\comparenums% ***
\fi%
\fi\fi\else\ifx\twocol\empty%
\ifsavenum\global\savenumfalse\hbox{\unhbox\savenumbox}\fi% 
\par\global\oldindxnum=0\relax%
\expandafter\capthis\onecol\comparenums%
\xdef\lastonecol{\onecol}%
\else\ifx\threecol\empty%
\ifsavenum\global\savenumfalse\hbox{\unhbox\savenumbox}\fi%
\global\oldindxnum=0\relax%
\ifx\onecol\lastonecol\else\par%
\expandafter\capthis\onecol\xdef\lastonecol{\onecol}\fi%
\par\hskip\indexindent\twocol\comparenums%% ***
\else%
\ifsavenum\global\savenumfalse\hbox{\unhbox\savenumbox}\fi%
\global\oldindxnum=0\relax%
\ifx\onecol\lastonecol\else\par%
\expandafter\capthis\onecol\xdef\lastonecol{\onecol}\fi%
\ifx\twocol\lasttwocol\else\par\hskip\indexindent\twocol%
\xdef\lasttwocol{\twocol}\fi%
\par\hskip2\indexindent\threecol\comparenums% ***
\fi\fi\fi\fi%
\gdef\oldcompare{#1}%
\global\saveindxnum=\indxnum%
\ifnnum\global\saveindxnum=0\global\nnumfalse\fi%
\global\let\oldonecol=\onecol\relax%
\global\let\oldtwocol=\twocol% 
\global\let\oldthreecol=\threecol% 
\def\turnoff{#3}\ifx\turnoff\testadd% 
\ifsavenum\global\savenumfalse\hbox{\unhbox\savenumbox}\fi%
\let\go=\relax\else\ifx\turnoff\testind\let\go=\relax%
\ifsavenum\global\savenumfalse\hbox{\unhbox\savenumbox}\fi\else%
\if\turnoff\noexpand~\let\go=\endindx%
\ifsavenum\global\savenumfalse\unskip\hbox{\unhbox\savenumbox}\fi%
\else\let\go=\beginindex\fi\fi\fi\global\romanonfalse\go#3}


%% The following commands are used to match original documentation,
%% so the author could write \begin{theindex} \end{theindex}
%% The author could just write \printindex and get the same results.


\let\theindex\printindex
\let\endtheindex\relax

%% CHANGE INDEX FORMAT HERE ====>

%% If you DO NOT want the first letter of each first level index
%% entry to be capitalized, delete the % in front of the following line, 
%% and put % in front of the next line:

%\let\capthis\relax
\def\capthis#1{\uppercase{#1}}%

\indexindent=8pt %% indentation for index subentries
\indexwrap=24pt  %% indentation when term is too wide for column,
                 %% continues on following lines indented this much.




%%%%%
%% Frank Mittlebach's multicol macros, minus comments and
%% irrelevancies.

\def\multicols#1{\col@number#1\relax
  \@ifnextchar[\mult@cols{\mult@cols[]}}

\def\mult@cols[#1]{\@ifnextchar[%
  {\mult@@cols{#1}}%
  {\mult@@cols{#1}[\premulticols]}}

\def\mult@@cols#1[#2]{%
   \enough@room#2%
   #1\nobreak\par%\addvspace\multicolsep 
   \begingroup
   \prepare@multicols\ignorespaces}

\def\enough@room#1{\par \penalty\z@
   \page@free \pagegoal
   \advance \page@free -\pagetotal
   \ifdim \page@free <#1\newpage \fi}

\def\prepare@multicols{%
  \output{\global\setbox\partial@page
                 \vbox{\unvbox\@cclv}}\eject
  \vbadness9999 \hbadness5000
  \tolerance\multicoltolerance 
  \doublecol@number\col@number
  \multiply\doublecol@number\tw@
  \advance\baselineskip\multicolbaselineskip
  \advance\@colroom-\ht\partial@page
  \vsize\col@number\@colroom
  \advance\vsize\c@collectmore\baselineskip
  \hsize\columnwidth \advance\hsize\columnsep
  \advance\hsize-\col@number\columnsep
  \divide\hsize\col@number 
  \linewidth\hsize 
  \output{\multi@columnout}%
  \multiply\count\footins\col@number
  \multiply\skip \footins\col@number
  \reinsert@footnotes}

\def\endmulticols{\parskip=0pt
\par\penalty\z@
  \output{\balance@columns}\eject\nobreak%
\endgroup
}

\newcount\c@unbalance     \c@unbalance   = 0
\newcount\c@collectmore   \c@collectmore = 0

\newcount\col@number 
\newcount\doublecol@number
\newcount\multicoltolerance
                   \multicoltolerance = 9999
\newdimen\page@free
\newdimen\premulticols  \premulticols = 50pt
\newdimen\postmulticols \postmulticols= 50pt
\newskip\multicolsep 
      \multicolsep =0pt

\newskip\multicolbaselineskip 
                   \multicolbaselineskip=0pt
\newbox\partial@page

\def\process@cols#1#2{\count@#1\relax
     \loop #2%
     \advance\count@\tw@
     \ifnum\count@<\doublecol@number 
   \repeat}


\def\page@sofar{\unvbox\partial@page 
   \process@cols\z@{\wd\count@\hsize}%
\hbox to\textwidth{%
     \process@cols\tw@{\box\count@\hss}%
\box\z@}
}


\def\reinsert@footnotes{\ifvoid\footins\else
         \insert\footins{\unvbox\footins}\fi}

\def\multi@columnout{%
   \ifnum\outputpenalty <-\@Mi
   \speci@ls \else
   \splittopskip\topskip 
   \splitmaxdepth\maxdepth
   \dimen@\@colroom
   \divide\skip\footins\col@number
   \ifvoid\footins \else
      \advance\dimen@-\skip\footins 
      \advance\dimen@-\ht\footins   \fi
   \process@cols\tw@{\setbox\count@
            \vsplit\@cclv to\dimen@}%
   \setbox\z@\vsplit\@cclv to\dimen@
   \ifvoid\@cclv \else 
       \unvbox\@cclv
       \penalty\outputpenalty\fi     
   \setbox\@cclv\vbox{\page@sofar}%
   \@makecol\@outputpage
   \global\@colroom\@colht
   \process@deferreds
   \global\vsize\col@number\@colroom 
   \global\advance\vsize
      \c@collectmore\baselineskip
   \multiply\skip\footins\col@number\fi}

\def\speci@ls{%
   \unvbox\@cclv\reinsert@footnotes
   \gdef\@currlist{}}

\def\process@deferreds{%
   \@floatplacement 
   \begingroup
    \let\@tempb\@deferlist
    \gdef\@deferlist{}%
    \let\@elt\@scolelt
      \@tempb \endgroup}

\newif\ifshr@nking

\def\raggedcolumns{%
   \@bsphack\shr@nkingtrue\@esphack}

\def\flushcolumns{%
   \@bsphack\shr@nkingfalse\@esphack}

\newcount\loopcount

\newdimen\savedimen
\newdimen\fixdimen

\def\escapeloop{\gdef\iterate{}}

\let\saveiterate\iterate

\def\balance@columns{%
\loopcount=0
\fixdimen=0pt
   \splittopskip\topskip
   \splitmaxdepth\maxdepth
   \setbox\z@\vbox{\unvbox\@cclv}\dimen@\ht\z@
   \advance\dimen@\col@number\topskip
   \advance\dimen@-\col@number\baselineskip
   \divide\dimen@\col@number
   \advance\dimen@\c@unbalance\baselineskip
   {\vbadness\@M \loop
   {\process@cols\@ne{\global\setbox\count@
                              \box\voidb@x}}%
     \global\setbox\@ne\copy\z@
     {\process@cols\thr@@{\savedimen\ht\@ne \advance\savedimen by-\dimen@
\global\setbox\count@ \vsplit\@ne to\dimen@ 
\ifdim\savedimen>\ht\@ne % AH: TeX was forced to make box bigger than \dimen@.
\advance\savedimen by-\ht\@ne \advance\savedimen by -7.1pt 
\ifdim\savedimen>\fixdimen \global\fixdimen\savedimen\fi\fi}}%
    \ifdim\ht\@ne >\ht\thr@@
    \global\advance\dimen@\p@%.5\baselineskip
\global\advance\loopcount by1
\ifnum\loopcount=90 \escapeloop\fi
   \repeat}%
\let\iterate\saveiterate
\dimen@\ht\thr@@  
\ifdim\fixdimen>0pt \advance\dimen@ by \fixdimen\fi
   \process@cols\z@{\@tempcnta\count@ 
        \advance\@tempcnta\@ne
        \setbox\count@\vtop to\dimen@
           {\unvbox\@tempcnta
           \ifshr@nking\vfill\fi}
}%
   \global\vsize\@colroom 
   \global\advance\vsize\ht\partial@page
   \page@sofar
}

%%%%%%%%%%
%
% New macro to allow chapter author
%     by Toni Cortes (toni@ac.upc.es)
%
%\font\tocauthorfont=cmti10 at 9pt
\def\eatone#1{}
\def\author[#1]#2{{\let\footnote\xfootnote
\ifnum\c@chapter<1
\vskip-2pc
\else
\vskip0pc
\ifnum\c@chapter>9\leftskip=4pc\else
%\leftskip=3pc\fi\fi\let\\ \newline\begin{flushright}\textsc{#2}\end{flushright}\vskip1sp}
\leftskip=3pc\fi\fi\begin{flushright}\vskip-15pt\textsc{#2}\end{flushright}}
%{\let\\ \space \let\footnote\eatone\xdef\totoc{\tocauthorfont #1}}
%\addtocontents{toc}{{\string\noindent\hskip12pt\totoc}}
}
%%%%%%%%%%
%
% New macro to allow chapter author affiliation
%     by Toni Cortes (toni@ac.upc.es)
%
\font\affilfont=cmr10 at 9pt %%
\def\affil#1{\vskip2pt
{\parindent=0pt
\ifnum\c@chapter<1\else
\ifnum\c@chapter>9\leftskip=4pc\else
\leftskip=3pc\fi\fi\let\\ \newline\begin{flushright}\small #1\end{flushright}\vskip20pt}}
%%%%%%%%%%
%
% New macro to allow writing algorithms
%     by Toni Cortes (toni@ac.upc.es)
%
\def\algorithm{\bgroup\obeylines\obeyspaces\footnotesize\def\ {\quad}
\leftskip=2pc\vskip4pt\relax}
\def\endalgorithm{\vskip4pt\egroup}
%%%%%%%%%%
%
% New macro to allow parts in the book
%     by Toni Cortes (toni@ac.upc.es)

\def\@endpart{\vfil\newpage \if@twoside \hbox{} 
 \fi \if@tempswa \twocolumn \fi}

\font\partfont=cmssbx10 at 20pt
\font\partnumberfont=cmssbx10 at 20pt
\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2\relax
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
      \addcontentsline{tocaag}{part}{\thepart\hspace{1em}#1}%
      \addtocontents{tocaag}{\vskip-6pt}%
    \else
      \addcontentsline{toc}{part}#1%
      \addcontentsline{tocaag}{part}#1%
      \addtocontents{tocaag}{\vskip-6pt}%
    \fi
    \markboth{}{}
\thispagestyle{empty}
\vbox{\vskip6pc}
    {\interlinepenalty \@M
\parindent=0pt
\parskip=0pt
     \reset@font
       \partnumberfont \partname~\thepart
   {\def\\ {\vskip1sp} \vskip 30\p@
\vskip-\the\baselineskip
     \Huge \baselineskip=22pt \bfseries\partfont #2\par}}%
    \@endpart}


%%%%%%%%%%
%
% New macro to print a TOC at a glance
%     by Toni Cortes (toni@ac.upc.es)

\def\shortTOC{\@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
 \fi\thispagestyle{plain} \@makeschapterhead{Contents at a Glance}
 \@afterheading
 \@starttoc{tocaag}\if@restonecol\twocolumn\fi\cleardoublepage}

%--------------------END phstyle.cls------------------------------
