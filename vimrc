syntax enable
set nocompatible
filetype plugin on
set background=dark
set mouse=
set tags=./tags,tags,/home/sam/.commontags/boids

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" ## Movement
map J jjjjj
map K kkkkk
map H hhhhhhhhhh
map L llllllllll
" nmap <C-j> jzz
" nmap <C-k> kzz
nmap <S-Up> ddkP
nmap <S-Down> ddp
nmap e :bn<cr>
nmap E :bp<cr>
nmap s :w<cr>
nmap Q :q<cr>

nmap tt :q<cr>

nmap gm 50%

" ## Settings
set nowrap
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set nu
set hlsearch
set listchars=tab:<=>,trail:-
set list
set formatoptions-=cro
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set nojoinspaces " Don't adjoin two sentences with two space characters as is default.
set dictionary+=/usr/share/dict/words " In insert mode, C-X, C-K will bring up the completion list

" ## Search
nmap ? /^\w.\+
set incsearch

" ## Syntax Highlighting
hi diffAdded ctermfg=green
hi diffRemoved ctermfg=red
highlight Pmenu ctermbg=white guibg=white ctermfg=black guifg=black

" ## Filetype-specific Settings
au BufRead,BufNewFile *.frag.html set tw=80
au BufRead,BufNewFile *.frag.html set spell
au BufRead,BufNewFile README.md set tw=80
au BufRead,BufNewFile README.md set spell
au BufRead,BufNewFile *.sbk set tw=80
au BufRead,BufNewFile *.sbk set spell
au BufRead,BufNewFile /tmp/terminal-calendar/cal* set spell
au BufRead,BufNewFile *.c :nmap = ggVG:!clang-format -style="{ColumnLimit: 0}"
au BufRead,BufNewFile *.cpp :nmap = ggVG:!clang-format -style="{ColumnLimit: 0}"
au BufRead,BufNewFile *.rs :nmap = ggVG:!rustfmt
au! BufNewFile,BufRead *.rs :execute '!ctags --recurse src/' | redraw!

augroup syntaxset
  au BufRead,BufNewFile *.fish :set syntax=bash
augroup END
augroup syntaxset
  au BufRead,BufNewFile /tmp/terminal-calendar/cal* :set syntax=scal
augroup END
augroup syntaxset
  au BufRead,BufNewFile /home/sam/text/dailies :set syntax=dailies
  au BufRead,BufNewFile /home/sam/text/dailies :vmap S :!sort_dailies<cr>
  au BufRead,BufNewFile /home/sam/text/dailies :set rnu
augroup END
augroup syntaxset
  au BufRead,BufNewFile *.slog :set syntax=slog
augroup END

" ## Misc

" Recent files
nmap R :bro ol<cr>

" Insert formatted TODO
nmap <C-o> o// TODO(sam, <Esc>
      \:read !date -Idate<cr>I<Backspace><Esc>
      \:read !dmenu -i -l 30 < ~/.config/nvim/TODO_categories<cr>
      \I<Backspace>, <Esc>A): 

" Debug from line in editor
nmap <F2> :call system('make clean && make debug && st -e lldb --one-line "b '..@%..":"..line(".")..'" --one-line "run" ./build/main')<cr><cr>

fu! InlineRead(command)
  let colnum = col('.') - 1
  let line = getline('.')
  call setline('.', strpart(line, 0, colnum) . system(a:command) . strpart(line, colnum))
endfu

nmap <C-k> :call InlineRead("get_codepoint")<cr>lxh

" Execute vimscript on current line
nmap D yy@"

nmap F mm:%!clang-format<cr>'mzz
nmap <C-s> :read !snip<cr>
vmap <C-s> :!spongebob_case_random<cr>
vmap <c-t> :!spongebob_case_toggle<cr>
map gy "*y
map gp "*p
vmap s :sort<cr>

" Copy syntax-highlighted text to HTML
let g:html_number_lines = 0
map C :TOhtml<cr>/vimCodeElement<cr>V/<\/pre><cr>"*y:q!<cr>

" Insert TODO
nmap ,/ :set paste<cr>yyppkka/*<Esc>ja * TODO<Esc>ja */<esc>:set nopaste<cr>

"" for html/css/javascript syntax highlighting
"syntax sync fromstart

" Disable plugin section
" let g:ale_enabled = 1

" ## Plugins

call plug#begin('~/.config/nvim/plugged')

" Plug 'rust-lang/rust.vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'dense-analysis/ale'

call plug#end()

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

Plugin 'AckslD/messages.nvim' " Shows messages in floating buffer
Plugin 'SirVer/ultisnips' " Snippet expander
Plugin 'VundleVim/Vundle.vim' " Package manager
Plugin 'airblade/vim-gitgutter.git' " Display status of lines in the leftmost line
Plugin 'bling/vim-bufferline' " Lists the open buffers in the status line
Plugin 'honza/vim-snippets' " Provides useful data for snippets
Plugin 'jbyuki/venn.nvim' " Draw ASCII diagrams
Plugin 'lcheylus/overlength.nvim' " Highlights lines that are too long
Plugin 'nvim-lua/plenary.nvim' " Useful functions, dependency for other plugins
Plugin 'nvim-telescope/telescope.nvim' " Opens search windows for files and strings
Plugin 'nvim-treesitter/nvim-treesitter' " Syntax highlighting
Plugin 'petertriho/nvim-scrollbar' " Adds a scrollbar on the right side
Plugin 'preservim/nerdtree' " File browser
Plugin 'preservim/tagbar' " Browse tags ordered by scope
Plugin 'rcarriga/nvim-notify' " Notification manager
Plugin 'rust-lang/rust.vim' " Error checking and formatting for Rust (error highlighting)
Plugin 'sidebar-nvim/sidebar.nvim' " Sidebar
Plugin 'tpope/vim-fugitive.git' " Git commands
Plugin 'valloric/YouCompleteMe' " Autocomplete and preview window and red arrows indicating syntax errors
" Plugin 'gorbit99/codewindow.nvim'
" Plugin 'echasnovski/mini.nvim'

" Figure out what these two are about:
" Plugin 'neoclide/coc.nvim', {'branch': 'release'} " ??? Might just be node.js thing
Plugin 'dense-analysis/ale' " Display code issues

call vundle#end()            " required
filetype plugin indent on    " required

" Plugin-specific

" If no buffer specified, open NERDTree automatically
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

nmap <F8> :TagbarToggle<CR>

" windows default encoding is not supported
set encoding=utf-8

" Load YCM (only)
let &rtp .= ',' . expand( '<sfile>:p:h' )

let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:rustfmt_autosave = 1

let g:UltiSnipsExpandTrigger=","
let g:UltiSnipsListSnippets="<c-l>"

let g:ycm_max_num_candidates = 0

" nmap O :Telescope find_files<cr>
nnoremap ff :Telescope find_files<cr>
nnoremap fg :Telescope live_grep<cr>
nnoremap fG :Telescope grep_string search=<c-r><c-w><cr>
nnoremap fb :Telescope buffers<cr>
nnoremap fh :Telescope help_tags<cr>

lua require('overlength').setup()

lua require("scrollbar").setup()

lua vim.opt.termguicolors = true
lua require("notify").setup({background_colour = "#000000",})
highlight NotifyERRORBorder guifg=#8A1F1F
highlight NotifyWARNBorder guifg=#79491D
highlight NotifyINFOBorder guifg=#4F6752
highlight NotifyDEBUGBorder guifg=#8B8B8B
highlight NotifyTRACEBorder guifg=#4F3552
highlight NotifyERRORIcon guifg=#F70067
highlight NotifyWARNIcon guifg=#F79000
highlight NotifyINFOIcon guifg=#A9FF68
highlight NotifyDEBUGIcon guifg=#8B8B8B
highlight NotifyTRACEIcon guifg=#D484FF
highlight NotifyERRORTitle  guifg=#F70067
highlight NotifyWARNTitle guifg=#F79000
highlight NotifyINFOTitle guifg=#A9FF68
highlight NotifyDEBUGTitle  guifg=#8B8B8B
highlight NotifyTRACETitle  guifg=#D484FF
highlight link NotifyERRORBody Normal
highlight link NotifyWARNBody Normal
highlight link NotifyINFOBody Normal
highlight link NotifyDEBUGBody Normal
highlight link NotifyTRACEBody Normal

nmap ! :bd<cr>

vmap S :GitGutterStageHunk<cr>

" ## Statusline
" TODO: Colors
function! Foo()
  return line2byte(line('$') + 1)
endfunction

function! Bar()
  let a='N/A'
  if has_key(wordcount(), 'visual_words')
    let a=wordcount().visual_words
  endif
  return a
endfunction

function! Baz()
  let a='N/A'
  if has_key(wordcount(), 'visual_words')
    let a=wordcount().visual_words
  endif
  return a
endfunction

set laststatus=2

" hi NormalColor guifg=Black guibg=Green ctermbg=46 ctermfg=0
" hi InsertColor guifg=Black guibg=Cyan ctermbg=51 ctermfg=0
" hi ReplaceColor guifg=Black guibg=maroon1 ctermbg=165 ctermfg=0
" hi VisualColor guifg=Black guibg=Orange ctermbg=202 ctermfg=0

set statusline=
" set statusline+=%#NormalColor#%{(mode()=='n')?'\ \ NORMAL\ ':''}
" set statusline+=%#InsertColor#%{(mode()=='i')?'\ \ INSERT\ ':''}
" set statusline+=%#ReplaceColor#%{(mode()=='R')?'\ \ REPLACE\ ':''}
" set statusline+=%#VisualColor#%{(mode()=='v')?'\ \ VISUAL\ ':''}

set statusline+=%f " Filename
set statusline+=\ 
set statusline+=%h " Help buffer flag
set statusline+=%w " Preview flag
set statusline+=%m " Modified flag
set statusline+=%r " Readonly flag
set statusline+=\ 
set statusline+=%{nvim_treesitter#statusline(90)}
set statusline+=%=
set statusline+=%(Selection=%{Bar()}\ Words=%{wordcount().words}\ Bytes=%{Foo()}\ %l,%c%V\ %=\ %P%)
"set statusline=
"set statusline+=hello
"set statusline+=%#DiffChange#
"set statusline+=world
"set statusline+=%{StatuslineGit()}

" Use ~/bin/colors to select color
" hi Search ctermfg=208 ctermbg=0 cterm=reverse

" :hi Pmenu ctermbg=cyan


" lua require('codewindow').setup()
" lua require('codewindow').apply_default_keybinds()
" lua require('codewindow').open_minimap()
" lua require('mini.map').setup()
" lua require('mini.map').open()

" fu! Somefunc()
"   :vsplit newbuf
"   let a=10
"   :call append(0, a)
" endfu
"
" nmap <F3> :call Somefunc()<cr>
