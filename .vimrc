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
"Plug 'jlanzarotta/bufexplorer'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
"Plug 'vim-syntastic/syntastic' " conflicts with w0rp/ale
Plug 'nushoin/vim-ripgrep'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-bundler'
" vim-fugitive is for git stuff
Plug 'tpope/vim-fugitive'
" convert between camelCase, snake_case etc
Plug 'chiedo/vim-case-convert'
" w0rp/ale 'Asynchronous Lint Engine'
" Plug 'w0rp/ale' ALE moved to dense-analysis
Plug 'dense-analysis/ale'
"Plug 'wellle/targets.vim' " adds new text objects e.g. text between '_'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'Shougo/denite.nvim' " fuzzy finder
"Plug 'wincent/command-t' , { 'do': 'cd ruby/command-t/ext/command-t && /usr/bin/ruby extconf.rb && make' }
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'wsdjeg/FlyGrep.vim'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'towolf/vim-helm'

" Initialize plugin system
call plug#end()

" turn on all filetype plugins
filetype plugin indent on

" remap the leader key to ','
let mapleader = ","

" load the matchit plugin that is bundled with vim
if has('nvim')
  runtime! macros/matchit.vim
else
  packadd! matchit
endif

" lint the entire project, errors go to the quickfix window
command! -bang EsLintAll :cexpr system('node ./node_modules/eslint/bin/eslint.js -c .eslintrc.json --format unix --ignore-pattern node_modules .')

set omnifunc=ale#completion#OmniFunc

" Use separate compile_commands.json for clangtidy since if we pass `-D__SIZE_TYPE__='unsigned int'`
" to clangtidy, it takes ~10 seconds to format a file
let g:ale_c_clangtidy_extra_options = '-p ./clang-tidy-config'
let g:ale_cpp_clangtidy_extra_options = '-p ./clang-tidy-config'

let g:ale_fix_on_save = 1
let g:ale_floating_preview = 1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']

let g:ale_python_pylsp_config = {
      \   'pylsp': {
      \     'plugins': {
      \       'pycodestyle': {
      \         'maxLineLength': 100,
      \       }
      \     }
      \   },
      \ }

" currently disable all linters. to enable comment out this section and optionally
" uncomment the next section.
"let g:ale_linters = {
"\   'javascript': [],
"\}
let g:ale_linters = {
      \   'javascript': ['eslint'],
      \   'typescript': ['eslint', 'tsserver'],
      \   'c': ['clangd'],
      \   'cpp': ['clangd'],
      \   'python': ['pylint', 'pylsp'],
      \   'sh': ['language_server', 'shellcheck'],
      \}

let g:ale_fixers = {
      \   'c': ['clang-format', 'clangtidy'],
      \   'cpp': ['clang-format', 'clangtidy'],
      \   'python': ['yapf'],
      \}

" let ALE do auto completion
let g:ale_completion_enabled = 1

" When using eslint with ALE, enable the cache
let g:ale_javascript_eslint_options = "--cache"

" `git rev-parse --show-toplevel` returns the root folder of the current git
" repo. so the following settings adds an include search path to <project root
" folder>/_build, which is useful for e.g. the gtk project
let g:project_root = "`git rev-parse --show-toplevel`"
let g:ale_c_gcc_options =  "-std=c11 -Wall -I" . g:project_root . "/_build"
let g:ale_c_gcc_options .= " -DGTK_COMPILATION -DGDK_COMPILATION -DG_ENABLE_DEBUG"
let g:ale_c_gcc_options .= " -I/usr/include/glib-2.0"
let g:ale_c_gcc_options .= " -I/usr/include/cairo"
let g:ale_c_gcc_options .= " -I/usr/include/pango-1.0"
let g:ale_c_gcc_options .= " -I/usr/include/harfbuzz"
let g:ale_c_gcc_options .= " -I/usr/include/gdk-pixbuf-2.0"
let g:ale_c_gcc_options .= " -I/usr/include/atk-1.0"
let g:ale_c_gcc_options .= " -I/usr/lib/x86_64-linux-gnu/glib-2.0/include"
let g:ale_c_gcc_options .= " -I" . g:project_root
let g:ale_c_gcc_options .= " -I" . g:project_root . "/gdk"
let g:ale_c_gcc_options .= " -I" . g:project_root . "/gtk"
let g:ale_c_gcc_options .= " -I" . g:project_root . "/subprojects/graphene/include"
let g:ale_c_gcc_options .= " -I" . g:project_root . "/subprojects/glib/glib"
let g:ale_c_gcc_options .= " -I" . g:project_root . "/_build"
let g:ale_c_gcc_options .= " -I" . g:project_root . "/_build/gdk"
let g:ale_c_gcc_options .= " -I" . g:project_root . "/_build/gdk/wayland"
let g:ale_c_gcc_options .= " -I" . g:project_root . "/_build/gtk"
let g:ale_c_gcc_options .= " -I" . g:project_root . "/_build/subprojects/graphene/src"
let g:ale_c_gcc_options .= " -I" . g:project_root . "/_build/subprojects/graphene/include"
let g:ale_c_gcc_options .= " -I" . g:project_root . "/_build/demos/gtk-demo"

" ALE clang
"let g:ale_c_clang_executable = "clang-8"
"let g:ale_c_clang_options = g:ale_c_gcc_options

" Toggle ALE fix-on-save. Due to some reason this isn't in ALE proper, see
" https://github.com/dense-analysis/ale/issues/1353
command! ALEToggleFixer execute "let g:ale_fix_on_save = get(g:, 'ale_fix_on_save', 0) ? 0 : 1"

" RipGrep
let rg_binary="rg"
let rg_command = g:rg_binary . ' --vimgrep'
map <c-g> :Rg<CR>
imap <c-g> <Esc>:Rg<CR>a

" grep for word under cursor in current buffer
map <c-y> yiw*:vimgrep "\<<C-R>0\>" %<CR>:copen<CR>
imap <c-y> <Esc>yiw*:vimgrep "\<<C-R>0\>" %<CR>:copen<CR>

" set ripgrep as the default grep program
let &grepprg=g:rg_binary . ' --color=never'

"
" FZF
"

" Use ctrl-a to copy everything from fzf to the quickfix, ctrl-t to toggle selection of all items
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all+accept,ctrl-t:toggle-all'

" Remove ctrl-t from the default action shortcuts (see README-VIM.md in the fzf git repo), so it can be used for toggle
" selection (see $FZF_DEFAULT_OPTS)
let g:fzf_action = {
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Use fzf to delete buffers. Taken from https://github.com/junegunn/fzf.vim/pull/733#issuecomment-559720813
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BuffersDelete call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
  \ }))

noremap <Leader>bg :BuffersDelete<CR>

" Close all buffers except for the current one
command! BufOnly silent execute '%bdelete|edit #|normal `"'
noremap <Leader>bo :BufOnly<CR>

" RipGrep + fzf. This one basically disables fzf and only uses ripgrep.
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" On-the-fly find-in-files, continuous query
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" On-the-fly find-in-files, fuzzy query, using word under cursor
" The options passed to with_preview() are for ignoring the file name. This is done by using ':' as the field delimiter
" and starting from the 4th field.
command! -nargs=* -bang Rgw
  \ call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(expand('<cword>')),
  \                   1,
  \                   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}),
  \                   <bang>0)

" On-the-fly find-in-files, fuzzy query, using command arguments
command! -nargs=* -bang Rgg
  \ call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>),
  \                   1,
  \                   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}),
  \                   <bang>0)

command! -nargs=? -bang -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'source': 'fdfind --hidden --type f'}), <bang>0)

" ctrl-p for files
map <c-p> :Files<CR>

" fuzzy find in current buffer
" c-_ actually maps to c-/
map <c-_> :BLines<CR>

" open buffers
noremap <Leader>be :Buffers<CR>

" find-in-files as-you-type, case insensitive exact match
map <Leader>ef :RG<CR>

" find-in-files as-you-type, fuzzy match
map <Leader>ff :Rgg<CR>

" find-in-files as-you-type, start with word under cursor
map <Leader>rg :Rgw<CR>

" NERDTree
map <c-s> :NERDTreeFind<CR>
imap <c-s> <Esc>:NERDTreeFind<CR>a
map <c-e> :NERDTreeToggle<CR>
imap <c-e> <Esc>:NERDTreeToggle<CR>a

"" CtrlP
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_user_command = g:rg_binary . ' %s --files --color=never --glob ""'
"let g:ctrlp_use_caching = 0

" map shift-insert to paste in a terminal buffer.
" on Mac keyboards that is Shift-Fn-Return
tmap <S-Insert> <C-W>"0

"" FlyGrep
"let g:spacevim_debug_level = 0

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
set softtabstop=2
set smarttab
set expandtab
" for comment formatting (gq) etc
set textwidth=100

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

" I use ALE for completion
" set omnifunc=syntaxcomplete#Complete

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

map gh <Plug>(ale_hover)
map gd <Plug>(ale_go_to_definition)
map gt <Plug>(ale_detail)
map gr <Plug>(ale_find_references)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File type specific options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd FileType *      set nocindent

" TypeScript programming helpers
augroup tssrc
  au!

  " lint.sh contents:
  " #!/bin/bash
  " LINT=$PWD/node_modules/eslint/bin/eslint.js
  " git ls-files|grep "\.js$\|\.ts$"|xargs $LINT $* --color=false
  let g:linter_script = g:project_root . "/negu/lint.sh"
  autocmd FileType javascript let &l:makeprg=g:linter_script
  autocmd FileType typescript let &l:makeprg=g:linter_script

  autocmd FileType typescript set smartindent
  autocmd FileType typescript set nocindent
  "autocmd FileType typescript set expandtab

  " set the defaults
  autocmd FileType typescript set shiftwidth=2
  autocmd FileType typescript set tabstop=2
  autocmd FileType typescript set softtabstop=2
augroup END

" C/C++ programming helpers
augroup csrc
  au!
  " note: the following line forces treating 'h' files as 'C' rather than 'C++'
  " autocmd BufRead,BufNewFile *.h set filetype=c
  autocmd FileType c,cpp  set smartindent
  autocmd FileType c,cpp  set cindent
  "autocmd FileType c,cpp  set noexpandtab

  " set the defaults
  autocmd FileType c,cpp  set shiftwidth=2
  "autocmd FileType c,cpp  set tabstop=2
  autocmd FileType c,cpp  set softtabstop=2
augroup END

" ruby programming helpers
augroup rubysrc
  au!
  autocmd FileType ruby  set nocindent
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

augroup gherkin_template
  au!
  autocmd BufNewFile,BufRead *.feature.template set syntax=cucumber
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax highlighting et al
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" syntax highlight on
syntax on

" incremental search, highlight search
set incsearch
set hlsearch

" turn off current search highlights
map <c-\> :nohlsearch<CR>
"imap <c-\> <Esc>:nohlsearch<CR>a

" Re-draw syntax highlighting. Helpful when it get's wacky. Issuing a redraw command might help as well
noremap <F10> <Esc>:syntax sync fromstart<CR>
inoremap <F10> <C-o>:syntax sync fromstart<CR>

" always use black on yellow for search, and get search in inverse color inside visual selection
hi Search cterm=inverse ctermbg=black ctermfg=yellow

" always use black on white for visual selection
hi Visual ctermfg=black ctermbg=white

" ALE errors
hi ALEWarning ctermbg=darkblue ctermfg=white
hi ALEError ctermbg=red ctermfg=black

augroup pythonhighlight
  au!

  " statement (`if`, `for` etc) in dark red. For C/C++, VimScript
  autocmd BufEnter * hi Statement ctermfg=darkred

  " statement (`if`, `for` etc) for Python in magenta
  autocmd BufEnter *.py hi Statement ctermfg=magenta
augroup END

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
set wildignore+=*/.git/*,*.pyc,*.zip,*.gz,*.bz,*.tar,*.jpg,*.png,*.gif,*.avi,*.wmv,*.ogg,*.mp3,*.mov,*.swp,*.orig

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
nmap <BS> 4zh
nmap <c-h> 4zh

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

" linter
map <Leader>en <Plug>(ale_next_wrap)
map <Leader>ep <Plug>(ale_previous_wrap)

" toggle open/close the quickfix window
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

nnoremap <silent> <c-q> :call ToggleQuickFix()<cr>

autocmd BufEnter *.h :setlocal filetype=c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" c-p is used by CtrlP
"map <c-p> :set ft=python<CR>
"map  <c-e> <Plug>PimpEvalFile
"imap <c-e> <Esc><Plug>PimpEvalFilea
"vmap <c-e> <Plug>PimpEvalBlock

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Miscellaneous
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
"set t_Co=256

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

" map <ctrl>+F11 to generate ctags for current folder:
"map <C-F11> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>

" map <ctrl>+F12 to vim-grep for word under cursor in all files
"map <C-F12> yiw:vimgrep <C-R>0 **/*.c*<CR>

" set line end (newline) format
set ffs=unix,dos

" buffers
map <a-.> :bn<Cr>
map <a-,> :bp<Cr>

" window size
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

if has("win32") || has("win64") || has("win32unix")
  " Following is Windows-Only, including cygwin

  " selection mode etc. as in x-windows
  behave xterm

  " font
  "set guifont=Courier_New:h10:cANSI

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
  set shiftwidth=2
  set tabstop=2
  set softtabstop=2
endif

if has("mac")
  " indenting
  "autocmd FileType c,cpp set noexpandtab
  set shiftwidth=2
  set tabstop=2
  set softtabstop=2

  " clang binary for clang_complete plugin
  "let clang_exec = '/Users/johndoe/Downloads/clang+llvm-2.9-x86_64-apple-darwin10/bin/clang'
  let clang_exec = '~/Downloads/clang+llvm-2.9-x86_64-apple-darwin10/bin/clang'

  " use option as meta
  if has("macvim") || has("gui_macvim")
    autocmd BufEnter * set macmeta
  endif

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
