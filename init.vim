" ===
" === Auto load for first time uses
" ===
if empty(glob($HOME.'/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"if empty(glob($HOME.'/.config/nvim/plugged/wildfire.vim/autoload/wildfire.vim'))
"	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif


" ===
" === Editor behavior
" ===
"
set autoindent
set number
syntax on
filetype indent on
" ===
" === Basic Mappings
" ===
" Set <LEADER> as <SPACE>
let mapleader = " "
"============ plugin
call plug#begin()
" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 状态栏美化
Plug 'vim-airline/vim-airline'
Plug 'mg979/vim-xtabline'
" Pretty Dress
Plug 'theniceboy/nvim-deus'
" General Highlighter
" Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'RRethy/vim-illuminate'
call plug#end()
"============

" ==
" === Dress up my vim
" ===
set termguicolors " enable true colors support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"set background=dark
"let ayucolor="mirage"
"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1
"let g:one_allow_italics = 1

"color dracula
"color one
color deus
"color gruvbox
"let ayucolor="light"
"color ayu
"color xcodelighthc
"set background=light
"set cursorcolumn

hi NonText ctermfg=gray guifg=grey10
"hi SpecialKey ctermfg=blue guifg=grey70=

"==== Plugin settings ====
"
"===
"=== coc.nvim
"===

let g:coc_global_extensions = ['coc-json',
			\ 'coc-git',
			\ 'coc-explorer',
			\ 'coc-clangd']


" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <leader>e :CocCommand explorer<CR>

" ===
" === xtabline
" ===
let g:xtabline_settings = {}
let g:xtabline_settings.enable_mappings = 0
let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
let g:xtabline_settings.enable_persistance = 0
let g:xtabline_settings.last_open_first = 1
noremap to :XTabCycleMode<CR>
noremap \p :echo expand('%:p')<CR>
