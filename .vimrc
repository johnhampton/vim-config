if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  augroup vimplug
    autocmd!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif

call plug#begin('~/.vim/plugged')
  Plug 'tpope/vim-sensible'
  Plug 'jszakmeister/vim-togglecursor'

  Plug 'hashivim/vim-terraform'
  Plug 'morhetz/gruvbox'

  Plug 'w0rp/ale'
  Plug 'christoomey/vim-tmux-navigator'

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'edkolev/tmuxline.vim'

  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'

  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'

  Plug 'Shougo/denite.nvim'
  Plug 'Shougo/unite.vim' | Plug 'Shougo/vimfiler.vim'

  Plug 'pangloss/vim-javascript'
  Plug 'elzr/vim-json'
  Plug 'mxw/vim-jsx'
  Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
  Plug 'othree/jspc.vim'

  Plug 'Shougo/neco-vim'

  Plug 'Shougo/neocomplete.vim'

  Plug 'scrooloose/nerdcommenter'
  Plug 'jiangmiao/auto-pairs'

  Plug 'terryma/vim-multiple-cursors'
  Plug 'vim-scripts/Rename2'
call plug#end()

let g:mapleader="\<Space>"
let g:maplocalleader="\\"

augroup vimrc
  autocmd!
augroup END

" Configure tabs
set expandtab       " Convert tabs to spaces
set shiftwidth=2    " << and >> shift 2 spaces
set softtabstop=2   " Tab is 2 spaces

" Swapfile config
if isdirectory($HOME . '/.vim/tmp') == 0
  :silent !mkdir -p ~/.vim/tmp > /dev/null 2>&1
endif
set directory=~/.vim/tmp//,/var/tmp//,/tmp//,.

" colorscheme
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set background=dark
colorscheme gruvbox

" Disabled because of problems with true colors
let g:airline#extensions#tmuxline#enabled = 0
if has('termguicolors')
  set termguicolors
endif
" end colorscheme

set noshowmode
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:terraform_align=1

" Line numbers
set relativenumber
set number

autocmd vimrc BufEnter,WinEnter,InsertLeave * set cursorline
autocmd vimrc BufLeave,WinLeave,InsertEnter * set nocursorline

" Ag command on grep source
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
      \ ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

call denite#custom#var('file_rec', 'command',
      \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

" Change mappings.
call denite#custom#map(
      \ 'insert',
      \ '<c-n>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<c-p>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)

autocmd vimrc FileType javascript setlocal formatprg=prettier-eslint\ --stdin

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : '' ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

if !exists('g:neocomplete#sources#omni#functions')
  let g:neocomplete#sources#omni#functions = {}
endif

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#functions.javascript = [
      \   'jspc#omni',
      \   'tern#Complete',
      \ ]
let g:neocomplete#sources#omni#input_patterns.javascript = '\h\w*\|[^. \t]\.\w*'

augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=tern#Complete
  autocmd FileType javascript.jsx setlocal omnifunc=tern#Complete
augroup END

let g:vimfiler_as_default_explorer = 1

" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

" mappings
nnoremap <leader>ut :<C-u>Denite file_rec<cr>
nnoremap <leader>t :<C-u>Denite file_rec<cr>
nnoremap <leader>ue :<C-u>Denite buffer<cr>
nnoremap <leader>e :<C-u>Denite buffer<cr>
nnoremap <leader>ug :<C-u>Denite grep<cr>

nnoremap <leader>gs :<C-u>Gstatus<cr>

if !has('gui_running')
  " Meta keys for the AutoPairs plugin
  set <M-b>=b
  set <M-e>=e
  set <M-n>=n
  set <M-p>=p
endif
