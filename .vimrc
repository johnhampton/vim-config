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
call plug#end()

augroup vimrc
  autocmd!
augroup END

" Configure tabs
set expandtab       " Convert tabs to spaces
set shiftwidth=2    " << and >> shift 2 spaces
set softtabstop=2   " Tab is 2 spaces

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
