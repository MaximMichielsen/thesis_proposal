% This template aims to simplify and improve the (Xe)LaTeX template provided
% by the TU Delft. Original template by TU Delft. Rewritten template by Daan
% Zwaneveld (https://dzwaneveld.github.io)
%
% This template by Daan Zwaneveld is licensed under CC BY-NC 4.0. To view a
% copy of this license, visit https://creativecommons.org/licenses/by-nc/4.0/.
% No attribution is required in PDF outputs created using this template.

%% ----------------------------------------------------------------------
%%    Setting up the class, main packages and basic definitions
%% ----------------------------------------------------------------------

%% Class is based on the default book class and options will be passed
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tudelft-report}[05-09-2024 v1.7.1 TU Delft Report Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[10pt,oneside]{book}

%% Main packages in the document --- Some are imported later in the class file
\RequirePackage{mathtools}  % Mathematical tools to use with amsmath
\RequirePackage{amssymb}    % Extended symbol collection
\RequirePackage{siunitx}    % Comprehensive (SI) units package

\RequirePackage{tabularx}   % Tabulars with adjustable-width columns
\RequirePackage{booktabs}   % Publication quality tables
\RequirePackage{longtable}  % Allow tables to flow over page boundaries
\RequirePackage{multirow}   % Create tabular cells spanning multiple rows

\RequirePackage{graphicx}   % Enhanced support for images
\RequirePackage{float}      % Improved interface for floating objects
\RequirePackage[labelfont=bf,justification=centering,footnotesize]{caption} % Captions

\RequirePackage{subcaption} % Support for sub-captions
\RequirePackage{pdfpages}   % Include PDF documents

\RequirePackage[pdfusetitle,hidelinks]{hyperref} % Extensive support for hypertext
\RequirePackage[noabbrev]{cleveref} % Intelligent cross-referencing
\RequirePackage{xcolor}     % Driver-independent color extensions
\RequirePackage{tikz}       % Create PostScript and PDF graphics
\RequirePackage{xspace}     % Define commands that appear not to eat spaces
\RequirePackage[
  top=2.5cm,        % your existing margins
  headheight=23.12pt,  % set here instead
  % ... other options
]{geometry}
\addtolength{\topmargin}{-9.12pt}
% Customize document dimensions
\RequirePackage{titlesec}   % Select alternative section titles
\RequirePackage{titletoc}   % Alternative headings for toc
\RequirePackage{fancyhdr}   % Control of page headers and footers
\RequirePackage{enumitem}   % Control layout of itemize, enumerate, description
\RequirePackage{etoolbox}   % Toolbox of programming facilities
\RequirePackage{iftex}      % Adds if-else statements to support multiple compilers
\RequirePackage{datetime}   % Change format of \today

\RequirePackage{enumitem}



%% Establish commands for the subtitle, subject, affiliation, cover image and table of authors
\newcommand*{\subtitle}[1]{\def\@subtitle{#1}}
\newcommand*{\subject}[1]{\def\@subject{#1}}
\newcommand*{\affiliation}[1]{\def\@affiliation{#1}}
\newcommand*{\coverimage}[1]{\def\@coverimage{#1}}
\newcommand*{\covertable}[1]{\def\@covertable{#1}}

%% Scale the margins to be slightly smaller than default (.7)
\geometry{a4paper,hscale=0.75,vscale=0.8}

%% ----------------------------------------------------------------------
%%    Setting up the fonts
%% ----------------------------------------------------------------------

\ifPDFTeX
    %% pdfLaTeX: Palatino-like body + Roboto Slab titles
%    \RequirePackage[T1]{fontenc}
    \RequirePackage{newpxtext}
    \RequirePackage{newpxmath}

    \newcommand{\titlestyle}{%
        \fontfamily{RobotoSlab-TLF}\fontseries{light}\selectfont}
    \newcommand{\largetitlestyle}{%
        \fontfamily{RobotoSlab-TLF}\fontseries{thin}\selectfont}

\else
    %% XeLaTeX / LuaLaTeX: Source Serif 4 body + Roboto Slab titles

    \RequirePackage{fontspec}

    % --------------------
    % Body font
    % --------------------

     \setmainfont{Cambria}[
    Path = {fonts/cambria/},
    UprightFont    = {CAMBRIA.TTC},
    BoldFont       = {CAMBRIAB.TTF},
    ItalicFont     = {CAMBRIAI.TTF},
    BoldItalicFont = {CAMBRIAZ.TTF}
 ]

%    \setmainfont{Source Serif 4}[
%        Path = {fonts/Source_Serif_4/static/},
%        UprightFont    = {SourceSerif4_18pt-Regular.ttf},
%        BoldFont       = {SourceSerif4_18pt-Bold.ttf},
%        ItalicFont     = {SourceSerif4_18pt-Italic.ttf},
%        BoldItalicFont = {SourceSerif4_18pt-BoldItalic.ttf}
%    ]


    % --------------------
    % Math sans / mono (unchanged TU Delft style)
    % --------------------
%    \setmathsf{Arial}
%    \setmathtt{Arial}

    % --------------------
    % Title fonts
    % --------------------
    \newfontfamily\titlestyle{Roboto Slab}[
        UprightFont = *-Light,
        BoldFont    = *-Regular
    ]

    \newfontfamily\largetitlestyle{Roboto Slab}[
        UprightFont = *-Thin,
        BoldFont    = *-Light
    ]

    % --------------------
    % Cover-only font
    % --------------------
    \newfontfamily\coverfont{Roboto}

\fi

%% ----------------------------------------------------------------------
%%    Formatting colored boxes
%% ----------------------------------------------------------------------

\RequirePackage{xcolor}
\RequirePackage[framemethod=TikZ]{mdframed}

\definecolor{sub}{RGB}{220,235,255}        % light fill

\newmdenv[
  backgroundcolor=sub,
  linewidth=1.5pt,
  linecolor=titlecolor,
  roundcorner=8pt,
  innertopmargin=10pt,
  innerbottommargin=10pt,
  innerleftmargin=12pt,
  innerrightmargin=12pt,
  skipabove=10pt,
  skipbelow=10pt,
]{blueboxbase}

% Wrapper with a real title row
\newenvironment{bluebox}[1]{%
  \begin{blueboxbase}%
  \textbf{\color{titlecolor}#1}\par\smallskip
}{%
  \end{blueboxbase}%
}

%% ----------------------------------------------------------------------
%%    Formatting the hyperlinks
%% ----------------------------------------------------------------------

\definecolor{linkblue}{HTML}{1F5FD1}

\RequirePackage{hyperref}
\hypersetup{
    colorlinks=true,
    linkcolor=linkblue,
    citecolor=linkblue,
    urlcolor=linkblue
}

% Make TOC links black (hyperref otherwise overrides titletoc styling)
\let\oldtableofcontents\tableofcontents
\renewcommand{\tableofcontents}{%
  {\hypersetup{linkcolor=black}\oldtableofcontents}%
}

%% ----------------------------------------------------------------------
%%    Formatting the titles
%% ----------------------------------------------------------------------

\definecolor{titlecolor}{HTML}{4884d6} % Color for cover title

\RequirePackage{titlesec}

\titleformat{\chapter}[display]
  {\flushright\color{titlecolor}}
  {\fontsize{64}{72}\selectfont\largetitlestyle\thechapter}
  {0pt}
  {\Huge\titlestyle}

\titlespacing*{\chapter}{0pt}{0pt}{2\baselineskip}

\titleformat{\section}
  {\Large\titlestyle\color{titlecolor}}
  {\thesection.}
  {0.75em}
  {}

\titleformat{\subsection}
  {\large\titlestyle\color{titlecolor}}
  {\thesubsection.}
  {0.75em}
  {}

\titleformat{\subsubsection}
  {\titlestyle\color{titlecolor}}
  {\thesubsubsection.}
  {0.75em}
  {}

%% ----------------------------------------------------------------------
%%    Table of contents styling (FINAL – blue + grouped spacing)
%% ----------------------------------------------------------------------

% Chapters — strong separation
\titlecontents{chapter}
  [1.5em]
  {\titlestyle\color{titlecolor}}
  {\contentslabel{1.5em}}
  {}
  {\titlerule*{.}\contentspage}
  [\addvspace{0.3\baselineskip}]

% Sections — slight separation from previous block
\titlecontents{section}
  [3.0em]
  {\titlestyle\color{titlecolor}}
  {\contentslabel{2.3em}}
  {}
  {\titlerule*{.}\contentspage}
  [\addvspace{0.15\baselineskip}]

% Subsections — tight grouping (no extra space)
\titlecontents{subsection}
  [4.5em]
  {\titlestyle\small\color{titlecolor}}
  {\contentslabel{3.2em}}
  {}
  {\titlerule*{.}\contentspage}
  [\addvspace{0.10\baselineskip}]

% Unnumbered chapters (e.g. References)
\titlecontents{chapter*}
  [1.5em]
  {\titlestyle\color{titlecolor}}
  {}
  {}
  {\titlerule*{.}\contentspage}
  [\addvspace{0.3\baselineskip}]

%% ----------------------------------------------------------------------
%%    Header marks
%% ----------------------------------------------------------------------

\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\renewcommand{\sectionmark}[1]{\markright{#1}}

%% ----------------------------------------------------------------------
%%    Header and footer (oneside)
%% ----------------------------------------------------------------------

\RequirePackage{fancyhdr}
\pagestyle{fancy}

\fancyhf{}

% Header
\fancyhead[L]{\color{titlecolor}\titlestyle\rightmark}
\fancyhead[R]{\color{titlecolor}\titlestyle\thepage}

% Blue rule
\renewcommand{\headrulewidth}{0.5pt}
\renewcommand{\headrule}{%
  \hbox to\headwidth{\color{titlecolor}\leaders\hrule height \headrulewidth\hfill}}

% Chapter opening pages
\fancypagestyle{plain}{%
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \fancyfoot[C]{\color{titlecolor}\titlestyle\thepage}
}

%% ----------------------------------------------------------------------
%%    Setting up the \makecover command for the cover page
%% ----------------------------------------------------------------------

\newcommand*{\makecover}{
    %% Use the Tikz library positioning and clear the page header and footer
    \usetikzlibrary{positioning}
    \thispagestyle{empty}

    %% Construct the cover page with Tikz
    \begin{tikzpicture}[overlay,remember picture]

        %% Add the cover image
        \node[above=0,inner sep=0] at (current page.south) {%
            \includegraphics[width=\paperwidth]{\@coverimage}};

        %% Add the affiliation on the left
        \node[rotate=90,below right=40mm and 3mm] at (current page.west) {%
            \ifdefvoid{\@affiliation}{}{\color{white}\titlestyle\@affiliation}};

        %% Add the logo in the bottom left
        \node[above right=10mm] at (current page.south west) {%
            \includegraphics[width=0.35\linewidth]{figures/cover/logo-white}};

        %% Add the banner with the title, subtitle, subject and author(s)
        \node[below=2cm,fill=black!85,minimum width={\paperwidth},inner ysep=25pt,opacity=0.6,text opacity=1] at (current page.north) {%
            \begin{minipage}{0.9\paperwidth}
                %% Format and add the title
                \color{titlecolor}\raggedright\largetitlestyle\fontsize{50}{50}\selectfont%
                    \@title \\[0.5ex]
                %% Format and add (optional) subtitle and subject
                \color{white}\titlestyle\fontsize{22}{22}\selectfont%
                    \ifdefvoid{\@subtitle}{}{\@subtitle \\[2.5ex]}%
                    \ifdefvoid{\@subject}{}{\@subject \\[0.5ex]}
                %% Format and add author or table of authors
                \largetitlestyle\fontsize{24}{24}\selectfont%
                    \ifdefvoid{\@covertable}{\@author}{\@covertable}
            \end{minipage}};

    \end{tikzpicture}
    \newpage
}

% ============================================================
% Glossaries
% ============================================================

\RequirePackage[acronym]{glossaries}
% Prevent glossaries from forcing page breaks
\renewcommand*{\glsclearpage}{}
% Make glossary headings behave like a section (no chapter-style clearpage)
\renewcommand*{\glossarysection}[2][]{\section*{#2}}
\glsdisablehyper
\renewcommand*{\glossaryentrynumbers}[1]{}
\makenoidxglossaries
\input{acronyms}

% ============================================================
% Preamble additions
% ============================================================
\RequirePackage[table]{xcolor}
\RequirePackage{booktabs}
\RequirePackage{array}

% Define accent color (adjust to match your template)
\colorlet{accentblue}{titlecolor}

% Thicker blue rules for tables
\newcommand{\bluetoprule}{\arrayrulecolor{accentblue}\toprule}
\newcommand{\bluebottomrule}{\arrayrulecolor{accentblue}\bottomrule}
\newcommand{\blueheadrule}{\arrayrulecolor{accentblue}\midrule}

% Column style for bold blue headers
\newcolumntype{H}{>{\bfseries\color{accentblue}}l}

%% ----------------------------------------------------------------------
%%    Setting up listings
%% ----------------------------------------------------------------------

\RequirePackage{listings} % Typeset source code listings

\lstset{
  basicstyle=\ttfamily\footnotesize,  % Style of the font that is used for the code
  backgroundcolor=\color{gray!10},    % Background color
  keywordstyle=\color{red!75!black},  % Keyword style
  stringstyle=\color{green!40!black}, % String style
  commentstyle=\color{blue!30!black}, % Comment style
  numbers=left,                       % Add line numbers on the left side
  numbersep=5pt,                      % Decrease distance between line numbers and code
  numberstyle=\tiny,                  % Line number style
  breaklines=true,                    % Line break automatically
}
