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
call plug#end()

" colorscheme
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set background=dark
colorscheme gruvbox

if has('termguicolors')
  set termguicolors
endif
" end colorscheme

let g:terraform_align=1
