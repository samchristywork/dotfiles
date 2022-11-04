syntax enable
set nocompatible
filetype plugin on
set background=dark

" Movement
map J jjjjj
map K kkkkk
map H hhhhh
map L lllll
nmap <C-j> jzz
nmap <C-k> kzz
nmap e :bn<cr>
nmap E :bp<cr>
nmap s :w<cr>
nmap Q :q<cr>

" Settings
set wrap!
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set nu
set hlsearch
set listchars=tab:<=>,trail:-
set list
set formatoptions-=cro
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set nojoinspaces " Don't adjoin two sentences with two space characters as is default.
set dictionary+=/usr/share/dict/words " In insert mode, C-X, C-K will bring up the completion list

" Search
nmap ? /^\w.\+
set incsearch

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Syntax Highlighting
hi diffAdded ctermfg=green
hi diffRemoved ctermfg=red
nmap gm 50%

" Filetype-specific Settings
au BufRead,BufNewFile *.frag.html set tw=80
au BufRead,BufNewFile *.frag.html set spell
au BufRead,BufNewFile README.md set tw=80
au BufRead,BufNewFile README.md set spell
au BufRead,BufNewFile *.sbk set tw=80
au BufRead,BufNewFile *.sbk set spell
au BufRead,BufNewFile /tmp/terminal-calendar/cal* set spell
augroup syntaxset
  au BufRead,BufNewFile /tmp/terminal-calendar/cal* :set syntax=scal
augroup END
augroup syntaxset
  au BufRead,BufNewFile *.slog :set syntax=slog
augroup END
au BufRead,BufNewFile *.c :nmap = ggVG:!clang-format -style="{ColumnLimit: 0}"
au BufRead,BufNewFile *.cpp :nmap = ggVG:!clang-format -style="{ColumnLimit: 0}"
au BufRead,BufNewFile *.rs :nmap = ggVG:!rustfmt

" Misc
nmap <C-s> :read !snip<cr>
vmap <C-s> :!spongebob_case_random<cr>
vmap <c-t> :!spongebob_case_toggle<cr>
map gy "*y
map gp "*p
vmap s :sort<cr>

let g:html_number_lines = 0
map C :TOhtml<cr>/vimCodeElement<cr>V/<\/pre><cr>"*y:q!<cr>

nmap ,/ :set paste<cr>yyppkka/*<Esc>ja * TODO<Esc>ja */<esc>:set nopaste<cr>

"" for html/css/javascript syntax highlighting
"syntax sync fromstart

" Disable plugin section
let g:ale_enabled = 0

call plug#begin('~/.config/nvim/plugged')

Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'

call plug#end()

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

call vundle#end()            " required
filetype plugin indent on    " required

" windows default encoding is not supported
set encoding=utf-8

" Load YCM (only)
let &rtp .= ',' . expand( '<sfile>:p:h' )

nmap <F5> :!cargo run<cr>

let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1 "Not working ??

let g:rustfmt_autosave = 1

let g:UltiSnipsExpandTrigger=","
let g:UltiSnipsListSnippets="<c-l>"
