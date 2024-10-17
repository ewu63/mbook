\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mbook}[2023/01/01 UMich Dissertation Template based on Kaobook]

\PassOptionsToClass{\CurrentOption}{kaobook}
\LoadClass[
    letterpaper,
    numbers=noenddot, % remove dot at end of chapter/section number headings
    fontsize=12pt, % Base font size
    open=right,
    % twoside=false, % Use different layouts for even and odd pages (in particular, if twoside=true, the margin column will be always on the outside)
]{kaobook}


% Set spacing
\onehalfspacing

% set margins
\renewcommand{\marginlayout}{
    \newgeometry{
        top=1in,
        bottom=1in,
        inner=1in,
        textwidth=4in,
        marginparsep=0.25in,
        marginparwidth=2.25in,
    }
    \recalchead%
	\widelayoutfalse%
}

% Choose the language
\RequirePackage[english]{babel}
\RequirePackage[english=american]{csquotes}

% Load the bibliography package
\RequirePackage[
    style=numeric,
]{kaobiblio}

% Load mathematical packages for theorems and related environments
\RequirePackage{kaotheorems}

% Load the package for hyper references
\RequirePackage{kaorefs}

% Title page
%% ---- TITLE PAGE -----------------------------------------------------
% The fields to be used for the title page
\renewcommand{\@title}{Insert a Title!}
\renewcommand{\@author}{Insert an Author!}
\newcommand{\@degree}{Doctor of Philosophy}
\newcommand{\@year}{Insert the year!}
\newcommand{\@department}{Insert a Department Name!}
\newcommand{\@committee}{Insert a Committee!}

% Commands to set the titlepage fields
\renewcommand{\title}[1]{\renewcommand{\@title}{#1}}
\renewcommand{\author}[1]{\renewcommand{\@author}{#1}}
\newcommand{\Degree}[1]{\renewcommand{\@degree}{#1}}  % clash with SIunits
\newcommand{\Year}[1]{\renewcommand{\@year}{#1}}
\newcommand{\department}[1]{\renewcommand{\@department}{#1}}
\newcommand{\committee}[1]{\renewcommand{\@committee}{#1}}

% Commands for the user to be able to use the defined fields.
\newcommand{\inserttitle}{\@title}
\newcommand{\insertauthor}{\@author}
\newcommand{\insertdegree}{\@degree}
\newcommand{\insertdepartment}{\@department}
\newcommand{\insertcommittee}{\@committee}
\newcommand{\insertyear}{{\number\@year}}

% This redefines the title page to automatically have all of the
% features and properties that it should according to the guidelines.
\renewcommand*{\maketitle}{
    \pdfbookmark[0]{\@title}{title}%title to PDF bookmark
    \begin{titlepage}
 % Use single-spaced lines for the title page.
 \begin{singlespace} %
  % Setting top margin to be roughly 2.5 in
  \hbox{\vspace{1.0in}} %
  % Center the title page as well.
  \begin{center} %
   % Put the title itself in 1.5-spaced format.
   \begin{onehalfspacing}
    % Insert the title.
    {\Large\bfseries\inserttitle} %
   \end{onehalfspacing} \\[4ex] %
   % Vertical rubber space
%   \vfill %
   % Print the word 'by'.
   by \\[2ex] %
   % Insert the author
   \insertauthor \\ %
   % More rubber space
   \vfill %
   % Text from guidelines
   A dissertation submitted in partial fulfillment \\ %
   of the requirements for the degree of \\ %
   % Name of degree
   \insertdegree \\ %
   % Department
   (\insertdepartment) \\ %
   in the University of Michigan \\ %
   % Year of completion
   \insertyear %
  \end{center} %
  % More rubber space
  \vfill %
  % Non-justified content
  \begin{flushleft}
   % Heading for the committee
   % \hspace{1in}Doctoral Committee: \\[2ex] %
   Doctoral Committee: \\[4ex] %
   % Horizontal spacing
   \hspace{0.4in} %
   % Insert the committee (in a box).
   \parbox{5.5in}{\insertcommittee}
  \end{flushleft} %
 \end{singlespace} %
\end{titlepage}
}


% ---- COPYRIGHT PAGE -------------------------------------------------
% Command that holds the name of the copyright holder
\newcommand{\@copyright}{\@author}
\newcommand{\@orcid}{Insert an ORCID!}
\newcommand{\@uniqname}{}

% Command to change it from the default
\newcommand{\copyrightholder}[1]{\renewcommand{\@copyright}{#1}}
\newcommand{\orcid}[1]{\renewcommand{\@orcid}{#1}}
\newcommand{\uniqname}[1]{\renewcommand{\@uniqname}{#1}}

% Special handling to permit empty uniqname
\newif\ifuniqname
\uniqnamefalse
\def\@uniqname{}
\newcommand{\uniqnamecheck}{%
    \ifx\@uniqname\empty
    \uniqnamefalse
    \else
    \uniqnametrue
    \fi
}

% Command to insert it
\newcommand{\insertcopyrightholder}{\@copyright}
\newcommand{\insertorcid}{ORCID iD: \@orcid}
\newcommand{\insertuniqname}{\@uniqname{@umich.edu}}

% Command for copyright page
\newcommand*{\copyrightpage}{ %
 % Insert the titlepage formatting.
 \titlepage %
 % Center the page.
 \begin{center} %
  % Vertical rubber space
  \ \vfill %
  % Insert the frontispiece.
  \insertauthor \\[2ex] %
  \uniqnamecheck
  \ifuniqname\insertuniqname \\[2ex] \else\fi
  \insertorcid \\[2ex] %
  \ \\[2ex] %
  \copyright\ \insertcopyrightholder\ \insertyear \\
  % Vertical rubber space
  \vfill %
 \end{center} %
}

% ---- Frontispiece -------------------------------------------------

\renewcommand{\frontispiece}[1]{%
  \titlepage
  \begin{center}
    \ \vfill
    \includegraphics[width=\textwidth]{#1}
    \ \vfill
  \end{center}
}

% ---- Dedication -----------------------------------------------------

\renewcommand{\dedication}[1]{
    \cleardoubleevenpage
    \pagestyle{pagenum.scrheadings}% Use a plain style for the header and the footer
    \renewcommand*{\chapterpagestyle}{pagenum.scrheadings}
    \thispagestyle{empty}
    \setcounter{page}{3} % this is page 2
    \phantomsection\addcontentsline{toc}{chapter}{Dedication} % add to TOC
    \begin{center}
        \vspace*{1.5in}
        \large
        #1
    \end{center}
}

% add margintoc to each chapter
\newcommand{\mychapter}[1]{
    \setchapterpreamble[u]{\margintoc}
    \chapter{#1}
}
% include only sections to margin TOC
\setcounter{margintocdepth}{\sectiontocdepth}

% rename ToC
\renewcaptionname{english}{\contentsname}{Table of Contents}

% set chapter top margin to 2in
% don't ask me why 1.1in == 2in here
\renewcommand{\chapterheadstartvskip}{\vspace*{1.1in-\topskip}}

% acronym
\setabbreviationstyle[acronym]{long-postshort-sc-user}


% only hyperlink short
\glssetcategoryattribute{acronym}{nohyperfirst}{true}
\renewcommand*{\glsxtruserparen}[2]{%
  \glsxtrfullsep{#2}% space between long part and parenthetical material
  (\glshyperlink[#1]{#2})%
}

% remove autodot at end of captions
\renewcommand*{\figureformat}{%
  \figurename~\thefigure%
%  \autodot% DELETED
}

% set numbering down to subsubsection
\setcounter{secnumdepth}{\subsubsectionnumdepth}

% set glossary abbreviation to all caps
\glssetcategoryattribute{acronym}{glossname}{uc}

% center floats
\BeforeBeginEnvironment{tabular}{\footnotesize\centering}
\BeforeBeginEnvironment{tabular*}{\footnotesize\centering}


%% ---- LIST OF APPENDICES ---------------------------------------------
\renewcommand*{\listofalgorithms}{\listoftoc[List of Algorithms]{loa}}
\newcommand*{\listofappendices}{\listoftoc[List of Appendices]{loap}}
% add those to TOC
\setuptoc{loa}{totoc}
\setuptoc{loap}{totoc}


% add each appendix chapter to a separate list
\newcommand{\myappchapter}[1]{
    \setchapterpreamble[u]{
        \addcontentsline{loap}{chapter}{\protect\numberline{\thechapter}#1}
    }
    \chapter{#1}
}


% allow hyperlink in headers
\glssetcategoryattribute{acronyms}{headuc}{true}
\glsdefpostlink{acronyms}{\glsxtrpostlinkAddDescOnFirstUse}
% \renewcommand{\glsxtrtitleopts}{}

% Modify cleveref to always say section instead of subsection etc.
\crefname{subsection}{section}{sections}
\Crefname{subsection}{Section}{Sections}
\crefname{subsubsection}{section}{sections}
\Crefname{subsubsection}{Section}{Sections}
% make font for equation references match surrounding text, but remove the parenthesis
\creflabelformat{equation}{#2#1#3}

% single space for figures and tables
\captionsetup[table]{font={stretch=1.0}}
\captionsetup[figure]{font={stretch=1.0}}

% slightly alter the definition so that we can call this inside the document
\renewcommand{\formatmargincitation}[1]{%
    \parencite{#1}: \citeauthor*{#1} (\citefield{#1}{year}), \citefield{#1}[emph]{title}%
    }

% number bookmarks
\bookmarksetup{numbered}

% center the chapter headings
\makeatletter
\if@twoside
\else%
  \KOMAoption{chapterprefix=true}
  \AtBeginDocument{\renewcommand*{\raggedchapter}{\centering}}
\fi%
\makeatother

% make chapter heading prefix smaller than chapter heading font
\setkomafont{chapterprefix}{\Large}

% make header and footer upright
\setkomafont{pagehead}{\small\scshape}
\setkomafont{pagefoot}{\small\upshape}