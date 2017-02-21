"set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible "OBRIGATORIO PRA USAR O VUNDLE
filetype off
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
set textwidth=100
" turn syntax highlighting on
set t_Co=256
syntax on
" colorscheme wombat256
" turn line numbers on
set number
" highlight matching braces
set showmatch
" status line
set laststatus=2
set statusline=
set statusline+=%7*\[%n]                                  "buffernr
set statusline+=%1*\ %<%F\                                "File+path
set statusline+=%2*\ %y\                                  "FileType
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=%4*\ %{&ff}\                              "FileFormat
set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage &
set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=%9*\ col:%03c\                            "Colnr
set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly?
function! HighlightSearch()
    if &hls
        return 'H'
    else
        return ''
    endif
endfunction
" more
" --------------------------------------------------------------
set path+=**
set wildmenu
filetype plugin on

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"---------- PLUGINS ABAIXO -----------
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdcommenter'
"Plugin 'valloric/youcompleteme' "DEU PAU NO COMPILE
Plugin 'mattn/emmet-vim'
"
"-----------PLUGINS ACIMA-------------
call vundle#end()            " required
filetype plugin indent on    " required


colorscheme wombat256i
set colorcolumn=90
set autoread "" qd mudar de fora ele atualiza
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*        " Linux/MacOSX
map <C-n> :NERDTreeToggle<CR>         
