"Begin vim-plug---------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'Shougo/vimproc.vim', {'do': 'make'}

" Universal plugins
Plug 'aaronjensen/vitality.vim'
Plug 'airblade/vim-gitgutter'
Plug 'benmills/vimux', Cond(!has('gui_running'))
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ConradIrwin/vim-bracketed-paste'

Plug 'dr-chip-vim-scripts/ZoomWin'
Plug 'direnv/direnv.vim'

" TODO Figure out how to replicate this functionality
"Plug 'edkolev/tmuxline.vim', { 'terminal': 1 }
Plug 'edkolev/tmuxline.vim'

Plug 'godlygeek/tabular'
Plug 'hashivim/vim-terraform'
Plug 'jiangmiao/auto-pairs'
Plug 'lambdalisue/vim-gista'
Plug 'lambdalisue/vim-gista-unite'
Plug 'Lokaltog/vim-easymotion'
Plug 'mileszs/ack.vim'
Plug 'mbbill/undotree'
Plug 'Peeja/vim-cdo'
Plug 'qpkorr/vim-bufkill'
Plug 'rizzatti/dash.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'shime/vim-livedown'
Plug 'Shougo/junkfile.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/unite-outline'
Plug 'tsukkee/unite-help'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'

" Colorschemes
" Plug 'flazz/vim-colorschemes'
Plug 'nanotech/jellybeans.vim'
Plug 'yosiat/oceanic-next-vim'

" Completion and Snippets
Plug 'Shougo/neocomplete'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'bentayloruk/vim-react-es6-snippets'

" Ruby / Ruby on Rails Plugins
Plug 'skalnik/vim-vroom'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'

" Ember
Plug 'dsawardekar/portkey' | Plug 'dsawardekar/ember.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'elzr/vim-json'

Plug 'pangloss/vim-javascript' | Plug 'mxw/vim-jsx'
Plug 'maksimr/vim-jsbeautify'
Plug 'mtscout6/syntastic-local-eslint.vim'
call plug#end()
"End vim-plug-----------------------------

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

" Redraw
noremap <F5> <C-L>

" Search behavior
set hlsearch
nmap <silent> <leader><Space> :nohlsearch<CR>

" Format entire file
nmap <silent> <leader>fef :call Preserve("normal gg=G")<CR>
autocmd FileType javascript noremap <buffer>  <leader>fef :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <leader>fef :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <leader>fef :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <leader>fef :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <leader>fef :call CSSBeautify()<cr>
autocmd FileType javascript vnoremap <buffer>  <leader>fef :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <leader>fef :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <leader>fef :call RangeJsxBeautify()<cr>
autocmd FileType html vnoremap <buffer> <leader>fef :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <leader>fef :call RangeCSSBeautify()<cr>

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

" Tabular
nmap ,a= :Tabularize /=<CR>
vmap ,a= :Tabularize /=<CR>
nmap ,a: :Tabularize /:\zs<CR>
vmap ,a: :Tabularize /:\zs<CR>

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
