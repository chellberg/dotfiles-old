set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
Plugin 'tpope/vim-fugitive'
Plugin 'vim-ruby/vim-ruby'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-rails'
Plugin 'kchmck/vim-coffee-script'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'altercation/vim-colors-solarized'
Plugin 'kien/ctrlp.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'xolox/vim-misc'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-surround'
Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-endwise'
Plugin 'edkolev/tmuxline.vim'
Plugin 'itchyny/lightline.vim'

call vundle#end()

runtime macros/matchit.vim " Enabling the matchit plugin will enhance Vim’s built-in % command, making it possible to jump between pairs of Ruby keywords, such as class, module, def, if, do, and their corresponding end 

set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

filetype on
syntax on
filetype indent plugin on

set hlsearch
set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set cmdheight=2
set number
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>
set shiftwidth=2
set softtabstop=2
set expandtab
set ttyfast
set lazyredraw
set scrolloff=15
set nohidden
set incsearch
set matchtime=2 
set cursorline

" Pane/split settings
set splitbelow
set splitright

" autosave/autoload view
au BufWritePost,BufLeave,WinLeave ?* mkview
au BufWinEnter ?* silent loadview

" save and load sessions
nnoremap <F1> :mksession! .quicksave.vim<CR>
nnoremap <F2> :source .quicksave.vim<CR>

" navigate between panes with ctrl+<dir>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" switch tabs vim-style
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>

" Edit vimrc \ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

map Y y$

" Not working
nnoremap <C-L> :nohl<CR><C-L>

" regen ctags
command! GenerateTags call system('ctags -Rf ./.tags --exclude=.git `cat .srclist`') | echo
nnoremap <F4> :GenerateTags<CR>

colorscheme 256-grayvim 

" resizing panes
" set winheight=30
" set winminheight=5
" nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
" nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>

" CtrlP
let g:ctrlp_max_height = 40
let g:ctrlp_max_files = 20000 
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP /Users/cchellberg/sourcing'

" vimgrep and CtrlP use Ag
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" backups/persistent undo history
set undofile
set backup
set noswapfile

set undodir=~/.vim/tmp/undo/
set backupdir=~/.vim/tmp/backup/
set directory=~/.vim/tmp/swap/
set ambiwidth=double

if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }
