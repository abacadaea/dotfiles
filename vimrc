set nocp
set number

"""Ray's stuff
set textwidth=90

"Set editing defaults
set ts=4
set sw=4
set et
au FileType html,htmljinja,jinja,htmldjango,js,javascript,tex,css setl sw=2 ts=2 et

syntax on
set smartindent
set makeprg=pdflatex\ %:r;open\ %:r.pdf

"""Stolen stuff

"Default backspace like normal
set bs=2

"Turn on highlighting search
set hlsearch

"Show the position of the cursor.
set ruler

"Show matching parenthese.
set showmatch
set mat=2

"Set the font
set guifont=-misc-console-medium-r-normal--16-160-72-72-c-160-iso10646-1
set guifontset=

"Turn on matching search
set is
set scs

"Hide mouse when typing
set mh

"Change default matching behaviour
set wildmode=longest,list

" Make it so that these commands don't complain
command! WQ wq
command! Wq wq
command! Wqa wqa
command! W w
command! Q q

" Helper commands for running Make with my Makefiles
command! V make view
command! Wv w | make view
command! WV w | make view

set linebreak
set scrolloff=3

" Make it so that using long, wrapped lines will behave like normal lines
noremap <buffer> <silent> k gk
noremap <buffer> <silent> j gj
noremap <buffer> <silent> 0 g0
noremap <buffer> <silent> $ g$
noremap <buffer> <silent> ^ g^
noremap <buffer> <silent> _ g_

" set get rid of obnoxious '-' characters in folds
set foldmethod=syntax
set fillchars=fold:\ ,

" qt or tq to close tab
cabbrev qt tabclose
cabbrev tq tabclose
command! Qt qt
command! QT qt
command! Tq qt
command! TQ qt

" Lower ^[ timeout
set timeoutlen=100

" Vertical splits use right half of screen
set splitright

" better man page support
noremap K :Man <cword>
