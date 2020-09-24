" PageUp/PageDown fix 
nnoremap <PageUp> <C-u> 
nnoremap <PageDown> <C-d> 
inoremap <PageUp> <C-o><C-u>
" Always left some lines above when cursor reaches EOF
set scrolloff=20

" Quickly insert an empty new line without entering insert mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

" Quickly remove the line in insert mode
inoremap <Leader>dd <C-o>dd

" Duplicate line in normal and block in visual mode
nnoremap <C-d> :copy .<CR>
vnoremap <C-d> :copy '><CR>


" Enable syntax color 
syntax enable 
set t_Co=256 

"" Plugin manager 
if empty(glob('~/.vim/autoload/plug.vim')) 
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs 
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC 
endif 

call plug#begin() 
" A collection of language packs for Vim 
Plug 'sheerun/vim-polyglot' 

" Universal set of defaults 
Plug 'tpope/vim-sensible' 

" Vim syntax plugin for Ansible 2.x 
"Plug 'pearofducks/ansible-vim'

" Vim syntax plugin for terraform (HCL)
"Plug 'hashivim/vim-terraform'

" NERD Commenter
Plug 'preservim/nerdcommenter'

" Monokai-pro theme 
Plug 'phanviet/vim-monokai-pro' 

" Monokai theme 
Plug 'crusoexia/vim-monokai' 

" Xoria256 pastel gamma on dark theme
Plug 'vim-scripts/xoria256.vim'

" Zenburn theme
Plug 'jnurmine/Zenburn'
let g:zenburn_high_Contrast=1

" Darcula theme 
Plug 'doums/darcula' 
call plug#end() 
colorscheme darcula

autocmd Filetype yaml colorscheme monokai

" Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically set paste mode in Vim when pasting in insert mode
"""
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
"""

