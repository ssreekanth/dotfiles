set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.tmp/vim/bundle')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Themes / Color Schemes
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'flazz/vim-colorschemes'

" Typescript syntax highlighting and other settings.
Plugin 'leafgarland/typescript-vim'

" Cursorline highlighter
Plugin 'miyakogi/conoline.vim'

" File Explorer
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'

" Super Editing
Plugin 'editorconfig/editorconfig-vim'
Plugin 'junegunn/vim-easy-align'
"Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-surround'
Plugin 'kana/vim-textobj-user'
Plugin 'glts/vim-textobj-comment'
Plugin 'tpope/vim-commentary'

" Git plugins
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'juneedahamed/svnj.vim'

" AutoComplete / Syntax Checking / Code Navigation
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'

Plugin 'wikitopian/hardmode'
Plugin 'takac/vim-hardtime'

Plugin 'easymotion/vim-easymotion'
Plugin 'dietsche/vim-lastplace'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""

set timeoutlen=1000
set laststatus=2
if !has('nvim')
    set encoding=utf-8
endif
set t_Co=256

if has("gui_running")
   let s:uname = system("uname")
   if s:uname == "Darwin\n"
      set guifont=Inconsolata\ for\ Powerline:h15
   endif
endif

set background=dark
" colorscheme jellybeans
colorscheme gruvbox

" mark just the first character going out of the specified column
highlight ColorColumn ctermbg=magenta
set colorcolumn=80

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:airline_theme='jellybeans'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Conoline settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:conoline_auto_enable = 1
let g:conoline_use_colorscheme_default_normal=1
let g:conoline_use_colorscheme_default_insert=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrlp settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildignore+=*.o,*.os,*.a,*.so,*.pyc,*/.git/*,*/.svn/*
set wildignore+=*.o,*.os,*.a,*.so,*.pyc,*\\.git\\*,*\\.svn\\*

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>jd :YcmCompleter GoTo<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_html_tidy_blocklevel_tags=["ion-nav-view", "ion-content", "ion-pane",
            \ "ion-header-bar", "ion-list", "ion-item",
            \ "webview"]
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" old vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

set hlsearch

syntax on
set autoindent
set nowrap

set noshowmode
set showmatch

set tabstop=4
set shiftwidth=4
set expandtab
retab

set relativenumber
set number

" toggle invisible characters
set invlist
set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
highlight SpecialKey ctermbg=none " make the highlighting of tabs less annoying
set showbreak=↪
nmap <leader>l :set list!<cr>

set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp,.
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp,.
set undodir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp,.

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Compatibility between vim and nvim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !has('nvim')
    set ttymouse=xterm2
endif

if exists(':tnoremap')
    tnoremap <Esc> <C-\><C-n>
endif

