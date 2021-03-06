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
set backspace=indent,eol,start     " let the backspace key work normally
set hidden                         " hide unsaved buffers
set incsearch                      " incremental search rules
" status line
set laststatus=2
set statusline=
set statusline+=%7*\[%n]                                  "buffernr
set statusline+=%F
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
    f &hls
        return 'H'
    else
        return ''
    endif
endfunction


let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightlineModified',
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \ },
      \ 'separator': { 'left': '>', 'right': '<' },
      \ 'subseparator': { 'left': '$', 'right': '$' }
      \ }
"--------------------------------------------------------------------


"-------------------------------------------------------------------
function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '|' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%') ? expand('%') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? '| '.branch : ''
  endif
  return ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction


" more
" --------------------------------------------------------------
set path+=**
set wildmenu
set rtp+=~/.vim/bundle/Vundle.vim    
"sudo apt-get install exuberant-ctags
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/vendor,*/node_modules

call vundle#begin()
"---------- PLUGINS ABAIXO -----------
Plugin 'VundleVim/Vundle.vim'
"Plugin 'scrooloose/nerdtree'
"Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
"
"Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdcommenter'
Plugin 'valloric/YouCompleteMe' "DEU PAU NO COMPILE
Plugin 'ervandew/supertab'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
"Plugin 'mattn/emmet-vim'
"Plugin 'taglist.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
"Plugin 'Shougo/neocomplete'
"Plugin 'Shougo/neosnippet'
"Plugin 'Shougo/neosnippet-snippets'
Plugin 'tpope/vim-fugitive'
Plugin 'itchyny/lightline.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-obsession'
Plugin 'tweekmonster/django-plus.vim'
Plugin 'tpope/vim-surround'
"
"-----------PLUGINS ACIMA-------------
call vundle#end()            " required
filetype plugin indent on    " required


colorscheme wombat256i
set colorcolumn=90
highlight ColorColumn ctermbg=238
set autoread "" qd mudar de fora ele atualiza
"map <C-n> :NERDTreeToggle<CR>         
set ruler

"let g:easytags_cmd = $USERPROFILE.'\ctags58'


setglobal relativenumber
autocmd WinEnter * :setlocal relativenumber
autocmd WinLeave,FocusLost * :setlocal number
autocmd InsertEnter * :setlocal number
autocmd InsertLeave * :setlocal relativenumber

function! g:ToggleNuMode()
    if(&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunc

map <C-k> :call g:ToggleNuMode()<CR>
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
"
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"
let base16colorspace=256
"let g:airline_theme = "sol"
"let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1

" Navigation shortcuts
"map <C-t> :TagbarToggle<CR>         " toggle tag bar
map <C-l> :bnext<CR>                " switch to next buffer
map <C-h> :bprevious<CR>            " switch to previous buffer
map <leader>t :CtrlPTag<CR>
"mapear o comentario melhor
"let g:easytags_dynamic_files = 1
"set tags=./tags;
let g:ctrlp_working_path_mode = 'ra'
let g:easytags_by_filetype=$PWD.'/.git/tags'
let g:easytags_auto_update = 0
"let g:easytags_opts = ['--options=$HOME/.ctags']
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:25,results:80'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data$\|log$\|tmp$|vendor\|node_modules\',
  \ 'file': '\.exe$\|\.so$\|\.dat$|\.png$|\.jpg$|\.jpeg$|\*.png$'
  \ }
map <leader>- :vertical resize -5<CR> 
map <leader>= :vertical resize +5<CR> 
set clipboard=unnamedplus
