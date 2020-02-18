# Vim Installation on Windows Step-By-Step Walkthrough
This is a summary of how I configured Vim for Python. Big thanks to the team at [Real Python](https://realpython.com/vim-and-python-a-match-made-in-heaven/#team) for writing [this guide](https://realpython.com/vim-and-python-a-match-made-in-heaven/#.V1rDm_8hrNU.reddit).

1. Installation
- Went [here](https://www.vim.org/download.php#pc) to download the [official Windows executable installer](https://ftp.nluug.nl/pub/vim/pc/gvim82.exe).
- Performed a "Typical" install.
- Added the directory with the Vim executables `C:\Program Files (x86)\Vim\vim82\` to the system path.
- Tested the installation with `> vim --v` or `vi --v`

2. Configuration
- Created `.vimrc` in the `$HOMEPATH` directory. To check the directory, type `:echo $HOMEPATH` in vim.
- To enable the windows clipboard, add the below configurations to `vimrc`:
```
"Windows clipboard configuration

set clipboard+=unnamed  " use the clipboards of vim and win
set paste               " Paste from a windows or from vim
set go+=a               " Visual selection automatically copied to the clipboard
``` 

3. Download Vundle plugin manager from [here](https://github.com/VundleVim/Vundle.vim) and place it in the plugins directory `C:\Users\chris\vimfiles\plugin\Vundle.vim` or alternatively run:

```
$ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
- Add the below configurations to `~\.vimrc`:
```
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

```
Can now open vim and run `:PluginInstall` to install new plugins.


