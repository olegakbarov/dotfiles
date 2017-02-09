set nocompatible
filetype off

" Map the leader key to ,
let mapleader=","

call plug#begin('~/.vim/plugged')

" Plugs {
  " ctrl-p is a fuzzy file finder.
  Plug 'kien/ctrlp.vim'
  " airline is a better status line and a tab-bar for nvim.
  Plug 'bling/vim-airline'
  Plug 'fatih/vim-go'
  Plug 'mileszs/ack.vim'
  Plug 'mattn/webapi-vim'
  Plug 'scrooloose/syntastic'
  Plug 'mattn/gist-vim'
  Plug 'scrooloose/nerdtree'
  Plug 'digitaltoad/vim-pug'
  Plug 'tpope/vim-git'
  Plug 'Shougo/neocomplete.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'davidosomething/vim-jsdoc'
  Plug 'majutsushi/tagbar'
  Plug 'craigemery/vim-autotag'
  Plug 'mhartington/oceanic-next'
  Plug 'bhurlow/vim-parinfer'
  Plug 'airblade/vim-gitgutter'
  Plug 'scrooloose/nerdcommenter'

  " JS
  Plug 'mxw/vim-jsx'
call plug#end()


if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'


" General {
  set backspace=indent,eol,start      " Allow backspace over everything in insert mode.
  set guifont=Hack:h14
  set noswapfile
  set smarttab
  set secure
  set exrc
  set ttyfast
  set noautoindent        " I indent my code myself.
  set nocindent           " I indent my code myself.
  set omnifunc=syntaxcomplete#Complete

  "set smartindent        " Or I let the smartindent take care of it.

  set nrformats-=octal

  set ttimeout
  set ttimeoutlen=100
" }

" Search {
  set hlsearch            " Highlight search results.
  set ignorecase          " Make searching case insensitive
  set smartcase           " ... unless the query has capital letters.
  set incsearch           " Incremental search.
  set gdefault            " Use 'g' flag by default with :s/foo/bar/.
  set magic               " Use 'magic' patterns (extended regular expressions).
  "This unsets the "last search pattern" register by hitting return
  nnoremap <CR> :noh<CR><CR>
" }

" Formatting {
  set showcmd             " Show (partial) command in status line.
  set showmatch           " Show matching brackets.
  set showmode            " Show current mode.
  set ruler               " Show the line and column numbers of the cursor.
  set number              " Show the line numbers on the left side.
  set formatoptions+=o    " Continue comment marker in new lines.
  set textwidth=0         " Hard-wrap long lines as you type them.
  set expandtab           " Insert spaces when TAB is pressed.
  set tabstop=2           " Render TABs using this many spaces.
  set shiftwidth=2        " Indentation amount for < and > commands.
  "duplicate line cmd-d
  map <D-d> yyp
  set noerrorbells        " No beeps.
  set modeline            " Enable modeline.
  set esckeys             " Cursor keys in insert mode.
  set linespace=18         " Set line-spacing to minimum.
  set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)
  set list
  set listchars=tab:›\ ,eol:¬,trail:⋅,space:⋅
  set splitbelow          " Horizontal split below current.
  set splitright          " Vertical split to right of current.
  set autoread            " If file updates, load automatically.
  au! BufWritePost .vimrc so %
  au! BufWritePost .gvimrc so %

  set display+=lastline
  set nostartofline       " Do not jump to first character with page commands.

  if &encoding ==# 'latin1' && has('gui_running')
    set encoding=utf-8
  endif

  " Tell Vim which characters to show for expanded TABs,
  " trailing whitespace, and end-of-lines. VERY useful!
  if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  endif

  " Also highlight all tabs and trailing whitespace characters.
  highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
  match ExtraWhitespace /\s\+$\|\t/

" }

" Configuration {
  if has('path_extra')
    setglobal tags-=./tags tags^=./tags;
  endif


  " Remove special characters for filename
  set isfname-=:
  set isfname-==
  set isfname-=+

  " Map ; to :
  nnoremap ; :

  if &history < 1000
    set history=1000      " Number of lines in command history.
  endif
  if &tabpagemax < 50
    set tabpagemax=50     " Maximum tab pages.
  endif

  if &undolevels < 200
    set undolevels=200    " Number of undo levels.
  endif

  " Path/file expansion in colon-mode.
  set wildmenu
  set wildmode=list:longest
  set wildchar=<TAB>

  if !empty(&viminfo)
    set viminfo^=!        " Write a viminfo file with registers.
  endif
  set sessionoptions-=options

  " Allow color schemes to do bright colors without forcing bold.
  if &t_Co == 8 && $TERM !~# '^linux'
    set t_Co=16
  endif

  autocmd BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix


  " Remove trailing spaces before saving text files
  " http://vim.wikia.com/wiki/Remove_trailing_spaces
  autocmd BufWritePre * :call StripTrailingWhitespace()
  function! StripTrailingWhitespace()
    if !&binary && &filetype != 'diff'
      normal mz
      normal Hmy
      if &filetype == 'mail'
  " Preserve space after e-mail signature separator
        %s/\(^--\)\@<!\s\+$//e
      else
        %s/\s\+$//e
      endif
      normal 'yz<Enter>
      normal `z
    endif
  endfunction

  " Diff options
  set diffopt+=iwhite

  "Enter to go to EOF and backspace to go to start
  nnoremap <CR> G
  nnoremap <BS> gg
  " Stop cursor from jumping over wrapped lines
  nnoremap j gj
  nnoremap k gk
  " Make HOME and END behave like shell
  inoremap <C-E> <End>
  inoremap <C-A> <Home>

  " New tabs shortcut
  nnoremap <C-t> :tabnew<Enter>
  inoremap <C-t> <Esc>:tabnew<Space>
" }

" GUI Options {
  set guioptions-=m " Removes top menubar
  set guioptions-=T " Removes top toolbar
  set guioptions-=r " Removes right hand scroll bar
  set go-=L " Removes left hand scroll bar

  "Toggle menubar
  nnoremap <leader>m :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>

  " Relative numbering
  function! NumberToggle()
    if(&relativenumber == 1)
      set nornu
      set number
    else
      set rnu
    endif
  endfunc

  " Toggle between normal and relative numbering.
  nnoremap <leader>r :call NumberToggle()<cr>

  " Sets a status line. If in a Git repository, shows the current branch.
  " Also shows the current file name, line and column number.
 if has('statusline')
      set laststatus=2

      " Broken down into easily includeable segments
      set statusline=%<%f\                     " Filename
      set statusline+=%w%h%m%r                 " Options
      "set statusline+=%{fugitive#statusline()} " Git Hotness
      set statusline+=\ [%{&ff}/%Y]            " Filetype
      set statusline+=\ [%{getcwd()}]          " Current dir
      set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
  endif
" }

" Keybindings {
  " Save file
  nnoremap <Leader>w :w<CR>
  "Copy and paste from system clipboard
  vmap <Leader>y "+y
  vmap <Leader>d "+d
  nmap <Leader>p "+p
  nmap <Leader>P "+P
  vmap <Leader>p "+p
  vmap <Leader>P "+P
  nmap <F8> :TagbarToggle<CR>
" }

" Plug Settings {
  " Airline {
    let g:airline#extensions#tabline#enabled = 2
    let g:airline#extensions#tabline#fnamemod = ':t'
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#tabline#right_sep = ' '
    let g:airline#extensions#tabline#right_alt_sep = '|'
    let g:airline_left_sep = ' '
    let g:airline_left_alt_sep = '|'
    let g:airline_right_sep = ' '
    let g:airline_right_alt_sep = '|'
  " }
  " CtrlP {
    " Open file menu
    nnoremap <Leader>o :CtrlP<CR>
    " Open buffer menu
    nnoremap <Leader>b :CtrlPBuffer<CR>
    " Open most recently used files
    nnoremap <Leader>f :CtrlPMRUFiles<CR>
  " }
" }




autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd FileType go set sw=4
autocmd FileType go set tabstop=4
autocmd FileType go set sts=0
autocmd FileType go set expandtab
autocmd FileType go set smarttab
autocmd FileType javascript setlocal expandtab sw=2 ts=2 sts=2
autocmd FileType json setlocal expandtab sw=2 ts=2 sts=2
autocmd FileType python setlocal expandtab sw=4 ts=4 sts=4
autocmd FileType c setlocal expandtab sw=2 ts=2 sts=2
autocmd FileType php setlocal expandtab sw=2 ts=2 sts=2
autocmd BufNewFile,BufReadPost *.jade set filetype=pug
autocmd FileType jade setlocal expandtab sw=2 ts=2 sts=2
autocmd FileType html setlocal expandtab sw=2 ts=2 sts=2
autocmd FileType jade setlocal expandtab sw=2 ts=2 sts=2
autocmd FileType less setlocal expandtab sw=2 ts=2 sts=2
autocmd FileType htmldjango setlocal expandtab sw=2 ts=2 sts=2
autocmd FileType css setlocal expandtab sw=2 ts=2 sts=2
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>r <Plug>(go-run)
au FileType go nmap <Leader>b <Plug>(go-build)
au FileType go nmap <Leader>t <Plug>(go-test)
au FileType go nmap gd <Plug>(go-def-tab)
augroup filetype
 au! BufRead,BufNewFile *.proto setfiletype proto
augroup end
" Ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif


" Vim-Go related Settings
let g:go_errcheck_bin="/Users/vinitkumar/go/bin/errcheck"
let g:go_golint_bin="/Users/vinitkumar/go/bin/golint"
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
let g:github_upstream_issues = 1
let g:go_disable_autoinstall = 0


"Nerdtree
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 30
let g:NERDTreeWinPos = "left"
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
map <C-u> :NERDTreeToggle<CR>
nmap <C-c> :NERDTreeCWD<CR>
nmap <C-\> :NERDTreeFind<CR>
" vim:set ft=vim sw=2 ts=2:

noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>


"Indent
" Indent lines with cmd+[ and cmd+]
nmap <D-]> >>
nmap <D-[> <<
vmap <D-[> <gv
vmap <D-]> >gv

" Neocomplete related settings
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" JS specific stuff
let g:neomake_javascript_enabled_makers = ['eslint']
let g:jsx_ext_required = 0

" for vim 7
set t_Co=256
"
" " for vim 8
if (has("termguicolors"))
  set termguicolors
endif

colorscheme OceanicNext
highlight LineNr guibg=#1b2b34
hi StatusLine guibg=#1b2b34
hi VertSplit guibg=#1b2b34

set fillchars="" " show divider chars


