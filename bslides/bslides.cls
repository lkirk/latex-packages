\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bslides}[2025-01-25 Beamer Slides With Tweaks]

\newcommand{\bslides@validateoption}[2]{%
  \csname in@\endcsname{,#1,}{,#2,}%
  \expandafter\ifx\csname ifin@\expandafter\endcsname\csname iffalse\endcsname
    \ClassError{bslides}{Unknown argument provided: #1.\ valid arguments: #2}%
  \fi
}

% Default Options
\def\bslides@aspect{169}
\def\bslides@notes{}
\def\bslides@sectionslides{}
\def\bslides@serifmath{false}

% true/false values for serifmath
\def\bslides@true{true}
\def\bslides@false{false}

% Define a macro to test if string contains
\def\instring#1#2{TT\fi\begingroup
  \edef\x{\endgroup\noexpand\in@{#1}{#2}}\x\ifin@}

% Parse Options
\newcommand{\bslides@processoption}[1]{%
  \if\instring{=}{#1}
    \expandafter\bslides@processoption@#1\relax%
  \else
    \PassOptionsToClass{#1}{article}
  \fi
}

% Validate that options (containing '=') are expected
\def\bslides@processoption@#1=#2\relax{%
  \bslides@validateoption{#1}{notes,aspect,sectionslides,serifmath}
  \expandafter\def\csname bslides@#1\endcsname{#2}%
}

% Declare processed options
\DeclareOption*{\bslides@processoption{\CurrentOption}}

\ProcessOptions\relax

% Load the beamer class
\PassOptionsToClass{hyperref={bookmarks=false}}{beamer}
\PassOptionsToClass{aspectratio=\bslides@aspect}{beamer}
\LoadClass{beamer}

% Setup speaker notes
\ifx\bslides@notes\empty\else
  \setbeameroption{show notes on second screen=right}
  \setbeamertemplate{note page}[plain]
\fi

\def\bslides@sstitle{title}
\def\bslides@sstoc{toc}
% Create section slides (can be toc or title)
\ifx\bslides@sectionslides\bslides@sstitle%
  \AtBeginSection[]{
    \begin{frame}
      \vfill
      \centering
      \begin{beamercolorbox}[center]{title}
        \usebeamerfont{title}\insertsectionhead\par%
      \end{beamercolorbox}
      \vfill
    \end{frame}
  }
  \AtBeginSubsection[]{
    \begin{frame}
      \vfill
      \centering
      \begin{beamercolorbox}[center]{title}
        \usebeamerfont{title}\insertsectionhead\par%
        \usebeamerfont{section}\insertsubsectionhead\par%
      \end{beamercolorbox}
      \vfill
    \end{frame}
  }
\fi
\ifx\bslides@sectionslides\bslides@sstoc%
  \AtBeginSection[]
  {
    \begin{frame}
      \frametitle{Table of Contents}
      \tableofcontents[currentsection]
    \end{frame}
  }
  \AtBeginSubsection[]
  {
    \begin{frame}
      \frametitle{Table of Contents}
      \tableofcontents[currentsection,currentsubsection]
    \end{frame}
  }
\fi
\ifx\bslides@serifmath\bslides@true%
  \usefonttheme[onlymath]{serif}
\fi

% Setup captions (remove the "Figure: " prefix to caption text)
\RequirePackage[labelformat=empty]{caption}
% Remove navigation symbols
\setbeamertemplate{navigation symbols}{}

\endinput
