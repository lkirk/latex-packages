\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eqnsheet}[2025-02-17 Equation Sheet Document Class]

\newcommand{\eqnsheet@validateoption}[2]{%
  \csname in@\endcsname{,#1,}{,#2,}%
  \expandafter\ifx\csname ifin@\expandafter\endcsname\csname iffalse\endcsname
    \ClassError{eqnsheet}{Unknown argument provided: #1. valid arguments: #2}%
  \fi
}

% Define a macro to test if string contains
\def\instring#1#2{TT\fi\begingroup
  \edef\x{\endgroup\noexpand\in@{#1}{#2}}\x\ifin@}

% Parse Options
\newcommand{\eqnsheet@processoption}[1]{%
  \if\instring{=}{#1}
    \expandafter\eqnsheet@processoption@#1\relax%
  \else
    %
  \fi
}

% Validate that options (containing '=') are expected
\def\eqnsheet@processoption@#1=#2\relax{%
  \eqnsheet@validateoption{#1}{ncols}
  \expandafter\def\csname eqnsheet@#1\endcsname{#2}%
}

% Declare processed options
\DeclareOption*{\eqnsheet@processoption{\CurrentOption}}

\ProcessOptions\relax

% Validate that we have processed required options
\ifx\eqnsheet@ncols\undefined%
  \ClassError{eqnsheet}{Number of columns not specified, please provide ncols=n}
\fi

\LoadClass{article}
\RequirePackage{microtype}
\RequirePackage{multicol}
\RequirePackage{parskip}
\RequirePackage[pdftex,a4paper,margin=0.7cm,nohead,nofoot]{geometry}
\RequirePackage[fontsize=8pt]{scrextend}
\RequirePackage{amsfonts}
\RequirePackage{amsmath}
\RequirePackage{stats}
\RequirePackage[compact,tiny,center]{titlesec}

\AtEndOfClass{%
  \parskip=.25em
  \pagestyle{empty}
  \microtypesetup{nopatch=footnote}
}

\AtBeginDocument{%
  \begin{multicols*}{\eqnsheet@ncols}
    }
    \AtEndDocument{%
  \end{multicols*}
}
