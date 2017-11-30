" Use Vim settings, rather then Vi settings
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')
 
" Make sure you use single quotes
 
Plug 'ervandew/supertab'
"Plug 'valloric/youcompleteme', { 'do': './install.py' }
Plug 'jlanzarotta/bufexplorer'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'vim-syntastic/syntastic'
Plug 'jremmen/vim-ripgrep'
Plug 'pangloss/vim-javascript'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-fugitive'
"Plug 'wellle/targets.vim' " adds new text objects e.g. text between '_'
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'
"Plug 'Shougo/denite.nvim' " fuzzy finder
Plug 'wincent/command-t' , { 'do': 'cd ruby/command-t/ext/command-t && /usr/bin/ruby extconf.rb && make' }
"Plug 'ctrlpvim/ctrlp.vim' " fuzzy finder
 
" Initialize plugin system
call plug#end()

" turn on all filetype plugins
filetype plugin indent on

packadd! matchit

" RipGrep
let rg_binary="$HOME/.cargo/bin/rg"
let rg_command = g:rg_binary . ' --vimgrep'
map <c-g> :Rg<CR>
imap <c-g> <Esc>:Rg<CR>a

" NERDTree
map <c-s> :NERDTreeFind<CR>
imap <c-s> <Esc>:NERDTreeFind<CR>a
map <c-e> :NERDTreeToggle<CR>
imap <c-e> <Esc>:NERDTreeToggle<CR>a

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" movement and indenting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" no line wrapping
set nowrap

" tabs and spaces
" used for e.g. cindent and the '=' command
set shiftwidth=2
" number of spaces a tab character shows
set tabstop=2
" number of spaces generated by pressing the tab key
set softtabstop=0
set smarttab
set expandtab

" use alt-t to toggle tab expension
"map <a-t> :set expandtab!<CR>

" automatic indenting
set autoindent

" smart indenting causes lines starting with '#' character to lose all
" indentation, and is deprecated anyway. use Filetype indent scripts instead
set nosmartindent

" allow cursor keys to wrap to next/previous line
set whichwrap+=<,>,h,l,[,]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Code completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set omnifunc=syntaxcomplete#Complete

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File type specific options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" C/C++ programming helpers
augroup csrc
  au!
  autocmd FileType *      set nocindent
  autocmd FileType c,cpp  set cindent
  "autocmd FileType c,cpp  set noexpandtab
  autocmd FileType c,cpp  set shiftwidth=3
  autocmd FileType c,cpp  set tabstop=3
  autocmd FileType c,cpp  set softtabstop=3
augroup END

" ruby programming helpers
augroup rubysrc
  au!
  autocmd FileType *     set nocindent
  autocmd FileType ruby  set shiftwidth=2
  autocmd FileType ruby  set tabstop=2
  autocmd FileType ruby  set softtabstop=2
  "autocmd FileType ruby  set omnifunc=rubycomplete#Complete
  "autocmd FileType ruby  let g:rubycomplete_buffer_loading = 1
  "autocmd FileType ruby  let g:rubycomplete_classes_in_global = 1
  "autocmd FileType ruby  let g:rubycomplete_rails = 1
augroup END

" In Makefiles, don't expand tabs to spaces, since we need the actual tabs
autocmd FileType make set noexpandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlighting et al
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" syntax highlight on
syntax on

" incremental search, highlight search
set incsearch
set hlsearch

" turn off current search highlights
map <c-\> :nohlsearch<CR>
"imap <c-\> <Esc>:nohlsearch<CR>a

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Chrome
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" show current command
set showcmd

" show current mode
set showmode

" show autocomplete menus
set wildmenu
set wildmode=list:longest
set wildignore+=*.pyc,*.zip,*.gz,*.bz,*.tar,*.jpg,*.png,*.gif,*.avi,*.wmv,*.ogg,*.mp3,*.mov,*.swp,*.orig

" set autocomplete menu options
set completeopt=menu,longest

" show the status line at the bottom
set ruler

" show git branch in the status line
set statusline=%{fugitive#statusline()}\ %r%m%f%=%c\ %l/%L

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Windows-style movement
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" movement shortcuts
map <c-left> b
map <c-right> w
imap <c-left> <Esc>bi
imap <c-right> <Esc>wwi
map <a-right> 4zl
map <a-left> 4zh
imap <a-right> <Esc>4zl
imap <a-left> <Esc>4zh
map <c-l> 4zl
map <c-h> 4zh
imap <c-l> <Esc>4zla
imap <c-h> <Esc>4zha

" selection shortcuts
imap <s-left> <Esc>v
imap <s-right> <Esc>lv
imap <c-s-left> <Esc>vb
imap <c-s-right> <Esc>lve
imap <s-down> <Esc>v<down>
imap <s-up> <Esc>v<up>
imap <s-end> <Esc>lv<end>
imap <s-home> <Esc>v<home>
map <s-left> v<left>
map <s-right> v<right>
map <c-s-left> vb
map <c-s-right> ve
map <s-down> v<down>
map <s-up> v<up>
map <s-end> v<end>
map <s-home> v<home>
vmap <s-left> <left>
vmap <s-right> <right>
vmap <c-s-left> b
vmap <c-s-right> e
vmap <s-down> <down>
vmap <s-up> <up>
vmap <s-end> <end>
vmap <s-home> <home>

" handle movement shortcuts inside "screen" session.
" ctrl-pageup/down are already mapped to switch to the next/previous tabs.
" however "screen" garbles them
map <Esc>[5;5~ <C-PageUp>
map <Esc>[6;5~ <C-PageDown>
imap <Esc>[5;5~ <C-PageUp>
imap <Esc>[6;5~ <C-PageDown>
map <Esc>[1;5H <C-Home>
map <Esc>[1;5F <C-End>
imap <Esc>[1;5H <C-Home>
imap <Esc>[1;5F <C-End>
map <Esc>[1;2C <s-right>
map <Esc>[1;2D <s-left>
imap <Esc>[1;2C <s-right>
imap <Esc>[1;2D <s-left>
map <Esc>[1;2A <s-up>
map <Esc>[1;2B <s-down>
imap <Esc>[1;2A <s-up>
imap <Esc>[1;2B <s-down>
map <Esc>[1;2H <s-home>
map <Esc>[1;2F <s-end>
imap <Esc>[1;2H <s-home>
imap <Esc>[1;2F <s-end>
map <Esc>[1;5C <c-right>
map <Esc>[1;5D <c-left>
imap <Esc>[1;5C <c-right>
imap <Esc>[1;5D <c-left>
map <Esc>[1;6C <s-c-right>
map <Esc>[1;6D <s-c-left>
imap <Esc>[1;6C <s-c-right>
imap <Esc>[1;6D <s-c-left>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabs, split screen, scroll
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" tab shortcuts
map <a-]> :tabnext<CR>
map <a-[> :tabprevious<CR>
map <a-n> :tabnew<CR>
"map <a-e> :tabclose<CR>
imap <a-]> <Esc>:tabnext<CR>a
imap <a-[> <Esc>:tabprevious<CR>a
imap <a-n> <Esc>:tabnew<CR>a
"imap <a-e> <Esc>:tabclose<CR>a

" split window movement
imap <a-l> <Esc><c-w>la
imap <a-k> <Esc><c-w>ka
imap <a-j> <Esc><c-w>ja
imap <a-h> <Esc><c-w>ha
map <a-l> <c-w>l
map <a-k> <c-w>k
map <a-j> <c-w>j
map <a-h> <c-w>h

" split keeps size of windows
set noequalalways

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" QuickFix
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" quickfix shortcuts
map <c-j> :cn<CR>
map <c-k> :cp<CR>
imap <c-j> <Esc>:cn<CR>i<c-o>
imap <c-k> <Esc>:cp<CR>i<c-o>
"map <a-j> :cnewer<CR>
"map <a-k> :colder<CR>
"imap <a-j> <Esc>:cnewer<CR>i<c-o>
"imap <a-k> <Esc>:colder<CR>i<c-o>
map <a-down> :cn<CR>
map <a-up> :cp<CR>
imap <a-down> <Esc>:cn<CR>i<c-o>
imap <a-up> <Esc>:cp<CR>i<c-o>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"map <c-p> :set ft=python<CR>
"map  <c-e> <Plug>PimpEvalFile
"imap <c-e> <Esc><Plug>PimpEvalFilea
"vmap <c-e> <Plug>PimpEvalBlock

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Miscellaneous
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" remap the leader key to ','
let mapleader = ","

" do not briefly jump to matching brace
set noshowmatch

" surround selection with \parhead{}
vmap ,ph di\parhead{<Esc>pa}<Esc>

" quick quit
map <a-q> :q<enter>
imap <a-q> <Esc>:q<Enter>

" split line at the cursor
nmap <c-cr> i<cr>

" shifts using the keys '<' and '>' keep selection
" commented out since I can simply use '.' to repeat last shift
"vnoremap < <gv
"vnoremap > >gv

" font. 'set' does not work on Linux so we have to use 'let &' instead
"let &guifont="Monospace 10"

" stop cursor blinking
set gcr=a:blinkon0

" for the csapprox plugin
set t_Co=256

" automatically insert comment leaders
set formatoptions+=ro

" abbreviation for tabedit
"cab e tabedit

" remove the menu bar
aunmenu *
set guioptions-=m
set guioptions-=T

" fix the screen tearing problem
"set guioptions-=e

" search is case-insensitive
"set ignorecase
" unless they contain upper-case letters
"set smartcase

" prevent the creation of backup files (those ending with '~')
set nobackup

" prevent the creation of swap files (those ending with '.swp')
set noswapfile

" replace the ugly vertical split character with a simple inverted space
" note that the backslash is followed by a single space
set fcs+=vert:\ 
highlight VertSplit guifg='Gray'
highlight StatusLine guifg='Gray'
highlight StatusLineNC guifg='Gray'

" automatically write files before e.g. :make
set autowrite

" map F7 to call make
map <F7> :make<CR>
imap <F7> <Esc>:make<CR>a

" map <ctrl>+F12 to generate ctags for current folder:
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>

" map <ctrl>+F11 to grep for word under cursor
map <C-F11> yiw:vimgrep <C-R>0 **/*.c*<CR>

" set line end (newline) format
set ffs=unix,dos

" bufexplorer and friends
map <a-/> <Leader>be
map <a-.> :bn<Cr>
map <a-,> :bp<Cr>
map <a-=> :resize +1<Cr>
map <a--> :resize -1<Cr>

" jump to tag definition instead of declaration
noremap <c-]> 2<c-]>

" automatically put the selection contents in the paste buffer and the
" clipboard. when vim is finally at version >= 7.3.74 replace the lines.
" 
" *note* autoselecting to the selection buffer makes selecting then 
" pasting previous content impossible since the new content is selected
" instead. so this option is disabled until a solution is found (i.e.
" autoselecting only to the clipboard and not the paste buffer).
"
"set clipboard=autoselect,unnamed,exclude:cons\|linux
"set clipboard=autoselect,unnamedplus,exclude:cons\|linux

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Platform specific
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" resize the window to a sane size
if has("gui_running") && !has("mac")
  "set lines=54 columns=140
  "au GUIEnter * simalt ~x
endif

if has("windows") || has("win32") || has("win64") || has("win32unix")
  " Following is Windows-Only, including cygwin

  " selection mode etc. as in x-windows
  behave xterm

  " font
  set guifont=Courier_New:h10:cANSI

  " make related
  "set mef=V:\\MakeErrorFile##.txt
  "set makeprg=cmd.exe\ /C\ BuildIt.bat

  " NERDTree
  let NERDChristmasTree = 1
"  augroup NerdTreeAL
"    au!
"    autocmd VimEnter * NERDTree | wincmd l
"    autocmd TabEnter * NERDTreeMirror
"    autocmd BufAdd * NERDTreeMirror | wincmd l
"  augroup END

  " fix cygwin shell redirection
  set shellredir=>\"%s\"\ 2>&1

  " indenting
  "autocmd FileType c,cpp set noexpandtab
  set shiftwidth=4
  set tabstop=4
  set softtabstop=4
endif

if has("mac")
  " indenting
  "autocmd FileType c,cpp set noexpandtab
  set shiftwidth=4
  set tabstop=4
  set softtabstop=4

  " clang binary for clang_complete plugin
  "let clang_exec = '/Users/johndoe/Downloads/clang+llvm-2.9-x86_64-apple-darwin10/bin/clang'
  let clang_exec = '~/Downloads/clang+llvm-2.9-x86_64-apple-darwin10/bin/clang'

  " use option as meta
  autocmd BufEnter * set macmeta

  " highlight search in yellow
  highlight Search guibg=yellow

  " on the mac map the command key to buffer explorer
  "map <d-/> <Leader>be

  " use standard unix newline character
  set fileformat=unix
endif

if has("win32unix")
  " Following is Cygwin-Only
  " backspace doesn't delete under cygwin - fix it
  set backspace=2
endif

if &diff
    "colorscheme evening
    syntax off
endif
