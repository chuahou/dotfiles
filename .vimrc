" no need to be vi-compatible
set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM/NEOVIM COMPATIBILITY                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !has('nvim')
" enable default nvim behaviour in normal vim
	" backup directories
	set backupdir=~/.vim/backup//,.
	set directory=~/.vim/backup//,.
	set undodir=~/.vim/backup//,.

	" mouse
	set ttymouse=xterm2

	" enable statusline
	set laststatus=2

	" highlight searches
	set hlsearch
	set incsearch

	" indentation
	filetype plugin indent on
	set autoindent
	set smarttab

	" matchit plugin is enabled by default in neovim
	runtime macros/matchit.vim

	" loads of other stuff from https://neovim.io/doc/user/vim_diff.html
	set autoread                   " reread file if modified externally
	set backspace=indent,eol,start " enable backspace over whitespace
	set belloff=all                " no ringing bell please
	set cscopeverbose              " no clue
	set display=lastline           " display settings
	set encoding=utf-8             " default encoding utf-8
	set formatoptions=tcqj         " will be overwritten by ftdetect
	set nofsync                    " don't call OS fsync for efficiency
	set history=10000              " max history
	set langnoremap                " some map shenanigans
	set nolangremap                " langnoremap but better
else
" nvim-specific configuration
	set inccommand=nosplit
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" APPEARANCE                                                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" use my colorscheme
colorscheme thewursttheme

" interface settings
set number                               " show line numbers
set foldcolumn=1                         " show fold column
let &colorcolumn=join(range(81,81),",")  " highlight column 81
set lcs=tab:\|\ \ ,trail:+,nbsp:X,space:· " whitespace settings
set list                                 " show whitespace

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEHAVIOUR                                                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" turn on undofiles
set undofile

" enable mouse in any mode
set mouse=a

" add copy / paste using \y \p by using + (clipboard) as yank/paste register
" Ubuntu vim doesn't seem to be compiled with xterm_clipboard :(
" Check with :version
noremap <Leader>y "+y
noremap <Leader>p "+p

" add indentation settings
set smartindent   " smart indentation
set noexpandtab   " use hard tabs
set tabstop=4     " hard tab width of 4
set softtabstop=4 " soft tab width of 4
set shiftwidth=0

" auto wrap after 80 columns
set textwidth=80

" remember last position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" trim errant empty lines at end of file
function TrimEndLines()
	let save_cursor = getpos(".")
	silent! %s#\($\n\s*\)\+\%$##
	call setpos('.', save_cursor)
endfunction
autocmd BufWritePre * call TrimEndLines()

" run make if Makefile exists
function MaybeMake()
	if filereadable("Makefile")
		!make
	endif
endfunction

" run make upon LaTeX written
autocmd BufWritePost *.tex silent exec "call MaybeMake()"

" ensure new line at EOF
set fixeol

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TEMPLATES AUTOCOMMANDS                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function InsertCopyright()
	:0r!date "+\%Y"
	norm gg0OSPDX-License-Identifier: ???
	norm ggj0iCopyright (c) 
	norm ggj$a Chua Hou
endfunction
command! InsertCopyright call InsertCopyright()

augroup vimrctemplates
	" clear existing
	autocmd!

	" wiki % title
	autocmd BufNewFile *.wiki norm gg0i%title

	" copyright notice except for vimwiki
	autocmd BufNewFile *[^{.wiki}] call InsertCopyright()

	" comment notice for each filetype
	autocmd BufNewFile *.c,*.cpp,*.rs,*.scala,*.java norm gg0i// 
	autocmd BufNewFile *.c,*.cpp,*.rs,*.scala,*.java norm ggj0i// 
	autocmd BufNewFile *.hs norm gg0i-- 
	autocmd BufNewFile *.hs norm ggj0i-- 
	autocmd BufNewFile *.py,*.sh,*.zsh norm gg0i# 
	autocmd BufNewFile *.py,*.sh,*.zsh norm ggj0i# 
	autocmd BufNewFile *.sh norm ggO#!/usr/bin/env bash
	autocmd BufNewFile *.zsh norm ggO#!/usr/bin/env zsh
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OTHERS                                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Create backup directory by default
if empty(glob('~/.vim/backup'))
	silent !mkdir -p ~/.vim/backup
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS                                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" get vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/0.10.0/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" list of vim-plug plugins
call plug#begin('~/.vim/plugged')
	if has('nvim') " neovim plugins
	else " vim plugins
	endif

	" common plugins
	Plug 'octol/vim-cpp-enhanced-highlight'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'godlygeek/tabular'
	Plug 'vimwiki/vimwiki'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'Rykka/InstantRst'
	Plug 'ossobv/vim-rst-tables-py3'
call plug#end()

" run default neovim plugins for vim
if !has('nvim')
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN CUSTOMISATION                                                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" custom command for aligning by spaces
command! -range Align <line1>,<line2>s/\s\+/ /g | noh | <line1>,<line2>Tab/ /l0

" vimwiki configuration
let g:vimwiki_list = [{
			\'path'             : '~/Projects/knowledge/wiki/',
			\'path_html'        : '~/Projects/knowledge/docs/',
			\'template_path'    : '~/Projects/knowledge/templates/',
			\'template_default' : 'template',
			\'template_ext'     : '.html',
			\'nested_syntaxes'  : {
				\'algorithm': 'plaintex',
				\'cpp': 'cpp',
				\'clang': 'c',
				\'scala': 'scala'},
			\'custom_wiki2html' : '~/Projects/knowledge/wiki2html.sh',
			\}]
let g:vimwiki_global_ext = 0
noremap <Leader>wo :VimwikiGoto
noremap <Leader>wb :Vimwiki2HTMLBrowse
autocmd BufWritePost *.wiki :Vimwiki2HTML
let g:vimwiki_conceallevel = 0

" coc configuration
let g:coc_global_extensions = [
			\'coc-python',
			\'coc-yaml',
			\'coc-json',
			\'coc-html',
			\'coc-css',
			\'coc-metals',
			\]

" vim-airline configuration
let g:airline_theme = 'angr'
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline#extensions#checks = [
			\'indent', 'long', 'trailing', 'mixed-indent-file', 'conflicts' ]
let g:airline#extensions#whitespace#skip_indent_check_ft = {
			\'vim': ['trailing'],
			\'vimwiki': ['mixed-indent-file']
			\}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DEFAULT COC THINGS                                                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
"			\pumvisible() ? "\<C-n>" :
"			\<SID>check_back_space() ? "\<TAB>" :
"			\coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
	inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder.
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
