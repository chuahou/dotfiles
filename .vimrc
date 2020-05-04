" no need to be vi-compatible
set nocompatible

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

	" indentation
	filetype plugin indent on
	set autoindent
	set smarttab

	" highlight searches
	set hlsearch
	set incsearch

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

" use my colorscheme
colorscheme thewursttheme

" turn on undofiles
set undofile

" add indentation settings
set tabstop=4 softtabstop=0 shiftwidth=4

" add line numbers
set number

" add fold column
set foldcolumn=1

" highlight past 80
let &colorcolumn=join(range(81,81),",")

" show whitespace
set lcs=tab:>\ \|,trail:+,nbsp:X,space:·
set list

" prevent // autoinsertion
" http://vim.wikia.com/wiki/Disable_automatic_comment_insertion
au FileType c,cpp,scala setlocal comments-=:// comments+=f://

" use thewursttheme colorscheme
colorscheme thewursttheme

" enable spell checking
set spell

" enable mouse in any mode
set mouse=a

" add copy / paste using \y \p by using + (clipboard) as yank/paste register
" Ubuntu vim doesn't seem to be compiled with xterm_clipboard :(
" Check with :version
noremap <Leader>y "+y
noremap <Leader>p "+p

" get vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/0.10.0/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" list of vim-plug plugins
call plug#begin('~/.vim/plugged')
	if has('nvim') " neovim plugins
		" firenvim for Firefox integration
		Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
	else " vim plugins
	endif

	" common plugins
call plug#end()

" default neovim plugins for vim
if !has('nvim')
	runtime macros/matchit.vim
endif

