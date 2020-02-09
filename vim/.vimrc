"Vundle Configuration

set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"Windows clipboard configuration

set clipboard+=unnamed  " use the clipboards of vim and win
set paste               " Paste from a windows or from vim
set go+=a               " Visual selection automatically copied to the clipboard

"Key mappings for easy navigation between tabs
nnoremap <C-h> :tabprevious<CR>           
nnoremap <C-l> :tabnext<CR>

"Key mappings for moving tabs
nnoremap <silent> <A-h> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-l> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

"Set Colour Scheme
colo molokai 

" Make delete and backspace behave "normally" in insert mode
set backspace=indent,eol,start
fixdel


"Configuration wishlist:
" - https://github.com/tpope/vim-sensible:
" 	- incsearch
"	- scrolloff
" - pretty fonts and colour scheme
" - automatic line numbering
" - nerdTree
" - ctrlP

"Use powershell instead of cmd.exe:
set shell=powershell.exe
set shellcmdflag=-NoProfile\ -NoLogo\ -NonInteractive\ -Command
set shellpipe=|
set shellredir=>

"Avoid using escape key to return to normal mode"
:imap jk <Esc>
:imap kj <Esc>
:imap <M-Space> <Esc>

"Search configuration
:set ic			"ignore case
:set hlsearch		"hilight results

"Text wrapping
set wrap

"Spell Check
set spell
