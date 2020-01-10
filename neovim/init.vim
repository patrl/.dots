" This automatically installs vimplug if not already installed.
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

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

" alignment
set expandtab

call plug#begin()
" ====================================================================
" General 
" ====================================================================
"
"
"
"

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ====================================================================
" Appearance
" ====================================================================
"
Plug 'yuttie/comfortable-motion.vim'
"
Plug 'junegunn/seoul256.vim'
" {{{
let g:seoul256_srgb = 1
" }}}
"
Plug 'morhetz/gruvbox'
" {{{
let g:gruvbox_italic=1
" }}}
"
Plug 'reedes/vim-colors-pencil'
" {{{
let g:pencil_terminal_italics = 1
" }}}
"
Plug 'arcticicestudio/nord-vim'
"
Plug 'dracula/vim' 
"
" {{{
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


" }}}
"

Plug 'reedes/vim-thematic'
" {{{
let g:thematic#themes = {
			\ 'nord' :{'colorscheme': 'nord',
			\ 	   'background': 'dark',
			\ 	   'airline-theme': 'nord',
			\          },
			\ 'pencil_dark' :{'colorscheme': 'pencil',
			\                 'background': 'dark',
			\                 'airline-theme': 'pencil',
			\                },
			\ 'pencil_lite' :{'colorscheme': 'pencil',
			\                 'background': 'light',
			\                 'airline-theme': 'pencil',
			\                },
			\ 'gruv_dark'	:{'colorscheme': 'gruvbox',
			\		  'background': 'dark',
			\		  'airline-theme': 'gruvbox',
			\		  },
			\ 'gruv_lite'	:{'colorscheme': 'gruvbox',
			\		  'background': 'light',
			\		  'airline-theme': 'gruvbox',
			\		  },
			\ 'dracula'	:{'colorscheme': 'dracula',
			\		  'background': 'dark',
			\		  'airline-theme': 'dracula',
			\		  },
			\ 'seoul_lite'	:{'colorscheme': 'seoul256-light',
			\		  'background': 'light',
			\		  'airline-theme': 'zenburn',
			\		  },
			\ 'seoul_dark'	:{'colorscheme': 'seoul256',
			\		  'background': 'dark',
			\		  'airline-theme': 'zenburn',
			\		  },
			\ }
"
let g:thematic#theme_name = 'dracula'
" }}}
"
" {{{
nnoremap <silent> <leader>bh :Startify<CR>
" }}}
" ====================================================================
" Language 
" ====================================================================
" Nix
Plug 'LnL7/vim-nix', { 'for': 'nix' }
" Web
Plug 'othree/html5.vim', { 'for': 'html' }
"" Haskell

" ====================================================================
" Completion 
" ====================================================================
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" {{{
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#sources = {}
"let g:deoplete#sources._=['omni', 'ultisnips']
" }}}
" {{{
autocmd FileType tex let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
" }}}
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" ====================================================================
" Utilities 
" ====================================================================
" {{{
nnoremap <silent> <leader>gs :Gstatus<CR>
" }}}
" {{{
" Runs neomake everywhere
"autocmd! BufWritePost * Neomake
" }}}
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
"Plug '/run/current-system/sw/bin/fzf'
"Plug '/home/patrl/.zplugin/plugins/junegunn---fzf-bin'
"Plug '/home/patrl/.zplugin/plugins/junegunn---fzf'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" {{{
nnoremap <silent> <leader>bb :Buffers<CR>
nnoremap <silent> <leader><Space> :Commands<CR>
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>ll :Lines<CR>
nnoremap <silent> <Leader>lb :BLines<CR>
"let g:fzf_nvim_statusline = 0
" }}}
map <C-n> :NERDTreeToggle<CR>
"
" ====================================================================
" Prose 
" ====================================================================
nnoremap <silent> <leader>Tg :Goyo<cr>
Plug 'junegunn/limelight.vim'
nnoremap <silent> <leader>Tl :Limelight!!<cr>
" }}}
"
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
"
Plug 'reedes/vim-pencil'
" {{{
let g:pencil#wrapModeDefault = 'soft'
let g:airline_section_x = '%{PencilMode()}'
" }}}
Plug 'tpope/vim-markdown'
"
Plug 'kana/vim-textobj-user'
"
Plug 'reedes/vim-wordy'
"
Plug 'reedes/vim-textobj-quote'
"
Plug 'reedes/vim-textobj-sentence'
"
Plug 'reedes/vim-lexical'
" {{{
nnoremap <silent> <leader>Ss :set spell!<CR>
" }}}
"
Plug 'reedes/vim-litecorrect'
"
function! SetUpMk()
	if ! exists('#goyo')
		Goyo
	endif
endfunction

function! Prose()
	call pencil#init()
	call SetUpMk()
	call lexical#init()
	call litecorrect#init()
	call textobj#quote#init()
	call textobj#sentence#init()

	" manual reformatting shortcuts
	nnoremap <buffer> <silent> Q gqap
	xnoremap <buffer> <silent> Q gq
	nnoremap <buffer> <silent> <leader>Q vapJgqap

	" force top correction on most recent misspelling
	nnoremap <buffer> <c-s> [s1z=<c-o>
	inoremap <buffer> <c-s> <c-g>u<Esc>[s1z=`]A<c-g>u

	" replace common punctuation
	iabbrev <buffer> -- –
	iabbrev <buffer> --- —
	iabbrev <buffer> << «
	iabbrev <buffer> >> »

	" open most folds
	setlocal foldlevel=6

	" replace typographical quotes (reedes/vim-textobj-quote)
	map <silent> <buffer> <leader>qc <Plug>ReplaceWithCurly
	map <silent> <buffer> <leader>qs <Plug>ReplaceWithStraight

	" highlight words (reedes/vim-wordy)
	noremap <silent> <buffer> <F8> :<C-u>NextWordy<cr>
	xnoremap <silent> <buffer> <F8> :<C-u>NextWordy<cr>
	inoremap <silent> <buffer> <F8> <C-o>:NextWordy<cr>

endfunction

" automatically initialize buffer by file type
autocmd FileType markdown,mkd,text call Prose()

" invoke manually by command for other file types
command! -nargs=0 Prose call Prose()

" ====================================================================
" LaTeX 
" ====================================================================
"
"function! VimtexDeoplete()
"        if !exists('g:deoplete#omni#input_patterns')
"                let g:deoplete#omni#input_patterns = {}
"        endif
"        let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
"endfunction

function! VimtexPencil()
	call pencil#init()
	call lexical#init()
	call litecorrect#init()
	call textobj#sentence#init()
	let g:pencil#conceallevel = 0
endfunction

"autocmd FileType tex call VimtexDeoplete()
autocmd FileType tex call VimtexPencil()						
"
Plug 'lervag/vimtex'

let g:vimtex_view_general_viewer = 'cmd.exe /C start'
let g:vimtex_complete_close_braces = 1
let g:vimtex_complete_recursive_bib = 1
let g:tex_flavor = "latex"
"Prevents vimtex from concealing latex source code
let g:tex_conceal = ""

let g:vimtex_compiler_latexmk_engines = {
        \ '_'                : '-xelatex',
        \ 'pdflatex'         : '-pdf',
        \ 'dvipdfex'         : '-pdfdvi',
        \ 'lualatex'         : '-lualatex',
        \ 'xelatex'          : '-xelatex',
        \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
        \ 'context (luatex)' : '-pdf -pdflatex=context',
        \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
        \}

" ====================================================================
" ====================================================================
call plug#end()
