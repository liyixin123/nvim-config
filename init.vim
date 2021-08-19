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
set clipboard=unnamed
set splitbelow

filetype indent on
" ===
" === Basic Mappings
" ===
" Set <LEADER> as <SPACE>
let mapleader = " "
" Save & quit
noremap Q :q<CR>
noremap S :w<CR>
" Press <SPACE> + q to close the window below the current window
noremap <LEADER>q <C-w>j:q<CR>

" make Y to copy till the end of the line
nnoremap Y y$

" Copy to system clipboard
vnoremap Y "+y


" ===
" === Window management
" ===
" Use <space> + new arrow keys for moving the cursor around windows
noremap <LEADER>w <C-w>w
noremap <LEADER>k <C-w>k
noremap <LEADER>j <C-w>j
noremap <LEADER>h <C-w>h
noremap <LEADER>l <C-w>l
noremap qf <C-w>o

" Disable the default s key
noremap s <nop>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sj :set splitbelow<CR>:split<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" Place the two screens up and down
noremap sv <C-w>t<C-w>K
" Place the two screens side by side
noremap sh <C-w>t<C-w>H

" Rotate screens
noremap srh <C-w>b<C-w>K
noremap srv <C-w>b<C-w>H

" Press <SPACE> + q to close the window below the current window
noremap <LEADER>q <C-w>j:q<CR>
" ===
" === Tab management
" ===
" Create a new tab with tu
noremap tu :tabe<CR>
noremap tU :tab split<CR>
" Move around tabs with tn and ti
noremap th :-tabnext<CR>
noremap tl :+tabnext<CR>
" Move the tabs with tmn and tmi
noremap tmh :-tabmove<CR>
noremap tml :+tabmove<CR>
noremap <tab> gt  
noremap <s-tab> gT


" Compile function
noremap <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++17 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		set splitbelow
		:sp
		:res -5
		term javac % && time java %<
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "InstantMarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		exec "CocCommand flutter.run -d ".g:flutter_default_device." ".g:flutter_run_args
		silent! exec "CocCommand flutter.dev.openDevLog"
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc





"============ plugin
call plug#begin()
" Auto complete 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Debugger
"Plug 'puremourning/vimspector'
" 状态栏美化
Plug 'vim-airline/vim-airline'
Plug 'mg979/vim-xtabline'
" Pretty Dress
Plug 'theniceboy/nvim-deus'
" General Highlighter
" Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'RRethy/vim-illuminate'

" Markdown
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown'}
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown', 'vim-plug'] }
Plug 'dkarter/bullets.vim'
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
let g:coc_global_extensions = [
			\ 'coc-json',
			\ 'coc-git',
			\ 'coc-explorer',
			\ 'coc-cmake',
			\'coc-yaml',
			\ 'coc-snippets',
			\ 'coc-clangd']



"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" coc-explorer
nnoremap <leader>e :CocCommand explorer<CR>

" use <tab> for trigger completion and navigate to the next complete item
inoremap <silent><expr> <TAB>
	"\ pumvisible() ? "\<C-n>" :
	\ pumvisible() ? coc#_select_confirm() :
	\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap',['snippets-expand-jump',''])\<CR>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr>j pumvisible() ? "\<C-n>" : "\j"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm(): "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"inoremap <silent><expr> <space> pumvisible() ? coc#_select_confirm() : "\<space>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" coc-snippets
imap <C-j> <Plug>(coc-snippets-expand-jump)
" use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <c-o> coc#refresh()
function! Show_documentation()
	call CocActionAsync('highlight')
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction
nnoremap <space><F2> :call Show_documentation()<CR>
nnoremap <silent><nowait> <LEADER>d :CocList diagnostics<cr>
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)
nnoremap <c-c> :CocCommand<CR>
" Useful commands
nmap <F2> <Plug>(coc-rename)
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)



"===coc end==
"
" ===
" === vim-markdown-toc
" ===
"let g:vmt_auto_update_on_save = 0
"let g:vmt_dont_insert_fence = 1
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'

" ===
" === vim-instant-markdown
" ===
let g:instant_markdown_slow = 0
let g:instant_markdown_autostart = 0
" let g:instant_markdown_open_to_the_world = 1
" let g:instant_markdown_allow_unsafe_content = 1
" let g:instant_markdown_allow_external_content = 0
" let g:instant_markdown_mathjax = 1
let g:instant_markdown_autoscroll = 1


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
