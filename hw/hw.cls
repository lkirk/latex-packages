\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hw}[2024-09-04 Math Homework Template]

\newcommand{\hw@validateoption}[2]{%
  \csname in@\endcsname{,#1,}{,#2,}%
  \expandafter\ifx\csname ifin@\expandafter\endcsname\csname iffalse\endcsname
    \ClassError{hw}{Unknown argument provided: #1. valid arguments: #2}%
  \fi
}

%% Default Options
\def\hw@hmargin{1in}
\def\hw@vmargin{1in}

\def\instring#1#2{TT\fi\begingroup
  \edef\x{\endgroup\noexpand\in@{#1}{#2}}\x\ifin@}

%% Parse Options
\newcommand{\hw@processoption}[1]{%
  \if\instring{=}{#1}
    \expandafter\hw@processoption@#1\relax%
  \else
    \PassOptionsToClass{#1}{article}
  \fi
}

\def\hw@processoption@#1=#2\relax{%
  \hw@validateoption{#1}{author,assigntype,num,coursenum,hmargin,vmargin}
  \expandafter\def\csname hw@#1\endcsname{#2}%
}

\DeclareOption*{\hw@processoption{\CurrentOption}}

\ProcessOptions\relax

\ifx\hw@assigntype\undefined%
  \newcommand{\hw@assigntype}{Homework}
\fi
\ifx\hw@author\undefined%
  \ClassError{hw}{author argument not defined}
\fi
\ifx\hw@num\undefined%
  \ClassError{hw}{num argument not defined}
\fi
\ifx\hw@coursenum\undefined%
  \ClassError{hw}{coursenum argument not defined}
\fi

% Font size hack for now
\PassOptionsToClass{notitlepage,12pt}{article}
\LoadClass{article}

\AtBeginDocument{%
  \begin{center}
    {\Large \hw@coursenum{} \hw@assigntype{} \hw@num} \\
    \hw@author \\
    \today
  \end{center}
}

\RequirePackage[
  tmargin=\hw@vmargin,
  bmargin=\hw@vmargin,
  lmargin=\hw@hmargin,
  rmargin=\hw@hmargin
]{geometry}
\RequirePackage{amsmath, amsfonts, amsthm, amssymb}
\RequirePackage{enumerate}
\RequirePackage{enumitem}

% Prefix for questions
\newcommand{\questiontype}{Question}

% Use this if your "written" questions are all under one section
% For example, if the homework handout has Section 5: Written Questions
% and all questions are 5.1, 5.2, 5.3, etc. set this to 5
% Use for 0 no prefix. Redefine as needed per-question.
\newcommand{\writtensection}{0}

\setlength{\parindent}{0pt}
\setlength{\parskip}{5pt plus 1pt}

\def\indented#1{\list{}{}\item[]}
\let\indented=\endlist%

\newcounter{questionCounter}
\newcounter{partCounter}[questionCounter]

\newenvironment{namedquestion}[1][\arabic{questionCounter}]{%
  \addtocounter{questionCounter}{1}%
  \setcounter{partCounter}{0}%
  \vspace{.2in}%
  \noindent{\bf #1}%
  \vspace{0.3em} \hrule \vspace{.1in}%
}{}

\newenvironment{numedquestion}[0]{%
  \stepcounter{questionCounter}%
  \vspace{.2in}%
  \ifx\writtensection\undefined%
  \noindent{\bf \questiontype\; \arabic{questionCounter}. }%
  \else
  \if\writtensection0
    \noindent{\bf \questiontype\; \arabic{questionCounter}. }%
  \else
    \noindent{\bf \questiontype\; \writtensection.\arabic{questionCounter} }%
  \fi
  \vspace{0.3em} \hrule \vspace{.1in}%
}{}

\newenvironment{alphaparts}[0]{%
  \begin{enumerate}[label=\textbf{(\alph*)}]
    }{\end{enumerate}}

\newenvironment{arabicparts}[0]{%
  \begin{enumerate}[label=\textbf{\arabic{questionCounter}.\arabic*}]
    }{\end{enumerate}}

\endinput
