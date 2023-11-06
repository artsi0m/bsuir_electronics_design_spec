%%% Local Variables: 
%%% coding: utf-8
%%% mode: latex
%%% TeX-engine: xetex
%%% End: 

%%% Эта штука выше нужна для емакса и auctex,
%%% хотя я ещё auctex не особо пользовался


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bsuir-spec}[2023/11/01 Class conforming to BSUIR standard]

% Почему выбран класс eskdx?
% Главным образом потом что он позволяет
% - Делать секции по ГОСТ 2.105-95
% - Писать спецификацию
% - Не подгружать пакет geometry, отступы уже в соответсвии с приложением Л СТП 
%     
% 
% Тем не менее не стоит через него делать титульник.
\LoadClass[a4paper]{eskdtab}


% СТП-2017 приложение Л
\setlength{\textwidth}{165mm}
\setlength{\textheight}{250mm}
\pagenumbering{arabic}

\RequirePackage{eskdspec}

% Добавляем polyglossia, с ним же добавиться fontspec и можем
% использовать шрифт Times New Roman в XeLaTeX
% При том одним только fontspec не обойтись, потому что в
% polyglossia ещё команда setdefaultlanguage, которая позволяет
% установить русский язык в качестве основного, без чего
% не будут нормально в русском переносы работать.
\RequirePackage{polyglossia} 

% BibLaTeX нужен для библиографии
\RequirePackage[backend=biber]{biblatex}
% Эта штука рекомендуется вместе с biblatex
\RequirePackage{csquotes}

% Чтобы более гибко настроить межстрочный интервал в списках и перечислениях
\RequirePackage{enumitem}

% Картинки^W Иллюстрации
\RequirePackage{graphicx}
% Подписи к картинкам.
\RequirePackage{caption}

\RequirePackage{iftex} 

% Я использую XeLaTeX потому что это позволяет использовать системный
% Times New Roman
\ifXeTeX
  %% устанавливает главный язык документа
  \setdefaultlanguage[spelling=modern]{russian}
  %% устанавливает второй язык документа
  \setotherlanguage{english}

  % СТП-2017 пункт 2.1.1
  % Устанавливаем основным шрифтом системный OpenGost Type A TT
  \setmainfont{OpenGost Type A TT}

  % Выставляем в качестве моноширинного шрифта системный Courier
  \setmonofont{Courier New}
  \providecommand{\No}{\textnumero}

  %% Убираем предупреждение о использовании команды \cyr из eskdx
  \RequirePackage{xecyr} 

  % интервал между строк
  % В СТП-2017 не оговорен, просто сказано в пункте 2.1.1
  % 40 +- 3 строки на страницу
  \RequirePackage{setspace}
  \setstretch{1}

  \newsavebox\ESKDpicturebox
  % Support for the eskdx class in XeLaTeX
  % https://tex.stackexchange.com/a/587888
  \renewcommand{\ESKD@ShipoutPicture}{%
    \ifESKD@twoside
      \ifodd\c@page
        \ESKDframeX=\ESKD@margin@si
      \else
        \ESKDframeX=\ESKD@margin@so
      \fi
    \else
      \ESKDframeX=\ESKD@margin@si
    \fi
    \ESKDframeY=\ESKD@margin@b
    \ESKDstampX=\ESKDframeX
    \advance\ESKDstampX \ESKDframeW
    \advance\ESKDstampX -185mm
    \ESKDstampY=\ESKDframeY    
    \sbox\ESKDpicturebox{%
      \unitlength=1mm
      \begin{picture}(0,0)(\ESKDltu{\ESKD@origin@x},\ESKDltu{\ESKD@origin@y})%
        \ifx\ESKD@thisstyle\@empty
          \let\ESKD@thisstyle\ESKD@curstyle
        \fi
        \loop
        \ifnum \ESKD@hash@pos{@style@draw@\ESKD@thisstyle} %
          < \ESKD@hash@count{@style@draw@\ESKD@thisstyle}
          \ESKD@hash@next@value{@style@draw@\ESKD@thisstyle}\relax
          \repeat
          \ifx\ESKD@extra@ThisHook\@empty%
            \ESKD@extra@Hook\else\ESKD@extra@ThisHook%
          \fi%
          \global\let\ESKD@thisstyle\@empty%
          \global\let\ESKD@extra@ThisHook\@empty%
        \end{picture}
      }%
      \AddToHook{shipout/foreground}{%
        \put(1in,-1in){\usebox\ESKDpicturebox}}%
    }
    
\fi

