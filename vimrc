" Use NeoBundle to manage plugins {{{
set nocompatible
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundleCheck

" github plugins
NeoBundle 'ervandew/supertab'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'jcf/vim-latex'
NeoBundle 'klen/python-mode'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'scrooloose/syntastic'
NeoBundle "MarcWeber/vim-addon-mw-utils"
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'garbas/vim-snipmate'
NeoBundle 'honza/vim-snippets'
NeoBundle 'szw/vim-dict'
call neobundle#end()
" }}}


" open .vimrc in a separate window
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
" reload the .vimrc file and then return the current cursor location
nnoremap <leader>sv ma:source $MYVIMRC<CR>`a


" General {{{
set modeline 
set nobackup
set incsearch
set hlsearch " hightlight search
set showmode
set wildmenu
set ruler
set number
set scrolloff=999

if has('gui_running')
    colorscheme desert
else
    colorscheme darkblue
endif

if has('mouse')
    set mouse=a " enable mouse click
endif

" now you can use Ctrl + X then K to autocomplete text and markdown 
" file according to the provided dictionary
if has('mac')
    set dictionary+=/usr/share/dict/words
    autocmd FileType text,markdown setlocal complete+=k
endif
" }}}


" Customsized Control {{{
" Windows splits
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" page up and page down
nnoremap <c-f> <nop> 
nnoremap <c-n> <PageDown> 
nnoremap <c-b> <nop>
nnoremap <c-p> <PageUp>

" ctrl + a to select all
nnoremap <c-a> <esc>ggvG<cr>

" exit from insert mode to normal mode
inoremap jk <esc>

nnoremap H ^
nnoremap L g_

" insert timestamp
nmap <leader>id a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
imap <leader>id <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

" indent the entire file
nnoremap <buffer> <localleader>ii magg=G`a

nnoremap <c-s> :w<CR>
inoremap <c-s> <Esc>:w<CR>a
" }}}


" Formatting {{{
set encoding=utf-8
set smartindent
set autoindent 
set smarttab
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

syntax on
filetype plugin indent on

" re-wrap paragraph
nnoremap <leader>w gq}
""" }}}


" Python {{{
augroup filetype_python
    autocmd! 
    autocmd FileType python setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4  
augroup END
" }}}


" Latex {{{
let g:tex_flavor='latex'
" bib complete
if has('mac')
    " because it is not easy to make F9 work, we map it to another key
    " Ctrl + X then B. Of course, you can still use F9 (Fn + F9)
    imap <C-X><C-B> <F9>
endif

" by default the latex format is dvi, we change it to pdf
let g:Tex_DefaultTargetFormat = 'pdf'
" this is a little tricky, you can Google for the answer. 
" Basically, it enables bibtex to be automatically execute
" whenever required to keep the file updated. Sometimes, you 
" can also use 
" let g:Tex_MultipleCompileFormats = 'pdf, aux'
let g:Tex_MultipleCompileFormats = 'pdf'

" define the compilation rule for pdf
let g:Tex_CompileRule_pdf = 'pdflatex --shell-escape -synctex=1 --interaction=nonstopmode $*'
" Use Skim to open PDF file, open -a Skim is Mac OS command
let g:Tex_ViewRule_pdf = 'open -a Skim'

" if set to 1, pressing \ll will take you to the first warning/error
let g:Tex_GotoError = 1

" do not use Makefile
let g:Tex_UseMakefile = 0

" define a shortcut to compile and forward search, it's handy
nmap <leader>lp <leader>ll <leader>ls

augroup filetype_tex
    autocmd!
    autocmd FileType tex setlocal textwidth=72
augroup END

function! Tex_ForwardSearchLaTeX()
    let cmd = '/Applications/Skim.app/Contents/SharedSupport/displayline -r ' . line(".") . ' ' . fnameescape(fnamemodify(Tex_GetMainFileName(), ":p:r")) .  '.pdf ' . fnameescape(expand("%:p"))
    let output = system(cmd)
endfunction
" }}}

" NERDTRee {{{
nnoremap <leader>n :NERDTreeToggle<CR>
""" }}}


" folding method for vim file
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END


autocmd BufRead,BufNewFile {*.md,*.mkd,*.markdown} setlocal filetype=markdown 


if empty(glob('~/.vim/utils.vim'))
    echom 'file ' . '~/.vim/utils.vim ' . 'not found'
else
    source ~/.vim/utils.vim
endif
