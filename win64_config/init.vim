" ===
" edit behavior
" ===
set number
set relativenumber
"set showcmd
set incsearch
syntax on

" ===
" Basic Mappings 
" ===
"
let mapleader = " "
" map <F5> i{<Esc>ea}<Esc>

" Copy to system clipboard
vnoremap Y "+y
vnoremap P "+p
" Save & Quit
noremap Q :q<CR>
noremap S :w<CR>

" add ; in the end of line and create a new line
imap jk <Esc>A;<Esc>o

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
		:term %<
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


" ===
" plugin
" ===

call plug#begin()
" Auto complete
Plug 'neoclide/coc.nvim',{'brance':'release'}
Plug 'vim-airline/vim-airline'

Plug 'theniceboy/nvim-deus'

call plug#end()

" === Dress up
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
color deus

" ==
" === Plugin settings ===
"
" === coc.nvim 
" ===
let g:coc_global_extensions = ['coc-json',
			\ 'coc-explorer',
			\'coc-git',
			\'coc-translator',
			\'coc-clangd']

nnoremap <leader>e :CocCommand explorer<CR>
" coc-translator
nmap ts <Plug>(coc-translator-p)
vmap ts <Plug>(coc-translator-pv)

" use <tab> for trigger completion and navigate to the next complete item
inoremap <silent><expr> <TAB>
	"\ pumvisible() ? "\<C-n>" :
	\ pumvisible() ? coc#_select_confirm() :
	\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap',['snippets-expand-jump',''])\<CR>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\  coc#refresh()
inoremap <expr>j pumvisible() ? "\<C-n>" : "\j"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm(): "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"inoremap <silent><expr> <space> pumvisible() ? coc#_select_confirm() : "\<space>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <c-o> coc#refresh()
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

nmap <leader>l <Plug>(coc-format)

" Useful commands
nmap <F2> <Plug>(coc-rename)
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" === coc end === 
