set nocompatible              " be iMproved, required
filetype off                  " required
let maplocalleader = ','

" Vundle plugins -{{{
"" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"Plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'scrooloose/nerdcommenter'
Bundle 'vim-scripts/CountJump'
Bundle 'vim-scripts/Gundo'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdtree'
Bundle 'easymotion/vim-easymotion'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" End of Vundle stuff! -}}}


syntax on
set relativenumber "show line numbers
set number
"below makes space an 'insert one character' button
nnoremap <Space> i_<Esc>r 
set whichwrap+=<,>,[,],h,l "makes left right arrows and h l wrap around to previous lines
set tabstop=4 "makes tab 4 spaces wide
set nowrap "stops line wrapping. 
set backspace=indent,eol,start "lets you backspace through where you started editing
set autoindent
set visualbell
set splitright
set copyindent
set shiftwidth=4 "number of spaces for autoindenting
set shiftround "use multiples of shiftwidth for indening with > <
set ignorecase "in searching ignore cases	
set smartcase "in searching ignore case if all lower case otherwise don't
set smarttab
set incsearch "start showing search results as you type
set hlsearch "highlight searches
set history=1000 "record 1000 command!s for history
set undolevels=1000 "record 100 undolevels
set wildignore=*.idx,*.pdf,*.out,*.pyc,*.aux,*.bbl,*.blg,*.log,*.fdb_latexmk,*.synctex.gz,*.fls,*.dvi  "this ignores pyc files in tab expansion, add other filetypes that bug you here
"below lets ,/ clear search buffer without deleting search history
nnoremap <silent> ,/ :nohlsearch<CR>  
"
"highlight your current row and column {{{
hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
nnoremap <Leader>h :set cursorline! cursorcolumn!<CR> 
"}}}

"set up statusline {{{
set laststatus=2 
set statusline={%.20f} "left hand side should be file name.
set statusline+=%m%r "display a [+] if modified and [RO] if readonly
set statusline+=[FileType:\ %Y] "display filetype
set statusline+=%=%c,%l/%L "column number, line number / Total number of lines
set statusline+=\ \ %P "Percentage through file
"}}}
command! WQ wq 
command! Wq wq 
command! W w
command! Q q
"below lets you hit enter to get rid of highlights of a search
nnoremap <CR> :noh<CR>
nnoremap <leader>c :bd<CR>
"below makes the space bar a insert one character button
nnoremap <Space> i_<Esc>r
"below makes shift-enter add a new line above current position
hi clear SpellBad
hi SpellBad cterm=underline
hi clear SpellLocal
hi SpellLocal cterm=underline

set noea ""this means windows don't always resize after opening or closing other windows.


"Gundo Toggle
nnoremap <F5> :GundoToggle<CR>

"NerdTreeToggle
noremap <C-n> :NERDTreeToggle<CR>

nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

nnoremap <leader>o o<esc>k
nnoremap <leader>O O<esc>j


"leader tn will toggle numbers between absolute and relative for the current buffer
nnoremap <leader>tn :set relativenumber!<cr>

"Scroll other windows when only two windows open 
nnoremap <leader>c <c-w>j:q<cr>
nnoremap <leader>d <c-w>w<c-d><c-w>w
nnoremap <leader>u <c-w>w<c-u><c-w>w
"helper functions for file specific set ups -{{{
"mappinng to make movements operate on 1 screen line in wrap mode
function! ScreenMovement(movement)
	   if &wrap
	   		return "g" . a:movement
		else
			return a:movement
		endif
	endfunction

"A function that sets up movement on wrapped text
function! Text_config()
	setlocal wrap linebreak nolist
	set spell spelllang=en_gb
	onoremap <silent> <expr> j ScreenMovement("j")
	onoremap <silent> <expr> k ScreenMovement("k")
	onoremap <silent> <expr> 0 ScreenMovement("0")
	onoremap <silent> <expr> ^ ScreenMovement("^")
	onoremap <silent> <expr> $ ScreenMovement("$")
	nnoremap <silent> <expr> j ScreenMovement("j")
	nnoremap <silent> <expr> k ScreenMovement("k")
	nnoremap <silent> <expr> 0 ScreenMovement("0")
	nnoremap <silent> <expr> ^ ScreenMovement("^")
	nnoremap <silent> <expr> $ ScreenMovement("$")
endfunction
"-}}}
"text file specific set up -{{{
augroup filetype_text
	autocmd!
	autocmd BufNewFile,BufRead *.txt set filetype=text
	autocmd FileType text call Text_config()
augroup END
"text file specific set up -}}}

" capitalise word
nnoremap <leader>~ mqb~`q

"Copy paste accross vim instances - helps with tmux :)
" copy to buffer
vmap <leader>y :w! ~/.vimbuffer<CR>
nmap <leader>y :.w! ~/.vimbuffer<CR>
" paste from buffer
map <leader>p :r ~/.vimbuffer<CR>
inoremap jk <esc>
" TMUX HOOKUP -{{{
nnoremap <leader>ts :!tmux split-window -hd<cr><cr>:!tmux resize-pane -R 50<cr><CR>
nnoremap <leader>tr :!tmux resize-pane -R 30<cr><cr>
nnoremap <leader>tl :!tmux resize-pane -L 30<cr><cr>
nnoremap <leader>tc :!tmux kill-pane -t .1<cr><c:>
" -}}}



"Vimscript file specific set up -{{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim :set textwidth=0
	autocmd FileType vim :setlocal foldmethod=marker
augroup END
"Vimscript file specific set up -}}}
"Java file specific set up -{{{
augroup filetype_java
	autocmd!
	autocmd FileType java nnoremap <silent> <buffer> <localleader>r :Java<cr>
	autocmd FileType java nnoremap <silent> <buffer> <localleader>i :JavaImport<cr>
	autocmd FileType java nnoremap <silent> <buffer> <localleader>d :JavaDocSearch -x declarations<cr>
	autocmd FileType java nnoremap <silent> <buffer> <cr> :JavaSearchContext<cr>
augroup END
"-}}}
"Python file specific set up -{{{
augroup filetype_python
	autocmd!
	autocmd FileType python nnoremap <localleader>p :!python %<cr>
	autocmd FileType python nnoremap <localleader>r :!tmux send-keys -t .1 "python3 %"; tmux send-keys -t .1 C-m<CR><CR>
	autocmd FileType python nnoremap <localleader>x :!tmux send-keys -t .1 C-c<CR><CR>
	autocmd FileType python nnoremap <localleader>s :!tmux send-keys -t .1 "sage -python %"; tmux send-keys -t .1 C-m<CR><CR>
augroup END
"-}}}
"bash file specific set up -{{{
augroup filetype_sh
	autocmd!
	autocmd FileType sh nnoremap <localleader>r :!tmux send-keys -t .1 "./%"; tmux send-keys -t .1 C-m<CR><CR>
	autocmd FileType sh nnoremap <localleader>x :!tmux send-keys -t .1 C-c<CR><CR>
augroup END
"-}}}
