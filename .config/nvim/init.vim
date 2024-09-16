set hidden            " allows switching buffers without saving
syntax on             " syntax coloring
set autoindent        " match indentation of preceding line
set expandtab         " use spaces for tab
set shiftwidth=4      " indent by this much after {, etc
set tabstop=4         " how many spaces to indent by
set smarttab
set cinoptions+=(0    " line up additional agruments to function
set textwidth=79      " line wrap at 79 chars
set visualbell        " don't beep when error, make screen flash
set ignorecase        " perform case-insensitve searches
set smartcase         " searches are case sensitive if there is one capital letter
set hlsearch          " highlights search matches
set incsearch         " search as you type
set history=1000      " remember more
set scrolloff=3       " keep some context when scrolling

let mapleader = ","   " meta key is comma

" use +/- directly to resize windows
map - <C-W>-
map + <C-W>+

" temporarily get rid of highlight with leader n
nmap <silent> <leader>v :silent :nohlsearch<CR>

" set working directory to that of the current file
map <leader>cd :cd %:p:h<CR>

" show whitespace
set listchars=tab:>-,trail:·
set list
nmap <silent> <leader>s :set nolist!<CR>

" scroll by 3 instead of 1
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

set wildmode=list:longest " better command mode completion

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" map ctrl-s to save
map <C-s> :wa<CR>
imap <C-s> <esc>:wa<CR>

" map to switch btwn header/cpp file
map <leader>o :A<CR>

" edit last
map <Leader>a :e #<CR>

" Pull word under cursor into LHS of a substitute
:nnoremap <Leader>z :%s/\<<C-r><C-w>\>/

" hit colon from command mode without shift!
map ; :


