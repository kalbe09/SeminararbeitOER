% Class file for seminar papers in DBIS Group style

% Copyright © 2011-2018 DBIS Group, WWU Münster, in particular:
%           Till Haselmann <haselmann@wi.uni-muenster.de>
%           Florian Stahl  <flst@wi.uni-muenster.de>
% All rights reserved.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dbisseminar}[2018/08/30 Class file for DBIS Group seminar papers (Till Haselmann, FlorianStahl)]

\RequirePackage{kvoptions}
\RequirePackage{ifthen}

\SetupKeyvalOptions{
	family=dbisseminar,
	prefix=dbisseminar@
}

\DeclareStringOption[german]{language}[german]

\DeclareDefaultOption{%
  \ClassInfo{dbisseminar}{Unused option: \CurrentOption, passed on to dbispaper}%
  \PassOptionsToClass{\CurrentOption}{dbispaper}%
}
\ProcessKeyvalOptions{dbisseminar}

\ifthenelse{\equal{\dbisseminar@language}{english}}{
  % English localization
  \newcommand{\dbispaper@type}{seminar paper}
}{\ifthenelse{\equal{\dbisseminar@language}{german}}{
  % German localization
  \newcommand{\dbispaper@type}{Seminararbeit}
}{
  % Error!
  \ClassError{dbisseminar}{Unknown language ``\dbismaster@language'' specified}{}
}}

\PassOptionsToClass{language=\dbisseminar@language}{dbispaper}
\DisableKeyvalOption{dbisseminar}{language}

\LoadClass[toplevel=section]{dbispaper}

\newcommand{\seminartitle}[1]{\subtitle{Seminar: #1}}
