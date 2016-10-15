"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=~/.vim/bundle/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('~/.vim/bundle'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Sane Defaults
call dein#add('tpope/vim-sensible')

call dein#add('Shougo/vimproc.vim', {'build': 'make'})

" Universal plugins
call dein#add('aaronjensen/vitality.vim')
call dein#add('airblade/vim-gitgutter')
call dein#add('benmills/vimux', {'if': !has('gui_running')})
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('christoomey/vim-tmux-navigator')
call dein#add('ConradIrwin/vim-bracketed-paste')

call dein#add('dr-chip-vim-scripts/ZoomWin')
call dein#add('direnv/direnv.vim')

" TODO Figure out how to replicate this functionality
"call dein#add('edkolev/tmuxline.vim', { 'terminal': 1 })
call dein#add('edkolev/tmuxline.vim')

call dein#add('godlygeek/tabular', {
      \ 'hook_add': join(['nmap ,a= :Tabularize /=<CR>',
      \ 'vmap ,a= :Tabularize /=<CR>',
      \ 'nmap ,a: :Tabularize /:\zs<CR>',
      \ 'vmap ,a: :Tabularize /:\zs<CR>'], "\n")
      \ })
call dein#add('hashivim/vim-terraform')
call dein#add('jiangmiao/auto-pairs')
call dein#add('lambdalisue/vim-gista')
call dein#add('lambdalisue/vim-gista-unite')
call dein#add('Lokaltog/vim-easymotion')
call dein#add('mileszs/ack.vim')
call dein#add('mbbill/undotree')
call dein#add('Peeja/vim-cdo')
call dein#add('qpkorr/vim-bufkill')
call dein#add('rizzatti/dash.vim')
call dein#add('scrooloose/nerdcommenter')
call dein#add('scrooloose/syntastic')
call dein#add('shime/vim-livedown')
call dein#add('Shougo/junkfile.vim')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neoyank.vim')
call dein#add('Shougo/vimfiler.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/unite-outline')
call dein#add('tsukkee/unite-help')
call dein#add('terryma/vim-multiple-cursors')
call dein#add('tpope/vim-endwise')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-repeat')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-unimpaired')
call dein#add('tpope/vim-vinegar')

" Colorschemes
" call dein#add('flazz/vim-colorschemes')
call dein#add('nanotech/jellybeans.vim')
call dein#add('yosiat/oceanic-next-vim')

" Completion and Snippets
call dein#add('Shougo/neocomplete')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('bentayloruk/vim-react-es6-snippets')

" Ruby / Ruby on Rails Plugins
call dein#add('skalnik/vim-vroom')
call dein#add('tpope/vim-bundler')
call dein#add('tpope/vim-rails')
call dein#add('vim-ruby/vim-ruby')

" Ember
call dein#add('dsawardekar/ember.vim', { 'depends': 'dsawardekar/portkey' })
call dein#add('mustache/vim-mustache-handlebars')
call dein#add('elzr/vim-json')

" React
call dein#add('mxw/vim-jsx', { 'depends': 'pangloss/vim-javascript' })
"call dein#add('pangloss/vim-javascript', {'rev': 'develop'})
call dein#add('pangloss/vim-javascript')
" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

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

if has('gui_macvim') && has('gui_running')
  set macmeta
endif

" Enable syntax highlighting
syntax enable

" No swap files please
set noswapfile

colorscheme jellybeans
if has('gui_running')
  set guifont=Sauce\ Code\ Powerline:h14
endif

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

" gp selects previous text
nnoremap gp `[v`]

" Redraw
noremap <F5> <C-L>

" Search behavior
set hlsearch
nmap <silent> <leader><Space> :nohlsearch<CR>

" Format entire file
nmap <silent> <leader>fef :call Preserve("normal gg=G")<CR>

" Strip trailing whitespace
nmap <silent> <leader>f$ :call StripTrailingWhitespace()<CR>

" Delete buffer, leave split
nmap <silent> <C-W>! :BD<CR>

" Airline
set laststatus=2                             " Show status bar all the time (default is
                                             " only with splits)
let g:airline_powerline_fonts = 1            " Use the nice fonts
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='jellybeans'
set noshowmode                               " Airline gives us a nice indicator

" AutoPairs
let g:AutoPairsFlyMode = 1

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
let  g:neosnippet#enable_snipmate_compatibility = 1

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
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']

let g:jsx_ext_required = 0

" Standard Automagic Reforma
"autocmd bufwritepost *.js silent !standard --parser babel-eslint --format %
"autocmd bufwritepost *.jsx silent !standard --parser babel-eslint --format %
"set autoread

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

" Unite
call unite#custom#source('file_rec/async', 'ignore_pattern', join([
  \ 'node_modules/',
  \ 'bower_components/',
  \ '\.terraform',
  \ ], '\|'))
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files -ignorecase -smartcase -start-insert file_rec/async:!<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files -start-insert file<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank history/yank<cr>
nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer -start-insert buffer<cr>

nnoremap <silent> <leader>g :<C-u>Unite -no-quit -buffer-name=search-buffer grep:.<cr>

if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
  let g:unite_source_rec_async_command = 'ag --follow --nocolor --nogroup --hidden -g ""'
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden'
  let g:unite_source_grep_recursive_opt=''
endif

" VimFiler
let g:vimfiler_as_default_explorer = 1

" Vitality
let g:vitality_always_assume_iterm = 1

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
