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
highlight ColorColumn ctermbg=3

" prevent // autoinsertion
" http://vim.wikia.com/wiki/Disable_automatic_comment_insertion
au FileType c,cpp,scala setlocal comments-=:// comments+=f://

" use ron colorscheme
colorscheme ron

" adjust search highlighting color
hi Search ctermbg=3 ctermfg=0

" add mouse support for vim
if !has('nvim') " built in for nvim
	set ttymouse=xterm2
endif
set mouse=a
