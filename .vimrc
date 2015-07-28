"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
" NeoBundleFetch 'Shougo/neobundle.vim'

" vimproc
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

" Sane Defaults
NeoBundle 'tpope/vim-sensible'

" Universal plugins
NeoBundle 'aaronjensen/vitality.vim'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'benmills/vimux'
NeoBundle 'bling/vim-airline'
NeoBundle 'christoomey/vim-tmux-navigator'

NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'd11wtq/ctrlp_bdelete.vim'

NeoBundle 'dr-chip-vim-scripts/ZoomWin'
NeoBundle 'edkolev/tmuxline.vim', { 'terminal': 1 }
NeoBundle 'rizzatti/dash.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'godlygeek/tabular'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-vinegar'

" Completion and Snippets
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
"NeoBundle 'bentayloruk/vim-react-es6-snippets'

" Ruby / Ruby on Rails Plugins
NeoBundle 'skalnik/vim-vroom'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'tpope/vim-rails'
NeoBundle 'vim-ruby/vim-ruby'

" Ember
NeoBundle 'dsawardekar/ember.vim', { 'depends': 'dsawardekar/portkey' }
NeoBundle 'mustache/vim-mustache-handlebars'
NeoBundle 'elzr/vim-json'

" React
NeoBundle 'mxw/vim-jsx', { 'depends': 'pangloss/vim-javascript' }
NeoBundle 'pangloss/vim-javascript'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

" Use ',' instead of '\' as the leader key
let mapleader=','
let maplocalleader=';'

" For terminal vim, remap some of our meta keys
if !has('gui_running')
  " Meta keys for the AutoPairs plugin
  set <M-b>=b
  set <M-e>=e
  set <M-n>=n
  set <M-p>=p
endif

" Enable syntax highlighting
syntax enable

" No swap files please
set noswapfile

colorscheme jellybeans

" Ignores
set wildignore+=*.o,*.obj,.git,*.rbc,*.gem,*.zip,*.tar,*.tar.gz
set wildignore+=*.swp,*~
set wildignore+=vendor/rails/**
set wildignore+=vendor/gems/**
set wildignore+=vendor/ruby/**
set wildignore+=vendor/cache/**
set wildignore+=vendor/assets/**
set wildignore+=.bundle/*
set wildignore+=.sass-cache/*
set wildignore+=public/uploads/**
set wildignore+=doc/yard/**,.yardoc/**
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=bower_components/**
set wildignore+=node_modules/**
set wildignore+=dist/**

" Configure tabs
set expandtab       " Convert tabs to spaces
set shiftwidth=2    " << and >> shift 2 spaces
set softtabstop=2   " Tab is 2 spaces

" Line Numbering
set number          " Display line numbers
set relativenumber  " Line numbers should be relative
set cursorline      " Highlight the current line

" Redraw
noremap <F5> <C-L>

" Search behavior
set hlsearch
nmap <silent> <leader><Space> :nohlsearch<CR>

" Format entire file
nmap <silent> <leader>fef :call Preserve("normal gg=G")<CR>

" Strip trailing whitespace
nmap <silent> <leader>f$ :call StripTrailingWhitespace()<CR>

" Airline
set laststatus=2                             " Show status bar all the time (default is
                                             " only with splits)
let g:airline_powerline_fonts = 1            " Use the nice fonts
let g:airline#extensions#tabline#enabled = 1
set noshowmode                               " Airline gives us a nice indicator

" AutoPairs
let g:AutoPairsFlyMode = 1

" Ctrl-P
let g:ctrlp_match_window = 'results:100' " overcome limit imposed by max height"
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](node_modules|build)$'
\ }

nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>mru :CtrlPMRUFiles<CR>

call ctrlp_bdelete#init()

" Dash
nmap <silent> <leader>d <Plug>DashSearch

" Fugitive
nmap <leader>gs :Gstatus<CR>
nmap <leader>gw :Gwrite<CR>
nmap <leader>gp :Gpush<CR>

" multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

" neocomplete
let g:neocomplete#enable_at_startup = 1
"let  g:neosnippet#enable_snipmate_compatibility = 1

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']

"if !has('gui_running')
  "let g:syntastic_full_redraws = 1
"endif

"let g:syntastic_javascript_jsxhint_args = '-babel'

" Vimux

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>

" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>

" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>

" Interrupt any command running in the runner pane
map <Leader>vx :VimuxInterruptRunner<CR>

" Zoom the runner pane (use <bind-key> z to restore runner pane)
map <Leader>vz :call VimuxZoomRunner()<CR>

" Vimux
let VimuxUseNearest = 0

" Vroom
let g:vroom_use_bundle_exec = 0 " We're using binstubs so need from bundle exec
let g:vroom_use_binstubs = 1    " Use the stubs in bin/
let g:vroom_use_vimux = 1       " Use vimux

" Functions

function! Preserve(command) "{{{
  " preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  execute a:command
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction "}}}

function! StripTrailingWhitespace() "{{{
  call Preserve("%s/\\s\\+$//e")
endfunction "}}}
