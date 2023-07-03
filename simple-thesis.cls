% simple-thesis LaTeX class
% Author: Philip Darke <p.a.darke2@newcastle.ac.uk>

% Define class
\newcommand\filedate{2022/06/18}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{simple-thesis}[\filedate\space PhD thesis class]
\typeout{See https://github.com/philipdarke/simple-thesis}

% Define 'oneside' option
\RequirePackage{etoolbox}
\newtoggle{oneside}
\togglefalse{oneside}
\DeclareOption{oneside}{
    \toggletrue{oneside}
    \PassOptionsToClass{oneside}{book}
}

% Define 'draft' option
\newtoggle{draft}
\togglefalse{draft}
\DeclareOption{draft}{
    \toggletrue{draft}
    \PassOptionsToClass{draft}{book}
}

% Define 'pdf' option
\newtoggle{pdf}
\togglefalse{pdf}
\DeclareOption{pdf}{\toggletrue{pdf}}

% Pass through other options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

% Base class on 'book'
\LoadClass[
    12pt,  % size 12 font
    a4paper,  % A4 paper
]{book}

% Thesis metadata ----------------------------------------------------------------------

% Department
\newcommand{\@department}{}
\newcommand{\department}[1]{\renewcommand{\@department}{#1}}

% University
\newcommand{\@university}{}
\newcommand{\university}[1]{\renewcommand{\@university}{#1}}

% Degree
\newcommand{\@degree}{}
\newcommand{\degree}[1]{\renewcommand{\@degree}{#1}}

% Dedication
\newcommand{\@dedication}{}
\newcommand{\dedication}[1]{\renewcommand{\@dedication}{#1}}

% Hyperlinks ---------------------------------------------------------------------------

\RequirePackage[
    draft=false,  % create links when using draft package option
    hidelinks=true,  % do not colour links in final thesis
    linktocpage=true,  % page number is a hyperlink in table of contents
    breaklinks,  % allow hyperlinks to span across lines
    pdfusetitle,  % add title and author to PDF meta-data
]{hyperref}

\RequirePackage[all]{hypcap}  % ensure table/figure hyperlinks point to correct location
\RequirePackage{url}  % website links

% Acronyms and abbreviations -----------------------------------------------------------

\RequirePackage[
    acronym,
    toc,  % include in table of contents
    nogroupskip, % do not split into alphabetical groups
    nopostdot,  % do not terminate definitions with a full stop
    nonumberlist,  % do not include hyperlinks to text
    style=super,  % format acronyms page
]{glossaries}
\newglossary[nlg]{notation}{not}{ntn}{Notation}  % for notation
\loadglsentries[notation]{notation/notation}  % load notation entries
\makeglossaries
\setlength{\glsdescwidth}{\textwidth}  % use full page width for acronym definitions

% Do not hyperlink the first occurence of an acronym, see https://tex.stackexchange.com/questions/109122/latex-glossaries-hyperref-link-only-the-first-occurance-of-an-entry-in-each-sec
\renewcommand*{\glslinkcheckfirsthyperhook}{%
  \ifglsused{\glslabel}%
  {}%
  {%
    \setkeys{glslink}{hyper=false}%
  }%
}

% Custom notation style (show symbol instead of name)
\newglossarystyle{super-symbols}{%
    \setglossarystyle{super}%
    \renewcommand*{\glossentry}[2]{%
        \glstarget{##1}{\glossentrysymbol{##1}} & \glossentrydesc{##1}\tabularnewline
    }
}

% Bibliography -------------------------------------------------------------------------

\RequirePackage[
    citestyle=ieee,  % see https://www.overleaf.com/learn/latex/Biblatex_citation_styles
    bibstyle=ieee,  % see https://www.overleaf.com/learn/latex/Bibtex_bibliography_styles
    backend=biber,  % use biber engine
    sorting=nyt,  % sort references by author name, year then title, see https://www.overleaf.com/learn/latex/Bibliography_management_with_biblatex#Reference_guide for options
]{biblatex}

% Figures/tables -----------------------------------------------------------------------

% Tables
\RequirePackage{tabularx}  % control table widths
\RequirePackage{booktabs}  % better formatting
\RequirePackage{multirow}  % multi-row cells
\RequirePackage{longtable}  % span tables over pages
\RequirePackage[figuresright]{rotating}  % landscape tables/figures align with top to left of page
\RequirePackage{float}  % table placement with H
\RequirePackage{array}  % formatting cells
\RequirePackage{threeparttable}  % table footnotes

% Images/figures
\setkeys{Gin}{draft=false}  % show images when using draft package option
\RequirePackage{graphicx}
\graphicspath{  % LaTeX will look in the 'images/' and 'figures/' directories when building the PDF
    {images/}
    {figures/}
    {introduction/images/}
    {introduction/figures/}
    {chapter1/images/}
    {chapter1/figures/}
    {chapter2/images/}
    {chapter2/figures/}
    {chapter3/images/}
    {chapter3/figures/}
    {chapter4/images/}
    {chapter4/figures/}
    {chapter5/images/}
    {chapter5/figures/}
    {chapter6/images/}
    {chapter6/figures/}
    {chapter7/images/}
    {chapter7/figures/}
    {chapter8/images/}
    {chapter8/figures/}
    {conclusion/images/}
    {conclusion/figures/}
    {appendixa/images/}
    {appendixa/figures/}
    {appendixb/images/}
    {appendixb/figures/}
    {appendixc/images/}
    {appendixc/figures/}
    {appendixd/images/}
    {appendixd/figures/}
    {appendixe/images/}
    {appendixe/figures/}
}
\RequirePackage{xcolor}

% Format captions
\RequirePackage[font=small,position=bottom]{caption}
\RequirePackage[font=small,position=bottom]{subcaption}

% Mathematics --------------------------------------------------------------------------

\RequirePackage{bm}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}

% Customise style of vectors, matrices and tensors here
\newcommand{\vect}[1]{\bm{#1}}
\newcommand{\matr}[1]{\bm{#1}}
\newcommand{\tens}[1]{\bm{#1}}

% To-do notes --------------------------------------------------------------------------

% Set-up
\RequirePackage[
    obeyDraft,  % only show notes in draft thesis
    textsize=tiny,  % set small font size for notes
    colorinlistoftodos,  % show colour labels on the to-do list (see below)
]{todonotes}
\reversemarginpar  % place notes on inner margin if two-sided

% Note commands
\newcounter{notecounter}
\newcommand{\todonote}[1]{
    \stepcounter{notecounter}%
    \todo[color=green!40,bordercolor=green!40]{\thenotecounter:$\thinspace$#1}
}
\newcommand{\reference}[1]{
    \stepcounter{notecounter}%
    \todo[color=cyan!40,bordercolor=cyan!40]{\thenotecounter:$\thinspace$#1}
}
\newcommand{\issue}[1]{
    \stepcounter{notecounter}%
    \todo[color=magenta!40,bordercolor=magenta!40]{\thenotecounter:$\thinspace$#1}
}
\newcommand{\misc}[1]{
    \stepcounter{notecounter}%
    \todo[color=yellow!40,bordercolor=yellow!40]{\thenotecounter:$\thinspace$#1}
}

% Summary page with instructions
\RequirePackage{ifdraft}
\newcommand\crule[3][black]{\textcolor{#1}{\rule{#2}{#3}}}  % https://tex.stackexchange.com/questions/106984/how-to-draw-a-square-of-1cm-in-latex-filled-with-color
\newcommand{\maketodolist}{
    \listoftodos[To-do List]
    \ifdraft{
        \vspace{30pt}
        \noindent Adding notes:\vspace{12pt}\\
        \indent \crule[green!40]{14pt}{12pt} Use \texttt{\textbackslash todonote\{\}} for a \textbf{to-do}\\
        \indent \crule[cyan!40]{14pt}{12pt} Use \texttt{\textbackslash reference\{\}} to note a \textbf{missing reference}\\
        \indent \crule[magenta!40]{14pt}{12pt} Use \texttt{\textbackslash issue\{\}} to highlight a \textbf{problem}\\
        \indent \crule[yellow!40]{14pt}{12pt} Use \texttt{\textbackslash misc\{\}} to make a \textbf{miscellaneous note}
    }{}
}

% Index --------------------------------------------------------------------------------

\RequirePackage{makeidx}
\makeindex

% Lists --------------------------------------------------------------------------------

\RequirePackage[inline]{enumitem}  % format enumerate, itemize and description environments
\setlist{
    topsep=1em,
    itemsep=0ex,
    partopsep=1em,
}

% Other packages -----------------------------------------------------------------------

\RequirePackage[noabbrev]{cleveref}  % use \cref{} and \Cref{} to reference figures/tables/sections
\RequirePackage[final]{microtype}  % better typesetting
\RequirePackage{emptypage}  % remove all content from empty pages if two-sided
\RequirePackage{tocbibind}  % add list of figures etc to table of contents
\RequirePackage{pdflscape} % to rotate landscape PDF pages
\RequirePackage{soul} % to highlight text
% \RequirePackage{cfr-lm}  % uncomment to apply old style numerals to full document

% Newcastle thesis format --------------------------------------------------------------

% Page margins
\RequirePackage{geometry}
\geometry{
    margin=20mm,
    bindingoffset=10mm,  % i.e. 30mm on binding edge
    marginparwidth=26mm,  % for margin/to-do notes
}

% One and a 1/2 line spacing
\RequirePackage[onehalfspacing]{setspace}

% Chapter and section names should be title case
\RequirePackage{titlecaps}
\Addlcwords{and as but for if not nor or so yet}  % do not capitalise short conjunctions when using \titlecap
\Addlcwords{a an the}  % do not capitalise articles when using \titlecap
\Addlcwords{as at by for in of off on per to up via}  % do not capitalise short prepositions when using \titlecap
\Addlcwords{either else etc is neither then with}  % do not capitalise these words when using \titlecap
\newcommand{\thesischapter}[1]{\chapter[\titlecap{#1}]{\titlecap{#1}}}
\newcommand{\thesissection}[1]{\section[\titlecap{#1}]{\titlecap{#1}}}
\newcommand{\thesissubsection}[1]{\subsection[#1]{#1}}

% Add centered page numbers in footer
\RequirePackage{fancyhdr}
\pagestyle{fancy}  % use fancyhdr style pages
\renewcommand{\chaptermark}[1]{\markboth{\chaptername\ \thechapter.\ #1}{}}  % do not capitalise chapter in header
\renewcommand{\sectionmark}[1]{\markright{\thesection.\ #1}}  % do not capitalise section in header
\fancyhf{}  % clear header and footer
\fancyfoot[CE,CO]{\thepage}  % page number at bottom center
\pagenumbering{Roman}  % prevents having two "page 1"s etc in the PDF

% Format chapter/section/subsection headings
\RequirePackage{titlesec}
\RequirePackage{anyfontsize}  % more flexible font sizing
\titleformat{\chapter}[block]{\centering\bfseries\fontsize{14}{16.8}\selectfont}{\chaptername~\thechapter.}{7pt}{\bfseries}  % 14pt, bold, centered chapter headings
\titleformat{\section}[block]{\bfseries}{\thesection}{7pt}{\bfseries}  % 12pt bold section headings
\titleformat{\subsection}[block]{\bfseries\itshape}{\thesubsection}{7pt}{\bfseries}  % 12pt bold, italic sub-section headings

% Other formatting ---------------------------------------------------------------------

% Set pagestyle for each thesis section                                                 
\appto\frontmatter{\pagestyle{plain}}
\appto\mainmatter{\pagestyle{fancy}}
\appto\backmatter{\pagestyle{plain}}
\pagestyle{plain}  % for word count, to-do notes etc

% Chapter/section in header
\iftoggle{oneside}{
    % If one-sided...
    \fancyhead[L]{\textit\leftmark}  % chapter in italics at top left
}{
    % If two-sided...
    \fancyhead[LE]{\textit\leftmark}  % chapter in italics at top left
    \fancyhead[RO]{\textit\rightmark}  % section in italics at top right
}

% Increase gap between table rows for legibility
\renewcommand{\arraystretch}{1.25}

% Fix spacing issues in longtables
\BeforeBeginEnvironment{longtable}{\singlespacing}
\AfterEndEnvironment{longtable}{\onehalfspacing}

% Use small font for table notes
\BeforeBeginEnvironment{threeparttable}{\small}
\AfterEndEnvironment{threeparttable}{\normalsize}

% Restrict maximum width of table and figure captions
\newcommand{\normalcaptions}{\captionsetup{width=0.85\linewidth}}
\newcommand{\landscapecaptions}{\captionsetup{width=0.7\textheight}}  % for landscape tables/figures
\BeforeBeginEnvironment{sidewaystable}{\landscapecaptions}
\AfterEndEnvironment{sidewaystable}{\normalcaptions}
\BeforeBeginEnvironment{sidewaysfigure}{\landscapecaptions}
\AfterEndEnvironment{sidewaysfigure}{\normalcaptions}

% Use comma-separator when using \num, see https://tex.stackexchange.com/questions/179159/using-one-group-separator-for-integer-part-and-another-for-decimal-part-siunitx
\RequirePackage{siunitx}
\newif\ifSiunitxDecimal
\protected\def\SiunitxDecimalfalse{\global\let\ifSiunitxDecimal\iffalse}
\protected\def\SiunitxDecimaltrue{\global\let\ifSiunitxDecimal\iftrue}
\sisetup{
  output-decimal-marker={.\SiunitxDecimaltrue
    \aftergroup\aftergroup\aftergroup\SiunitxDecimalfalse
  },
  group-separator={\ifSiunitxDecimal\,\else{,}\fi},
  group-minimum-digits=3,
}

% Define \oldnum for old-style numbers
\newcommand{\oldnum}[1]{\oldstylenums{#1}}

% Update \quote, see https://tex.stackexchange.com/questions/356898/quote-with-author-reference-at-the-end
\let\oldquote\quote
\let\endoldquote\endquote
\renewenvironment{quote}[2][]
    {\if\relax\detokenize{#1}\relax
        \def\quoteauthor{#2}%
    \else
        \def\quoteauthor{#2~---~#1}%
    \fi
    \singlespacing
    \oldquote}
    {\par\nobreak\hfill\textit\quoteauthor\endoldquote\addvspace{\bigskipamount}}

% Preliminary pages --------------------------------------------------------------------

% Title page
\renewcommand{\maketitle}{
    \begin{titlepage}
        % Custom margins for page
        \ifboolexpr{togl{pdf}}{
            \newgeometry{top=50mm,bottom=40mm,left=25mm,right=25mm}
        }{
            \newgeometry{top=50mm,bottom=40mm,left=30mm,right=20mm}
        }
        \setstretch{2.25}
        \begin{center}
            % Title
            {\fontsize{28}{33.6}\selectfont \bfseries{\@title}}
            \vspace{40pt}
            % Logo
            \vfill
            \includegraphics[height=35mm]{images/logo}
            % Your details
            \vfill
            {\Large \@author}\\
            {\large \@department}\\
            {\large \@university}
            % Degree and date of submission
            \vfill
            {\large A thesis submitted for the degree of}\\
            {\large \emph{\@degree}}\\
            {\large \@date}
        \end{center}
    \end{titlepage}
    \restoregeometry  % restore margins
}

% Dedication page
\RequirePackage{ifthen}
\newcommand{\makededication}{
    % Only create dedication page if a dedication has been set
    \ifthenelse{\equal{\@dedication}{}}{}{
        % New page without header or footer
        \cleardoublepage
        \thispagestyle{empty}
        % Insert dedication in centre of page
        \hspace{0pt}
        \vfill
        \begin{center}
            \textit{\@dedication}  % dedication in italics
        \end{center}
        \vfill
        \hspace{0pt}
        \pagebreak
        % Reset header and footer for subsequent pages
        \clearpage
    }
}

% Word count page
\RequirePackage{verbatim}
\newcommand{\makewordcount}{
    \ifdraft{
        \chapter*{Word Count}
        \verbatiminput{wordcount.summary}
        Notes:
        \begin{itemize}
            \item Only the main thesis chapters contribute to the word count. Check that the
                  correct chapters are included above.
            \item Main content and words in captions/footnotes are counted.\footnote{Using
                  \texttt{texcount} with the argument \texttt{-sum=1,0,1}. Note that the \texttt{thesischapter}, \texttt{thesissection} and \texttt{thesissubsection} commands contribute to the word count (if this is important you probably have bigger problems).}
            \item Full word count output is saved to \texttt{wordcount.txt}.
            \item Consider the word count approximate.
        \end{itemize}
    }{}
}

% Abstract
\newcommand{\makeabstract}[1]{
    \input{#1}
    \ifdraft{
        \vfill
        \noindent \texttt{Abstract word count:~\input{wordcount.abstract}}
    }{}
}

% 'draft' package option ---------------------------------------------------------------

% Command to show hyperlinks in blue
\newcommand{\bluehyperlinks}{
    \hypersetup{
        colorlinks=true,
        linkcolor=blue,
        citecolor=blue,
        urlcolor=blue,
    }
}

% Environment to rotate PDF page, see https://tex.stackexchange.com/questions/40683/rotate-single-pdf-page-when-viewing
\newenvironment{rotatepage}%
    {
        \clearpage\pagebreak[4]\global\pdfpageattr\expandafter{\the\pdfpageattr/Rotate 90}
    }%
    {
        \clearpage\pagebreak[4]\global\pdfpageattr\expandafter{\the\pdfpageattr/Rotate 0}
    }%

\ifdraft{
    % Add draft stamp
    \RequirePackage{draftwatermark}
    \SetWatermarkLightness{0.96}
    \SetWatermarkScale{1.6}
    \SetWatermarkAngle{55}

    % Show page margins
    \geometry{showframe}
    \def\Gm@hrule{\color{gray!20}\hrule height 1pt depth\z@ width\textwidth}%
    \def\Gm@vrule{\color{gray!20}\vrule width 1pt height\textheight depth\z@}%
    \def\Gm@hruled{\color{gray!20}\hrule height\z@ depth1pt width\textwidth}%

    % Add line numbers
    \RequirePackage[
        pagewise,  % restart line numbers on each page
        mathlines,  % use line numbers in equations
        switch,  % place numbers opposite to to-do notes if two-sided
    ]{lineno}
    \linenumbers
    \iftoggle{oneside}{
        \rightlinenumbers*  % place numbers opposite to to-do notes if one-sided
    }{}

    % Update footer
    \RequirePackage[en-GB]{datetime2}
    \fancyfoot[L]{\texttt{Word count:~\input{wordcount.total}}}  % word count
    \fancyfoot[R]{\texttt{\DTMsetstyle{ddmmyyyy}\DTMNow}}  % date/time of PDF build
}{}

% 'draft' and 'pdf' package options ----------------------------------------------------

\ifboolexpr{togl{draft} or togl{pdf}}{
    % Show hyperlinks in blue
    \bluehyperlinks

    % Rotate pages with landscape tables and figures
    \BeforeBeginEnvironment{sidewaystable}{\begin{rotatepage}\landscapecaptions}
    \AfterEndEnvironment{sidewaystable}{\end{rotatepage}\normalcaptions}
    \BeforeBeginEnvironment{sidewaysfigure}{\begin{rotatepage}\landscapecaptions}
    \AfterEndEnvironment{sidewaysfigure}{\end{rotatepage}\normalcaptions}

    % Message on empty pages
    \def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
        \hspace{0pt}
        \vfill
        \begin{center}
            \small This page is intentionally blank
        \end{center}
        \vfill
        \hspace{0pt}
        \thispagestyle{empty}
        \newpage
        \if@twocolumn\hbox{}\newpage\fi\fi\fi}
}{}

% 'pdf' package options ----------------------------------------------------------------

% Remove binding offset but maintain same page size
\ifboolexpr{togl{pdf}}{
    \geometry{
        left=25mm,
        right=25mm,
        top=20mm,
        bottom=20mm,
        bindingoffset=0mm,
    }
}{}

