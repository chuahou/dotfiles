" make backups go to other folder for vim
if !has('nvim') " nvim overrides these
	set backupdir=~/.vim/backup//,.
	set directory=~/.vim/backup//,.
endif

" turn off undofile
set noundofile

" add indentation settings
set tabstop=4 softtabstop=0 shiftwidth=4

" add line numbers
set number

" highlight past 80
let &colorcolumn=join(range(81,81),",")

" prevent // autoinsertion
" http://vim.wikia.com/wiki/Disable_automatic_comment_insertion
au FileType c,cpp,scala setlocal comments-=:// comments+=f://

" use chelek colorscheme
colorscheme chelek

" add mouse support for vim
if !has('nvim') " built in for nvim
	set ttymouse=xterm2
endif
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
	else " vim plugins
	endif

	" common plugins
call plug#end()

