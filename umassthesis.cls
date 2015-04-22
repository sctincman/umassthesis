%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% LaTeX class file in conformance with the specifications set by the 
%% University of Massachusetts for dissertations
%% This class loads the standard report class and then modifies it as little as
%% possible. Adapted from umthesis.cls
%%
%%%%%%              NEWLY DEFINED COMMANDS
%% The goal with this class is to use standard LaTeX commands such as author
%% and title as much as possible, but several new commands were also necessary
%% COMMANDS
%% \makecopyright
%% \degree{doctor of philosophy or whater}
%% \previousdegree{one for each degree earned (including PhD) for abstract}
%% \program{name of program}
%% \committeemember{one for each normal committee member}
%% \outsidemember{one for each outside committee member}{affiliation}
%% \chaircommitteemember{for your chair}{title for abstract}
%% \cochaircommitteemember{use two of these if you have co-chairs}{title for abstract}
%% \listofappendices - generates list of appendices 
%%     - only use if you have more than one appendix
%%  
%% NAMES - for most commands and environments, there is also an associated
%% name, e.g. the preface environment uses the command \prefacename to
%% determine how it should be labeled. If you would prefer 'Prologue' instead
%% of 'Preface', you can change this by redefining \prefacename in the 
%% preamble of your LaTeX file, like so:
%%  \renewcommand{\prefacename}{Prologue}
%%
%%%%%%%%                 NEWLY DEFINED ENVIRONMENTS
%% frontispiece    - vertically centered, and horizontally centered, but
%%                   uses a flushright environment for typesetting quotes 
%% dedication      - vertically and horizontally centered
%% acknowledgments - for typesetting acknowledgements
%% preface         - typesets the preface
%% abstract        - typesets the abstract as it should be included in the 
%%                   dissertation
%%  
%%%%%%              DEPENDENCIES (REQUIRED PACKAGES)                  
%% This class requires several standard LaTeX packages
%% setspace  - easily and consistently set line spacing
%% ifthen    - required for internal class commands
%% hyperref  - provides support for all sorts of nifty and handy things, such 
%%             as pdf bookmarks and thumbnails, links from the table of 
%%             contents and links for references, citations, and indexing
%%
%%%%%%              PACKAGES KNOWN TO BE COMPATIBLE
%% natbib - better formatting for bibliographies
%% sectsty - for changing formatting of section headings
%% graphics, graphicx - for including graphics files
%%                      note that regular latex can only include .eps files
%%                      pdflatex can import .png, .jpg, .pdf, but not .eps
%%                      To include .eps with pdflatex use the epstopdf package
%%                        and run as 'pdflatex --shell-escape' (requires gs)
%% tipa               - for phonetic fonts
%% tabularx           - advanced tabular environments

%%%%%%              INCOMPATIBILITIES
%% fncycchap
%% titlesec
%%%%%%                    ACKNOWLEDGEMENTS                             
%% Thanks to the writers of the umthesis.cls and umthesis.sty 
%% from which much of this was stolen
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%foo
\newcommand{\filename}{umassthesis}
\newcommand{\fileversion}{$Revision: 1 $}
\newcommand{\filedate}{2014/10/21}
\newcommand{\fileauthor}{$Author: sctincman $}

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{\filename}[\filedate \fileversion %
  : University of Massachusetts thesis class - based on report]

\RequirePackage{setspace} %for spacing
\RequirePackage{ifthen} % advanced control structures
\RequirePackage{etex} % enable advanced tex features, particularly don't limit the number of dimensions to 256

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

% These are the default options.
\ExecuteOptions{12pt,openany,oneside}
\ProcessOptions\relax

\PassOptionsToClass{oneside,openany}{report}

\LoadClass[letterpaper]{report}

\renewcommand\l@chapter{\protect\vskip1em \@dottedtocline{0}{0em}{1.5em}}
\newcommand\prefacename{Preface}
\renewcommand\abstractname{Abstract}
\newcommand\dedicationname{Dedication}
\renewcommand\contentsname{Table of Contents}
\newcommand\acknowledgmentsname{Acknowledgments}
\newcommand\listappendixname{List of Appendices}
\renewcommand\appendixname{Appendix} % JH uncommented and amended this
\newcommand\appendicesname{Appendices}

% Set up page layout.
\pagestyle{plain}
\setlength{\textwidth}{6in}
\setlength{\textheight}{9in}
% Other margins. T.G.: all other margins must be at least 1 inch.
\setlength{\topmargin}{0in}
\setlength{\headheight}{0in}
\setlength{\headsep}{0in}
\setlength{\footskip}{.5in}
\doublespacing

%% Appendix related
\newif\if@appendix
\newcommand{\ext@toc}{toc}
\newif\if@appendices \@appendicestrue
% JH: added appendices flag above to handle multiple appendices.  Becomes true if \listofappendicies is called.
% Authors: use \mainmatter before the main content
%\renewcommand{\mainmatter}{%
%  \cleardoublepage%
%  \@mainmattertrue%
%  \pagestyle{plain}
%  \setcounter{page}{1}%
%  \pagenumbering{arabic}%
%}
\renewcommand\appendix{%
  \phantomsection
  \clearpage%
  \@appendixtrue%
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \renewcommand{\chaptername}{}
  \gdef\@chapapp{\appendixname}%
  \if@appendices % JH added this line
  \else % JH added this line
  	\setcounter{chapter}{\m@ne}% JH added this line to make appendix unnumbered
  \fi % JH added this line 	
  \gdef\thechapter{\@Alph\c@chapter}% JH added this line

  % the hypersetup command will tell hyperref to make bookmarks based on the 
  % list of appendices
  \hypersetup{bookmarkstype={loa}} 
  \def\ext@toc{loa}%
  \if@appendices % JH added this
      \addcontentsline{toc}{chapter}{\appendicesname}% original line
      \appendixpage % JH remove this line and uncomment line below if appendix page is required/desired even when only one appendix
  \else	% JH added this
      \addcontentsline{toc}{chapter}{\appendixname}% JH added this
  \fi % JH added this
  %\appendixpage% JH: uncomment this line if appendix page is required/desired even when only one apendix
}

%% T.G. : An appendix page is required before the appendices.
\newcommand{\appendixpage}{%
  \thispagestyle{plain}
  \vspace*{\fill}
  \begin{center}{\heading \if@appendices \appendicesname \else \appendixname \fi}\end{center}% JH added appendixname alternative
  \vspace*{\fill}
  \clearpage%
}

%% Headings of chapters and sections and such
\newcommand{\heading}{\bf\MakeUppercase}

\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\bfseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\bfseries}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\bfseries}}                         

\renewcommand\chapter{
  \if@openright\cleardoublepage\else\clearpage\fi
  \thispagestyle{plain}%
  \global\@topnum\z@
  \@afterindentfalse
  \secdef\@chapter\@schapter
}

\def\@chapter[#1]#2{
  \refstepcounter{chapter}%
  \typeout{\@chapapp\space\thechapter.}%
  \addcontentsline{toc}{chapter}{\protect\numberline{\thechapter}#1}%
  \chaptermark{#1}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \addtocontents{los}{\protect\addvspace{10\p@}}%
  \@makechapterhead{#2}%
  \@afterheading
}

\def\@schapter#1{
  \@makeschapterhead{#1}%
  \@afterheading
}

\renewcommand{\@makechapterhead}[1]{%
  \begin{singlespace}
  \vspace*{.5in}%
  {
    \begin{center}
      \normalfont
      \bf\MakeUppercase\@chapapp\ \thechapter\\[.5em]
      \bf\MakeUppercase{#1}\\[1em]
    \end{center}
  }
  \end{singlespace}
}

\renewcommand{\@makeschapterhead}[1]{%
  \begin{singlespace}
  \vspace*{.5in}%
  {
    \begin{center}
      \bf\MakeUppercase{#1}\\[1em]
    \end{center}
  }
  \end{singlespace}
}


%% Table of contents and other lists
\renewcommand\listoftables{%
  \chapter*{\listtablename}%
  \begin{singlespace}
    \addcontentsline{toc}{chapter}{\listtablename}%
    \@mkboth{\listtablename}\listtablename{}
    \vskip 1em
           {\parindent \z@ \raggedright \bf Table{}\par}
           \@starttoc{lot}%
  \end{singlespace}
}

\renewcommand\listoffigures{%
  \chapter*{\listfigurename}%
  \begin{singlespace}
    \addcontentsline{toc}{chapter}{\listfigurename}%
    \@mkboth{\listfigurename}{\listfigurename}
    \vskip 1em
           {\parindent \z@ \raggedright \bf Figure{}\par}
           \@starttoc{lof}%

  \end{singlespace}
}

\newcommand\listofschemess{%
  \chapter*{\listschemename}%
  \begin{singlespace}
    \addcontentsline{toc}{chapter}{\listschemename}%
    \@mkboth{\listschemename}{\listschemename}
    \vskip 1em
           {\parindent \z@ \raggedright \bf Scheme{}\par}
           \@starttoc{los}%

  \end{singlespace}
}

\renewcommand\tableofcontents{%
  \chapter*{\contentsname
    \@mkboth{\contentsname}\contentsname{}}%
  \begin{singlespace}
    \pdfbookmark[0]{\contentsname}{contents}
    \@starttoc{toc}%
  \end{singlespace}
}

% There is likely a better way to do this, by accessing a depth counter of somesort
\newcount\lasttocdepth
\lasttocdepth=0

\def\@dottedtocline#1#2#3#4#5{%
  \ifnum #1>\c@tocdepth \else
    \ifnum #1=\lasttocdepth
      \vskip \z@ \@plus.2\p@
    \else
      \lasttocdepth=#1
      \vskip 1.0em \@plus\p@
    \fi
    {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
     \parindent #2\relax\@afterindenttrue
     \interlinepenalty\@M
     \leavevmode
     \@tempdima #3\relax
     \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
     \ifnum #1=0
       \uppercase{#4}\nobreak
     \else
       {#4}\nobreak
     \fi
     \leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
        mu$}\hfill
     \nobreak
     \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
     \par}%
  \fi}



%% this is adapted from umthesis.cls. It defines the additional necessary
% commands for creating the title page and other frontmatter material, e.g.
% preface, copyright, signature page

\newif\iffirstcochair\firstcochairtrue

\newtoks\signaturetokenlist
\newtoks\abstokenlist
\newtoks\degreetokenlist
\signaturetokenlist{}
\abstokenlist{}
\degreetokenlist{}

\def\previousdegree#1{
  \addto@hook{\degreetokenlist}{#1\\}}

\def\chaircommitteemember#1#2{
  \def\abschairname{Chair:}
  \def\chairtitle{#2}
  \addto@hook{\signaturetokenlist}
             {\\[2em]\rule[.1em]{3in}{.1pt}\\
               #1, Chair\\}%
  \addto@hook{\abstokenlist}{#2 #1}}

\def\cochaircommitteemember#1#2{
  \def\abschairname{Co-Chairs:}%
  \addto@hook{\signaturetokenlist}
             {\\[2em]\rule[.1em]{3in}{.1pt}\\
               #1, Co-Chair\\}%
  \iffirstcochair\addto@hook{\abstokenlist}{#2 #1 }
  \else\addto@hook{\abstokenlist}{and #2 #1}\fi
  \firstcochairfalse}

\def\committeemember#1{
  \addto@hook{\signaturetokenlist}
             {\\[2em]\rule[.1em]{3in}{.1pt}\\
               #1, Member\\}}

\def\outsidemember#1#2{
  \addto@hook{\signaturetokenlist}
             {\\[2em]\rule[.1em]{3in}{.1pt}\\
               #1, Outside Member\\#2\\}}

\newcommand\degree[1]{\gdef\@degree{#1}}
\newcommand\program[1]{\gdef\@program{#1}}

\newcommand\depthead[2]{
  \gdef\@deptheadname{#1}
  \gdef\@deptheaddept{#2}
}

\renewcommand\maketitle{
  \newpage
  \thispagestyle{empty}
  \pagenumbering{roman}
  \pdfbookmark[0]{Title}{title}
  \begin{singlespace}
    \let\footnotesize\small
    \let\footnoterule\relax
    \vspace*{1in}
    \begin{center}%
      {\bf \MakeUppercase\@title \par}%
    \end{center}
    \vfill
    \centerline{A Dissertation Presented}
    \vspace*{2em}
    \centerline{by}
    \vspace{2em}
    \begin{center}%
      {\MakeUppercase\@author}
    \end{center}
    \vfill
    \begin{center}%
      Submitted to the Graduate School of the\@centercr
      University of Massachusetts Amherst in partial fulfillment\@centercr
      of the requirements for the degree of\@centercr
      \vspace*{1em}
      \MakeUppercase\@degree\@centercr
      \vspace*{1em}
      \@date\@centercr
      \vspace*{1em}
      \@program\@centercr
    \end{center}
  \end{singlespace}
  \vspace*{\fill}
  \null
  \setcounter{footnote}{0}%
  \newpage
}

\newcommand{\makecopyright}{
  \newpage
  \thispagestyle{empty}
  \vspace*{7.5in}
  \begin{center}
    \copyright\ Copyright by \@author\ \number\year\@centercr
    \vspace*{1em}
    All Rights Reserved\@centercr
    \vspace*{1em}
  \end{center}
  \vspace*{\fill}
  \newpage
}

\newcommand\makesignature{
  \newpage
  \thispagestyle{empty}
  \begin{singlespace}
    \vspace*{1in}
    \begin{center}%
      {\bf \MakeUppercase\@title \par}%
      \vfill
          {A Dissertation Presented}\\[1em]
          {by}\\[1em]
          {\MakeUppercase\@author}
    \end{center}
    \vfill
    Approved as to style and content by:\\
    \the\signaturetokenlist
    \begin{flushright}
      \vfill
      \rule[.1em]{3in}{.1pt}\\
      \parbox{3in}
      {
        \begin{flushleft}
          \@deptheadname, Department Head\\
          \@deptheaddept
        \end{flushleft}
      }
    \end{flushright}
  \end{singlespace}
  \newpage
}

\newenvironment{frontispiece}{%
  \newpage
  \thispagestyle{empty}
  \vspace*{\fill}
  %\hspace*{\fill}
  \begin{minipage}{.7\textwidth}
    \begin{flushright}
}{%
    \end{flushright}
  \end{minipage}
  \vspace*{\fill}
  %\hspace*{\fill}
  \newpage
}

\newenvironment{dedication}{%
   \newpage
   \thispagestyle{empty}
   \vspace*{\fill}
   \begin{center}
}{%
   \end{center}
   \vspace*{\fill}
   \newpage
}

\newenvironment{acknowledgments}{
  \newpage
  \chapter*{\acknowledgmentsname\@mkboth{\acknowledgmentsname}\acknowledgmentsname{}}
  \addcontentsline{toc}{chapter}{\acknowledgmentsname}
}{
  \newpage
}

\newenvironment{preface}{%
  \newpage
  \chapter*{\prefacename\@mkboth{\prefacename}\prefacename{}}
  \addcontentsline{toc}{chapter}{\prefacename}
}{
  \newpage
}

\renewenvironment{abstract}{%
  \newpage
  \chapter*{\abstractname\@mkboth{\abstractname}{\abstractname}}
  \addcontentsline{toc}{chapter}{\abstractname}
  \begin{center}
    \begin{doublespace}
      \begin{singlespace}
        \MakeUppercase\@title\\
      \end{singlespace}
      \MakeUppercase\@date\\
      \MakeUppercase{\@author, }
      \MakeUppercase{\the\degreetokenlist}
      Directed by: \the\abstokenlist\\
    \end{doublespace}
  \end{center}
}{
  \newpage
}

\renewenvironment{thebibliography}[1]{
\def\ext@toc{toc}
      \phantomsection %makes sure it points to the right page
     \clearpage
\hypersetup{bookmarkstype={toc}}
  \begin{singlespace}
      \if@appendices
        \clearpage%
        \phantomsection
        \thispagestyle{plain}
        \addcontentsline{toc}{chapter}{\bibname}
	\vspace*{\fill}
	\begin{center}{\heading \bibname}\end{center}%
	\vspace*{\fill}
	\clearpage
      \else
        \chapter*{\bibname}%
        \addcontentsline{toc}{chapter}{\bibname}
      \fi
      \@mkboth{\bibname}{\bibname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m%
     }%
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist
  \end{singlespace}
}
% natbib is a commonly used package for formatting bibliographies. 
% If using natbib, then we must redefine some things in this way
\AtBeginDocument{%
  \@ifpackageloaded{natbib}{
    \renewcommand{\bibsection}{
      \hypersetup{bookmarkstype={toc}}
      \@mkboth{\bibname}{\bibname}%
      % if we use an a half page for appendices, then we also do so for 
      % bibliography
      \if@appendices
        \clearpage%
        \phantomsection
        \thispagestyle{plain}
        \addcontentsline{toc}{chapter}{\bibname}
	\vspace*{\fill}
	\begin{center}{\heading \bibname}\end{center}%
	\vspace*{\fill}
	\clearpage
      \else
        \chapter*{\bibname}%
        \addcontentsline{toc}{chapter}{\bibname}
      \fi
    }
  }{}
}
% makes lists single spaced, and more compact
% copying from tweaklist.sty

\def\enumhook{}
\def\enumhooki{}
\def\enumhookii{}
\def\enumhookiii{}
\def\enumhookiv{}
\def\itemhook{}
\def\itemhooki{}
\def\itemhookii{}
\def\itemhookiii{}
\def\itemhookiv{}
\def\descripthook{}
\def\enumerate{%
  \ifnum \@enumdepth >\thr@@\@toodeep\else
    \advance\@enumdepth\@ne
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
      \expandafter
      \list
        \csname label\@enumctr\endcsname
        {\usecounter\@enumctr\def\makelabel##1{\hss\llap{##1}}%
          \enumhook \csname enumhook\romannumeral\the\@enumdepth\endcsname}%
  \fi}
\def\itemize{%
  \ifnum \@itemdepth >\thr@@\@toodeep\else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \expandafter
    \list
      \csname\@itemitem\endcsname
      {\def\makelabel##1{\hss\llap{##1}}%
        \itemhook \csname itemhook\romannumeral\the\@itemdepth\endcsname}%
  \fi}

\renewenvironment{description}
                 {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                          \let\makelabel\descriptionlabel\descripthook}}
                 {\endlist}
\renewcommand{\itemhook}{\setstretch{1}
  \setlength{\topsep}{0pt}%
  \setlength{\parskip}{0pt}%
  \setlength{\partopsep}{.5\baselineskip}%
  \setlength{\parsep}{0pt}%
  \setlength{\itemsep}{0pt}%
}

% enumerate environment lengths
\renewcommand{\enumhook}{\setstretch{1}
  \setlength{\topsep}{0pt}%
  \setlength{\parskip}{0pt}%
  \setlength{\partopsep}{0pt}%
  \setlength{\parsep}{0pt}%
  \setlength{\itemsep}{0pt}%
}

%%%%% hyperref must be loaded last, because it redefines lots of internals. 
%% So far there do not seem to be any conflicts though
\RequirePackage{hyperref}
