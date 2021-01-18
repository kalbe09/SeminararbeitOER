% Class file for basic DBIS Group style papers
%
% Copyright © 2011-2020 DBIS Group, WWU Münster, in particular:
%           Till Haselmann <haselmann@wi.uni-muenster.de>
%           Jens Lechtenbörger <lechten@wi.uni-muenster.de>
%           Florian Stahl  <flst@wi.uni-muenster.de>
% All rights reserved.
%
%
% == Change log ==
% 20200607 jele: version 1.1.0
%   - Use Prüfungsordnung for wording of final declaration
%   - Add option for license information
%
% 20200415 jele: version 1.0.11
%   - Use tabularx instead of tabbing for consent form to deal with
%     long titles; reduce vertical spacing for multi-line title
%
% 20190808 jele: version 1.0.10
%   - No change in style files
%   - Explanations for quotation marks in documentation-body.tex
%
% 20190131 jele: version 1.0.9
%   - No change in style files
%   - More explanations on citations and references in documentation-body.tex
%
% 20180830 jele: version 1.0.8
%   - Get rid of SVN ids
%
% 20180502 jele: version 1.0.6
%   - Only produce consent form for single author
%   - Sort glossaries by definition, which seems more reasonable
%
% 20170126 jele: version 1.0.4
%   - Added consent form
%   - Final declarations are now also included in seminar papers
%
% 20150826 jele: version 1.0.2
%   - Added package url with option hyphens to break long URLs properly
%   - Added sample URL in WebReferencesSample.bibWebReferencesSample.bib
%
% 20140915 jele: version 1.0.1
%   - Added option dbisthesis
%
% 20130110 jele
%   - Changed \and so that hyperref does not complain
%
% 20120903 tiha: version 0.7.0
%   - Major clean-up of documentation
%   - Now subcaption is required by this class
%   - Consolidated version numbers of all classes to “0.7.0”
%
% 20120308 tiha: version 0.6.1
%   – Removed "sort=def" for \addtosymbolvz.  See there for explanation.
%
% == Important Todos ==
%
% TODO Re-implement bibliography using biblatex
% TODO Fine-tune list of web pages to include Urldate and Lastchecked
% TODO Adjust scaling of sans-serif font to match serif lowercase letter height
%      If needed, reduce weight of headings even more b/c font is too heavy
% TODO Befehle für Abkürzungen nachtragen
% TODO \backmatter definieren, Anhang formatieren
% TODO Listings formatieren
% TODO 2-Seitigen Druck für Bachelor-/Masterarbeiten unterstützen?
%
%
% == Less urgent or of little importance ==
%
% TODO Randnotizen/Todonotes prüfen
%
%
%

\NeedsTeXFormat{LaTeX2e}

\newcommand{\DBISVersion}{1.1.0} % Adjust to current version

\ProvidesClass{dbispaper}[2020/06/07 Class file for basic DBIS Group style papers (Kira Marie Alberding)]

\RequirePackage{kvoptions}[2010/12/23] % Important: Require version 3.10
% Earlier versions of this package had a bug concerning the handling of \DeclareDefaultOption{…}
\RequirePackage{ifthen}

\SetupKeyvalOptions{
	family=dbispaper,
	prefix=dbispaper@
}

%% Switch main language to German (e.g., for German lectures)
\DeclareStringOption[german]{language}[german]

%% Option to control licensing
\DeclareStringOption{license}

\DeclareStringOption[chapter]{toplevel}[chapter]

% Option to control the use of fonts (true = correct fonts, false = Times)
\DeclareBoolOption[false]{garamond}

% Option to control loading of the glossaries package
\DeclareBoolOption[true]{glossaries}

% Set to true if you would like to use the high-quality cmyk logos for WWU and DBIS Group
% Note 1: These files are not distributed with the publicly available template!
% Note 2: Enabling this option increases the file size of the PDF significantly!
\DeclareBoolOption[false]{cmykgraphics}

% Set to false for a jointly supervised thesis, where the DBIS logo should not be included.
\DeclareBoolOption[true]{dbisthesis}

% Disables todonotes display
\DeclareBoolOption[false]{disabletodonotes}

%Title only no Supervisor etc.
\DeclareBoolOption[false]{TitleOnly}


\DeclareDefaultOption{%
  \ClassWarning{dbispaper}{Unknown Option: \CurrentOption}%
}
\ProcessKeyvalOptions*

% Setup UTF-8 and T1 encoding
%\RequirePackage[utf8]{inputenc}


\newcommand{\dbispaper@komaclasstoload}{scrreprt} %report} % scrreprt

%\LoadClass[german]{scrreprt}
\ifthenelse{\equal{\dbispaper@toplevel}{section}}{
  % Top level is supposed to be section -> class is article
  \PackageInfo{dbispaper}{Requested top level for structure is SECTION}
  \renewcommand{\dbispaper@komaclasstoload}{scrartcl} %article} %scrartcl
}{}
\ifthenelse{\equal{\dbispaper@toplevel}{chapter}}{
  % Top level is supposed to be chapter -> class is report
  \PackageInfo{dbispaper}{Requested top level for structure is CHAPTER}
  \renewcommand{\dbispaper@komaclasstoload}{scrreprt} %report} % scrreprt
}{}


\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}

\LoadClass[
  12pt,
  a4paper,
  captions=tableheading           % Tabellen haben Überschriften → Abstände anpassen
]{\dbispaper@komaclasstoload}


% Loading math stuff
\RequirePackage{amsmath}
%\RequirePackage{amsfonts}

% Useful packages
\RequirePackage{mdwlist}				  % Compact lists
\RequirePackage{booktabs}				  % Rules for tables
\RequirePackage{multirow}				  % Span multiple cells (rows/columns) in tables
\RequirePackage{setspace}				  % Flexible line spacing (needed for two-line titles)
\RequirePackage[cmyk,table]{xcolor} % For using colors
\RequirePackage{colortbl}         % Color in tables (together with xcolor)
\RequirePackage{tabularx}         % Variable-width tables
\RequirePackage{multirow}				  % Span multiple cells (rows/columns) in tables
\RequirePackage{setspace}				  % Flexible line spacing (needed for two-line titles)
\RequirePackage{graphicx}         % Including external graphics
\RequirePackage[sectcntreset]{bibtopic} % Getrennte Verzeichnisse für Literatur und Webquellen
\RequirePackage[official]{eurosym}% For the Euro symbol
\RequirePackage{microtype}        % Better justification for paragraphs
\RequirePackage{listings}         % For code listings
\RequirePackage{pifont}           % Zusätzliche Symbole \ding{?}
\RequirePackage[hyphens]{url}     % Break URLs at hyphen
\RequirePackage[
    pdfborder={0 0 0}             % Deactivate borders around links
  ]{hyperref}                     % For Hyperlinks in the PDF file
\RequirePackage{xspace}

% Have Chapter and Section in the Title
%\RequirePackage[headsepline]{scrlayer-scrpage}  % Running Headers and footers


% Make labels in captions bold face
\RequirePackage[font=sf,labelfont=bf,textformat=period]{caption}
\RequirePackage{subcaption}

%%
%%  LOCALIZATION
%%

% Setup language
\ifthenelse{\equal{\dbispaper@language}{english}}{
  \typeout{}
  \typeout{dbispaper: Language is set to English}
  \typeout{}

  % Load english as main language, ngerman as "other" language
  \RequirePackage[ngerman,english]{babel}
  \nonfrenchspacing

  % Localizable macros
  \newcommand{\cInstitut}{Department of Information Systems}
  \newcommand{\cProf}{Prof. Dr. Gottfried Vossen}
  \newcommand{\cBetreuer}{Supervised by}
  \newcommand{\cVorgelegtVon}{Submitted by}
  \newcommand{\cAbgabetermin}{Deadline}

  % License
  \newcommand{\cLizenzinfo}{License Information}
  \newcommand{\cLizenzTemplate}[1]{Unless explicitly specified otherwise, this work is licensed under the license #1.}

  %Bibstyle
  \newcommand{\bibstylename}{alpha}


}{ % Default case should be German
\ifthenelse{\equal{\dbispaper@language}{german}}{
  \typeout{}
  \typeout{dbispaper: Language is set to German}
  \typeout{}

  % Load ngerman as main language, english as "other" language
  \RequirePackage[english,ngerman]{babel}
  \frenchspacing

  % Localizable macros
  \newcommand{\cInstitut}{Institut für Wirtschaftsinformatik}
  \newcommand{\cProf}{Prof. Dr. Gottfried Vossen}
  \newcommand{\cBetreuer}{Betreuer}
  \newcommand{\cVorgelegtVon}{Vorgelegt von}
  \newcommand{\cAbgabetermin}{Abgabetermin}

  % License
  \newcommand{\cLizenzinfo}{Lizenzinformationen}
  \newcommand{\cLizenzTemplate}[1]{Soweit nicht anders angegeben unterliegt diese Arbeit der Lizenz #1.}

  %Bibstyle
  \newcommand{\bibstylename}{alphadin}

  \usepackage{icomma}  % Allows the use of "," as a decimal point

}{\ClassError{dbispaper}{Class option ``language'' is not set.}{}}
}

%%
%% LICENSES
%%
\newcommand{\cLizenz}{\ifthenelse{\equal{\dbispaper@license}{cc-by-sa}}{
    \typeout{}
    \typeout{dbispaper: License is CC BY-SA}
    \typeout{}
    \section*{\cLizenzinfo}
    \includegraphics[width=2cm]{cc-icons/cc-by-sa.png}
    \cLizenzTemplate{\href{https://creativecommons.org/licenses/by-sa/4.0/legalcode}{Attribution-ShareAlike 4.0 International}}
  }{
  \ifthenelse{\equal{\dbispaper@license}{cc-by}}{
    \typeout{}
    \typeout{dbispaper: License is CC BY}
    \typeout{}
    \section*{\cLizenzinfo}
    \includegraphics[width=2cm]{cc-icons/cc-by.png}
    \cLizenzTemplate{\href{https://creativecommons.org/licenses/by/4.0/legalcode}{Attribution 4.0 International}}
  }{
  \ifthenelse{\equal{\dbispaper@license}{cc0}}{
    \typeout{}
    \typeout{dbispaper: License is Public Domain}
    \typeout{}
    \section*{\cLizenzinfo}
    \includegraphics[width=2cm]{cc-icons/cc-zero.png}
    \cLizenzTemplate{\href{https://creativecommons.org/publicdomain/zero/1.0/legalcode}{CC0 1.0 Universal}}
  }{
    \typeout{}
    \typeout{dbispaper: All rights reserved}
    \typeout{}
  }}}}


\ifthenelse{\boolean{dbispaper@glossaries}}{
  % Use the glossaries package to support list of abbreviations etc.
  % TODO Make nomain optional?
  % TODO Include class option for xindy -> better sorting!

  % Note: With xindy, entries in the symbol list are sorted by the text that can be
  % reproduced from the symbol name.  Note, that this means you can’t simply
  % have a symbol that’s a macro only, e.g., \alpha.  In that case, use the
  % variant that explicitly specifies a sort key.
  % Using makeindex, the sort order seems to be the same as the definition when
  % you don’t specify a sort key.

  \RequirePackage[acronym,toc,nolong,nosuper,notree,shortcuts,nomain]{glossaries}
  \newcommand{\symboltype}{symvz}
  \newglossary{\symboltype}{gls}{glo}{\symvzcaption}
  \makeglossaries

  % Have all symbols appear in the list.
  % This has to be called after all symbols have been defined in the preamble,
  % so we postpone the call until "\begin{document}"
  %\AtBeginDocument{\glsaddall[types={\symboltype}]}
  % we do not do this as this does add an empty page

  \newcounter{symbol}
  \setcounter{symbol}{10}
  \newcommand{\addsymboltovz}[2]{\addtocounter{symbol}{1}\newglossaryentry{sym\thesymbol}{name={#1},description={#2},type=\symboltype,sort=def}}
  % \newcommand{\addsymboltovz}[2]{\addtocounter{symbol}{1}\newglossaryentry{sym\thesymbol}{name={#1},description={#2},type=\symboltype}} % 20120308 tiha – Removed “sort=def” from list of keys
  \newcommand{\addsymboltovzwithsortkey}[3]{\addtocounter{symbol}{1}\newglossaryentry{sym\thesymbol}{name={#1},description={#3},sort={#2},type=\symboltype}}

  %% Sample usage:
  %
  %  \addsymboltovz{$f_{x}$}{Function of $x$}
  %
  %  NB: If we have only commands as the symbol name, we need to specify the sort key explicitly
  %
  %  \newglossaryentry{alpha}{name={$\alpha$},description={…},sort=alpha,type=\symboltype}
  %
  %%%%%

  % Define the DBIS Group glossary style:
  \setlength{\columnsep}{22pt}
  \setlength{\columnseprule}{0.25pt}

  \newlength{\glstabwidth}
  \setlength{\glstabwidth}{5.0em}

  \newglossarystyle{dbis}{%
  % Define the environment for the entire glossary:
  \renewenvironment{theglossary}{\begin{tabbing}\hspace*{\glstabwidth}\=\kill}{\end{tabbing}}%
  % have nothing after \begin{theglossary}:
  \renewcommand*{\glossaryheader}{}%
  % have nothing between glossary groups:
  \renewcommand*{\glsgroupheading}[1]{}%
  \renewcommand*{\glsgroupskip}{}% alternativ: \vspace{1em} -> Gruppen durch "Leerzeile" trennen
  % set how each entry should appear:
  % In this case: a small table for each entry
  \renewcommand*{\glossaryentryfield}[5]{%
  \noindent\sffamily\textbf{\glstarget{##1}{##2}} \> ##3 \\}
  % set how sub-entries appear:
  \renewcommand*{\glossarysubentryfield}[6]{%
  \glossaryentryfield{##2}{##3}{##4}{##5}{##6}}%
  }
    \newcommand{\listofabbreviations}{\printglossary[type=\acronymtype,nonumberlist=true,toctitle=\acronymname,style=dbis]}
  \newcommand{\listofsymbols}{\printglossary[type=\symboltype,nonumberlist=true,style=dbis]}


  \newcommand*{\symvzcaption}{List of Symbols}
  %\newcommand*{\abstractname}{Abstract} already exists

  % Set appropriate captions (copied and modified from glossaries package)
  \@ifundefined{captionsgerman}{}{%
    \addto\captionsgerman{%
      \renewcommand*{\glossaryname}{Glossar}%
      \renewcommand*{\acronymname}{Abkürzungsverzeichnis}%
      \renewcommand*{\entryname}{Bezeichnung}%
      \renewcommand*{\descriptionname}{Beschreibung}%
      \renewcommand*{\symbolname}{Symbol}%
      \renewcommand*{\pagelistname}{Seiten}%
      \renewcommand*{\glssymbolsgroupname}{Symbole}%
      \renewcommand*{\glsnumbersgroupname}{Zahlen}
      \renewcommand*{\symvzcaption}{Symbolverzeichnis}}
      \renewcommand*{\abstractname}{Zusammenfassung}
  }
  \@ifundefined{captionsngerman}{}{%
    \addto\captionsngerman{%
      \renewcommand*{\glossaryname}{Glossar}%
      \renewcommand*{\acronymname}{Abkürzungsverzeichnis}%
      \renewcommand*{\entryname}{Bezeichnung}%
      \renewcommand*{\descriptionname}{Beschreibung}%
      \renewcommand*{\symbolname}{Symbol}%
      \renewcommand*{\pagelistname}{Seiten}%
      \renewcommand*{\glssymbolsgroupname}{Symbole}%
      \renewcommand*{\glsnumbersgroupname}{Zahlen}
      \renewcommand*{\symvzcaption}{Symbolverzeichnis}}
      \renewcommand*{\abstractname}{Zusammenfassung}
  }
}{
  % Do not load in case it's not used.
  \ClassWarning{dbispaper}{Note: Support for glossaries package is disabled.  This may result in errors for documents that rely on this support.  Right now, it's not possible to create, e.g., a list of abbreviations.}
}


% Define DBIS Colors
\xdefinecolor{dbis-fg}{cmyk}{0,0,0,1} % black
\xdefinecolor{dbis-red}{cmyk}{0.08,1,0.65,0.34} % 8/100/65/34
\xdefinecolor{dbis-gray}{cmyk}{0.24,0.13,0.18,0.38}  % 24/13/18/38
\xdefinecolor{dbis-dkgray}{cmyk}{0.24,0.13,0.18,0.8}

% Define ERCIS Colors
\xdefinecolor{ercis-red}{cmyk}{0,.649,.631,.565}
\xdefinecolor{ercis-blue}{cmyk}{1,.6,0,.7}
\xdefinecolor{ercis-gray}{cmyk}{0,.008,.015,.486}

%% For todos in the text:
\xdefinecolor{todo-bkgnd}{cmyk}{0.0,0.2,0.80,0}
\xdefinecolor{todo-line}{cmyk}{0,1,1,0.4}
\xdefinecolor{todo-border}{cmyk}{0,1,1,0.4}

% Additional colors
\definecolor{darkgreen}{cmyk}{1, 0, 1, 0.50}
\definecolor{table-header-gray}{gray}{0.90}
\definecolor{mediumgray}{gray}{0.80}
\definecolor{lightgray}{gray}{0.90}
\definecolor{darkgray}{gray}{0.70}
\definecolor{darkestgray}{gray}{0.60}
\definecolor{lstlinenumbers}{gray}{0.40}

% Set up todonotes package
\ifthenelse{\boolean{dbispaper@disabletodonotes}}{%
  \RequirePackage[disable]{todonotes}
}{
  \RequirePackage[textsize=small,
      textwidth=2.15cm,
      bordercolor=todo-border,
      backgroundcolor=todo-bkgnd,
      linecolor=todo-line
    ]{todonotes}
}
\newcommand{\stodo}[2][]
{\todo[caption={#2},#1]
{\normalfont\scriptsize\sffamily\begin{spacing}{1}#2\vspace{-1em}\end{spacing}}\xspace}
%\reversemarginpar

% Setup fonts
\ifthenelse{\boolean{dbispaper@garamond}}{
  \typeout{}
  \typeout{dbispaper: garamond selected}
  \typeout{}
  % Use correct fonts: Garamond, Optima, LuxiMono
  \renewcommand{\rmdefault}{ugm} % URW Garamond
  \renewcommand{\sfdefault}{uop} % URW Classico (Optima)
  %\renewcommand{\ttdefault}{pcr} % Courier
  \RequirePackage[scaled=0.75]{luximono}
  \RequirePackage[garamond]{mathdesign}
}{
  % If garamond explicitly set to false, fall back to Times
\ClassWarning{dbispaper}{} %Wenn nicht Garamod, dann TeX-Default
  \typeout{}
  \typeout{dbispaper: garamond NOT selected} %times selected}
  \typeout{}
 \RequirePackage{pslatex}
}

% 1.5-facher Zeilenabstand
\linespread{1.3}

%% Layout for Titlepage
\renewcommand{\maketitle}{%
\typeout{}
  \typeout{dbispaper: making title}
\typeout{}
\begin{titlepage}
  \sffamily
  \begin{minipage}{0.3\linewidth}
    % WWU Logo
    \ifthenelse{\boolean{dbispaper@cmykgraphics}}{%
      \includegraphics[width=6cm]{WWU_Logo_2017_4c}%
    }{%
      \includegraphics[width=6cm]{WWUMuenster_Logo_2017_rgb}%
    }
  \end{minipage}\hfill
  \begin{minipage}{0.5\linewidth}
    \begin{spacing}{1.0}
      % Department text
      \vspace{0.85cm}
      \flushright
      \textbf{\cInstitut}\\
      \cProf\\
    \end{spacing}
  \end{minipage}
  \quad
  \vfill\vfill
  \begin{center}
	  %Titel und Untertitel
    \LARGE
	  \textbf{\@title}
	  \\%Keinen neuen Absatz einfuegen
	  \Large\@subtitle
	  \vfill\vfill\vfill
  \end{center}

  % Betreuer und Informationen über den/die Einreichende auf das Nötigste reduziert
  % Der Autor ist in der Form "Vorname Name (E-Mailadresse)" anzugeben.
  % Bei mehreren Autoren funktioniert es folgendermaßen:  "Vorname0 Name0 (E-Mailadresse0) \\ \> Vorname1 Name1 (E-Mailadresse1)"
  % Nich wenn OnlyTitle gesetzt ist
  \ifthenelse{\not\boolean{dbispaper@TitleOnly}}{
  \begin{tabbing}
    \hspace*{3.5cm}\= \kill
    \cBetreuer:	\> \@supervisor\\
    \\
    \cVorgelegtVon:	\> \@author\\
    \\
    \cAbgabetermin:	\> \@date\\
  \end{tabbing}
  }{}
  \begin{center}
  \ifthenelse{\boolean{dbispaper@dbisthesis}}{%
  \ifthenelse{\boolean{dbispaper@cmykgraphics}}{%
    \includegraphics[scale=0.25]{DBIS-Logo2_4c}%
  }{%
    \includegraphics[scale=0.25]{DBIS-Logo2_rgb}%
  }}{}
  \end{center}
\end{titlepage}
}


% Mehr als einen Autor unterstützen:
\RequirePackage{etoolbox}
\newbool{multipleAuthors}
\renewcommand{\and}{\global\booltrue{multipleAuthors}\texorpdfstring{,\\ \>}{,}}

\let\orig@author\author
\renewcommand{\author}[1]{\hypersetup{pdfauthor={#1}}\orig@author{#1}}
\let\orig@title\title
\renewcommand{\title}[1]{\hypersetup{pdftitle={#1}}\orig@title{#1}}
\let\orig@subtitle\subtitle
\renewcommand{\subtitle}[1]{\hypersetup{pdfsubject={#1}}\orig@subtitle{#1}}

\newcommand{\supervisor}[1]{\def\@supervisor{#1}}

\newcommand{\email}[1]{\href{mailto:#1}{\texttt{<#1>}}}

% Place for plagiarism declaration
\newcommand{\placeOfSignature}[1]{\def\@placeOfSignature{#1}}
% Date for plagiarism declaration
\newcommand{\dateOfSignature}[1]{\def\@dateOfSignature{#1}}
% Additional information for plagiarism consent form
\newcommand{\studentNumber}[1]{\def\@studentNumber{#1}}
\newcommand{\studentAddress}[1]{\def\@studentAddress{#1}}
\newcommand{\courseOfStudy}[1]{\def\@courseOfStudy{#1}}

% List authors for plagiarism declaration
\newcommand{\dbispaper@listauthors}{%
  \begingroup\def\and{\vspace{.8cm}\par\noindent\makebox[10cm]{\hrulefill}\\}
  \vspace{.8cm}\par\noindent\makebox[10cm]{\hrulefill}\\
  \@author
  \endgroup
}

\ifthenelse{\equal{\dbispaper@language}{english}}{
  % English localization
  \newcommand{\cAbschlErklaerung}[5]{%
    % We always start with section* here (never chapter) to make sure
    % that everything fits on one page.  Also the vspace* with
    % subsequent subsection* is an ugly hack.
    % Same for German version below.
    \ifthenelse{\boolean{multipleAuthors}}{%
      \ClassWarning{dbispaper}{Plagiarism consent form not supported with multiple authors.  Please produce appropriate form yourselves.}
    }{\small
      \section*{Consent Form}
      \vspace*{-.5cm}
      \subsection*{for the use of plagiarism detection software to check my thesis}\thispagestyle{empty}
      \begin{tabularx}{\textwidth}{lX}
        Name: & \@author\\
        Student number: & #3\\
        Course of study: & #5\\
        Address: & #4\\
        Title of thesis: & \noLinebreaks{\@title}
      \end{tabularx}

      \paragraph{What is plagiarism?}
      Plagiarism is defined as submitting someone else's work or ideas
      as your own without a complete indication of the source.  It is
      hereby irrelevant whether the work of others is copied word by
      word without acknowledgment of the source, text structures
      (e.g., line of argumentation or outline) are borrowed, or texts
      are translated from a foreign language.

      \paragraph{Use of plagiarism detection software}
      The examination office uses plagiarism software to check each
      submitted bachelor and master thesis for plagiarism. For that
      purpose the thesis is electronically forwarded to a software
      service provider where the software checks for potential matches
      between the submitted work and work from other sources. For
      future comparisons with other theses, your thesis will be
      permanently stored in a database. Only the School of Business
      and Economics of the University of M{\"u}nster is allowed to
      access your stored thesis.  The student agrees that his or her
      thesis may be stored and reproduced only for the purpose of
      plagiarism assessment. The first examiner of the thesis will be
      advised on the outcome of the plagiarism assessment.

      \paragraph{Sanctions}
      Each case of plagiarism constitutes an attempt to deceive in
      terms of the examination regulations and will lead to the thesis
      being graded as ``failed.'' This will be communicated to the
      examination office where your case will be documented.  In the
      event of a serious case of deception the examinee can be
      generally excluded from any further examination. This can lead
      to the exmatriculation of the student.  Even after completion of
      the examination procedure and graduation from university,
      plagiarism can result in a withdrawal of the awarded academic
      degree.

      \medskip

      \noindent I confirm that I have read and understood the
      information in this document. I agree to the outlined procedure
      for plagiarism assessment and potential sanctioning.

      \vspace{1em}\par\noindent #1, on the #2%
      \dbispaper@listauthors
    }
    \ifthenelse{\equal{\dbispaper@toplevel}{section}}{%
      \section*{Final declaration}\thispagestyle{empty}
    }{%
      \chapter*{Final declaration}\thispagestyle{empty}
    }
    I hereby declare that this
    \makeatletter\dbispaper@type\makeatother\ titled
    ``\noLinebreaks{\@title}'' is my own, independent work.
    I confirm that I cited all sources and auxiliary means and marked quotations as such; this also holds for tables and graphical works.

    \vspace{2em}\par\noindent #1, on the #2%
    \dbispaper@listauthors
  }
}{\ifthenelse{\equal{\dbispaper@language}{german}}{
  % German localization
  \newcommand{\cAbschlErklaerung}[5]{%
    \ifthenelse{\boolean{multipleAuthors}}{%
      \ClassWarning{dbispaper}{Plagiarism consent form not supported with multiple authors.  Please produce appropriate form yourselves.}
    }{\small
      \section*{Einverst{\"a}ndniserkl{\"a}rung}
      \vspace*{-.5cm}
      \subsection*{zur Pr{\"u}fung meiner Arbeit mit einer Software zur Plagiat-Erkennung}\thispagestyle{empty}
      \begin{tabularx}{\textwidth}{lX}
        Name: & \@author\\
        Matrikelnummer: & #3\\
        Studiengang: & #5\\
        Adresse: & #4\\
        Titel der Arbeit: & \noLinebreaks{\@title}
      \end{tabularx}

      \paragraph{Was ist ein Plagiat?}
      Als ein Plagiat wird eine {\"U}bernahme fremden Gedankengutes in
      die eigene Arbeit angesehen, bei der die Quelle, aus der die
      {\"U}bernahme erfolgt, nicht kenntlich gemacht wird. Es ist
      dabei unerheblich, ob z.B. fremde Texte w{\"o}rtlich
      {\"u}bernommen werden, nur Strukturen (z.B. argumentative
      Figuren oder Gliederungen) aus fremden Quellen entlehnt oder
      Texte aus einer Fremdsprache {\"u}bersetzt werden.

      \paragraph{Softwarebasierte {\"U}berpr{\"u}fung}
      Alle Bachelor- und Masterarbeiten werden vom Pr{\"u}fungsamt mit
      Hilfe einer entsprechenden Software auf Plagiate
      gepr{\"u}ft. Die Arbeit wird zum Zweck der
      Plagiats{\"u}berpr{\"u}fung an einen Software-Dienstleister
      {\"u}bermittelt und dort auf {\"U}bereinstimmung mit anderen
      Quellen gepr{\"u}ft.  Zum Zweck eines zuk{\"u}nftigen Abgleichs
      mit anderen Arbeiten wird die Arbeit dauerhaft in einer
      Datenbank gespeichert.  Ein Abruf der Arbeit ist
      ausschlie{\ss}lich durch die Wirtschaftswissenschaftliche
      Fakult{\"a}t der Westf{\"a}lischen Wilhelms-Universit{\"a}t
      M{\"u}nster m{\"o}glich.  Der Studierende erkl{\"a}rt sich damit
      einverstanden, dass allein zum beschriebenen Zweck der
      Plagiatspr{\"u}fung die Arbeit dauerhaft gespeichert und
      vervielf{\"a}ltigt werden darf. Das Ergebnis der elektronischen
      Plagiatspr{\"u}fung wird dem Erstgutachter mitgeteilt.

      \paragraph{Sanktionen}
      Liegt ein Plagiat vor, ist dies ein T{\"a}uschungsversuch
      i.S. der Pr{\"u}fungsordnung, durch den die Pr{\"u}fungsleistung
      als \glqq{}nicht bestanden\grqq{} gewertet wird. Es erfolgt eine
      Mitteilung an das Pr{\"u}fungsamt und die dortige
      Dokumentation. In schwerwiegenden T{\"a}uschungsf{\"a}llen kann
      der Pr{\"u}fling von der Pr{\"u}fung insgesamt ausgeschlossen
      werden.  Dies kann unter Umst{\"a}nden die Exmatrikulation
      bedeuten. Plagiate k{\"o}nnen auch nach Abschluss des
      Pr{\"u}fungsverfahrens und Verleihung des Hochschulgrades zum
      Entzug des erworbenen Grades f{\"u}hren.

      \medskip

      \noindent Hiermit erkl{\"a}re ich, dass ich die obigen
      Ausf{\"u}hrungen gelesen habe und mit dem Verfahren zur
      Aufdeckung und Sanktionierung von Plagiaten einverstanden bin.

      \vspace{1em}\par\noindent #1, den #2%
      \dbispaper@listauthors }
    \ifthenelse{\equal{\dbispaper@toplevel}{section}}{%
		  \section*{Abschlie\ss ende Er\-kl\"{a}\-rung}\thispagestyle{empty}
	  }{%
		  \chapter*{Abschlie\ss ende Er\-kl\"{a}\-rung}\thispagestyle{empty}
	  }
	  Ich versichere hiermit, dass ich meine \makeatletter\dbispaper@type\makeatother\ \glqq\noLinebreaks{\@title}\grqq\ selbst\-st\"{a}n\-dig verfasst
          und keine anderen als die angegebenen Quellen und Hilfsmittel benutzt sowie Zitate kenntlich gemacht habe; dies gilt auch für Tabellen, Skizzen, Zeichnungen, bildliche Darstellungen usw.
	  \vspace{2em}\par\noindent #1, den #2%
	  \dbispaper@listauthors
  }
}{
  % Error!
  \ClassError{dbisthesis}{Unknown language ``\dbispaper@language'' specified}{}
}}

% Include plagiarism declaration at end of document
\AtEndDocument{\cAbschlErklaerung{\makeatletter\@placeOfSignature\makeatother}{\makeatletter\@dateOfSignature\makeatother}{\makeatletter\@studentNumber\makeatother}{\makeatletter\@studentAddress\makeatother}{\makeatletter\@courseOfStudy\makeatother}}


% Command to disable using "\\" for line breaks
\newcommand{\noLinebreaks}[1]{\begingroup\def\\{}#1\endgroup}

\newcommand{\frontmatter}{\clearpage\pagenumbering{roman}}

\newcommand{\mainmatter}{
	\clearpage\pagenumbering{arabic}
%	\pagestyle{scrheadings}
%	\ehead{\headmark}
}


% DBIS Style Bibliography with separate references and web links
\newcommand{\webbibname}{}
\addto\captionsngerman{%
  \renewcommand{\webbibname}{Verzeichnis von Web-Adressen}%
}
\addto\captionsUKenglish{%
  \renewcommand{\webbibname}{List of Web Pages}%
}
\addto\captionsenglish{%
  \renewcommand{\webbibname}{List of Web Pages}%
}
\addto\captionsUSenglish{%
  \renewcommand{\webbibname}{List of Web Pages}%
}

\newcommand{\dbisbibliography}[2]{ %  Sonstige, URLs
	\begin{btSect}[\bibstylename]{#1}
		\makeatletter\@ifundefined{chapter}
			{\section*{\bibname}\addcontentsline{toc}{section}{\bibname}}
			{\chapter*{\bibname}\addcontentsline{toc}{chapter}{\bibname}}
		\makeatother
		\btPrintCited
	\end{btSect}
	\begin{btSect}[plaindin]{#2}
		\makeatletter\@ifundefined{chapter}
			{\section*{\webbibname}\addcontentsline{toc}{section}{\webbibname}}
			{\chapter*{\webbibname}\addcontentsline{toc}{chapter}{\webbibname}}
		\makeatother
		\btPrintCited
	\end{btSect}
}

%Seite einstellen
\usepackage[left=3.25cm, textwidth=15.0cm, top=3cm, textheight=23.7cm]{geometry}

%Listingsanpassen
\lstset{ %
	basicstyle=\linespread{1}\ttfamily\small, %
  breaklines=true,                % sets automatic line breaking
	breakatwhitespace=false,        % sets if automatic breaks should only happen at whitespace
  breakautoindent=true, %
	columns=fixed, %
  showspaces=false, %
  frame=lines, %
  numbers=left, %
  numberstyle=\tiny\color{lstlinenumbers}, %
  numbersep=5pt, %
  showstringspaces=false %
}

\RequirePackage{dbisabbreviations}

\renewenvironment{abstract}
{\newpage~\cLizenz\vfill~\section*{\abstractname}}{\newpage}
