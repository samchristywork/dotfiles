if has("syntax")
  syntax on
endif

filetype plugin indent on

nmap J 5j
nmap K 5k
nmap H 10h
nmap L 10l
vmap J 5j
vmap K 5k
vmap H 10h
vmap L 10l
nmap P :read !xclip -o<cr>
nmap <silent> e :silent! bn<cr>
nmap <silent> E :silent! bp<cr>
set autoindent
set backspace=indent,eol,start
set bg=dark
set confirm
set expandtab
set hlsearch
set ignorecase
set incsearch
set list
set listchars=tab:<=>,trail:-
set nowrap
set number
set scrolloff=20
set shiftwidth=2
set showcmd
set showmatch
set smartcase
set smarttab
set softtabstop=2
set tabstop=2
set termguicolors
set title
set tw=80

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

au BufReadPost *.go {
  set nolist
  set noexpandtab
}

" Set the cursor shape in different modes
if has('nvim') || has('vim_starting')
    let &t_SI = "\e[6 q"   " Cursor shape to line in insert mode
    let &t_SR = "\e[4 q"   " Cursor shape to beam in replace mode
    let &t_EI = "\e[2 q"   " Cursor shape to block in normal mode
endif

set ttimeoutlen=10 " Make exiting insert mode a bit snappier.

highlight SignColumn ctermbg=NONE guibg=NONE

set laststatus=0

let g:html_number_lines=0
let g:html_use_css=0

"set cursorline

function! OpenOrCreateFile()
  let filename = expand('<cfile>')
  if !empty(filename)
    if filereadable(filename) || !exists(filename)
      execute 'edit' filename
    else
      execute 'edit' filename
    endif
  endif
endfunction

"nnoremap gf :call OpenOrCreateFile()<CR>

set noautoindent  " Disable auto-indentation
set nosmartindent  " Disable smart indentation
set nocindent  " Disable C/C++ style indentation

highlight OverLength ctermbg=red guibg=red
match OverLength /\%81v./
