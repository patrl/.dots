" This enables true color support.
set termguicolors

syntax on
filetype plugin indent on

set spelllang=en_gb

" system clipboard default
set clipboard+=unnamedplus

" maps the global leader key to space
let mapleader="\<SPACE>"
let maplocalleader=","

" general useful mappings
" Cycle between windows 
nnoremap <silent> <leader>w<Tab> <C-W>w 
" Maximize current window
nnoremap <silent> <leader>wm <C-W>o
" Create vertical split
nnoremap <silent> <leader>w/ <C-W>v
" Create horizontal split
nnoremap <silent> <leader>w- <C-W>s
" Close current window
nnoremap <silent> <leader>wd :hide<CR>

"Buffer manipulation
nnoremap <silent> <leader>bd :bw<CR>
nnoremap <silent> <leader>bn :bn<CR>
nnoremap <silent> <leader>bp :bp<CR>

nnoremap <silent> <leader>fs :update<CR>
" Use CTRL-S for saving, also in Insert mode
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

let g:nnn#layout = 'vnew' 

nnoremap <silent> <leader>t :NERDTreeToggle<CR>

" Unified color scheme (default: dark)

colo gruvbox

" alignment
set expandtab

function! s:statusline_expr()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P'

  return '[%n] %F %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
endfunction
let &statusline = s:statusline_expr()

g:tex_flavor=latex
