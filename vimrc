""TODO: Highlight '$th's, 'will', '\ref{eq:' and similar common latex errors.
set nocp
set number

"""Ray's stuff
" Key remaps
nmap <S-CR> O<Esc>j
nmap <CR> o<Esc>k

inoremap <C-D> ()<Left>
au BufNewFile,BufRead *.tex inoremap <C-F> $$<Left>
au BufNewFile,BufRead *.tex inoremap <C-B> {}<Left>
au BufNewFile,BufRead *.tex inoremap <C-V> <Esc>I%<Left>
au BufNewFile,BufRead *.tex inoremap <C-E> <Bslash>begin{equation}<CR><Bslash>end{equation}<Esc>O
au BufNewFile,BufRead *.tex inoremap <C-A> <Bslash>begin{align}<CR><Bslash>end{align}<Esc>O


set textwidth=90

"Set editing defaults
set et
set sw=2
set ts=2

au FileType python setl sw=4 ts=4
au BufNewFile,BufRead *.tex setl ft=tex textwidth=0

syntax on
set smartindent
set makeprg=pdflatex\ %:r;open\ %:r.pdf

"Allow mouse clicking
set mouse=a

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
set wildmode=longest,list,full
set wildmenu

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
