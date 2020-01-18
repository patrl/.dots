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

" Unified color scheme (default: dark)
colo seoul256
let g:airline_theme='zenburn'

" alignment
set expandtab

let g:airline_powerline_fonts=1

let g:airline#extensions#tabline#enabled = 1

 if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " unicode symbols
  let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.crypt = '🔒'
  let g:airline_symbols.linenr = '☰'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.maxlinenr = '㏑'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
  let g:airline_symbols.spell = 'Ꞩ'
  let g:airline_symbols.notexists = '∄'
  let g:airline_symbols.whitespace = 'Ξ'

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = '☰'
  let g:airline_symbols.maxlinenr = ''

  " old vim-powerline symbols
  let g:airline_left_sep = '⮀'
  let g:airline_left_alt_sep = '⮁'
  let g:airline_right_sep = '⮂'
  let g:airline_right_alt_sep = '⮃'
  let g:airline_symbols.branch = '⭠'
  let g:airline_symbols.readonly = '⭤'
  let g:airline_symbols.linenr = '⭡'







