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
"Plugin 'vim-scripts/AutoComplPop'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdcommenter'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Bundle 'vim-scripts/CountJump'
Bundle 'vim-scripts/ingo-library'
Bundle 'klen/python-mode'
Bundle 'vim-scripts/Gundo'
Bundle 'mtth/scratch.vim'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdtree'
Bundle 'easymotion/vim-easymotion'
"colorschemes
Bundle 'flazz/vim-colorschemes'
Bundle 'easysid/mod8.vim'
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
set wildignore=*.idx,*.out,*.pyc,*.aux,*.bbl,*.blg,*.log,*.fdb_latexmk,*.synctex.gz,*.fls,*.dvi  "this ignores pyc files in tab expansion, add other filetypes that bug you here
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
"" the following command!s let you jump to snippets pages quickly, and also .vimrc
command! Txtsnip new ~/.vim/bundle/vim-snippets/snippets/textile.snippets
command! Csnip new ~/.vim/bundle/vim-snippets/snippets/c.snippets
command! Pysnip new ~/.vim/bundle/vim-snippets/snippets/python.snippets
command! Vimrc vsplit ~/.Vimrc
command! Cppsnip new ~/.vim/bundle/vim-snippets/snippets/cpp.snippets
command! Jsnip new ~/.vim/bundle/vim-snippets/snippets/java.snippets
command! Texsnip new ~/.vim/bundle/vim-snippets/snippets/tex.snippets
cabbrev newtab <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'tabedit' : '')<CR>
""snippets variables
let g:snips_author='Chris Campbell'
let g:snips_email='c (dot) j (dot)  campbell (at) ed (dot) ac (dot) uk'
let g:snips_github='https://github.com/campbellC'
imap <C-\> <Plug>snipMateNextOrTrigger
smap <C-\> <Plug>snipMateNextOrTrigger
let g:email='c (dot) j (dot)  campbell (at) ed (dot) ac (dot) uk'
let g:github='https://github.com/campbellC'
let g:EclimCompletionMethod='omnifunc'
command! EclimSetUpHere ProjectCreate . -n java
set noea ""this means windows don't always resize after opening or closing other windows.

"Thesis specific command!
command! Sty vsplit ~/Library/texmf/tex/latex/local/MyMastersThesis.sty
command! OldSty vsplit ~/Library/texmf/tex/latex/local/MyThesis.sty
command! Bib new ~/Library/texmf/bibtex/bib/local/mastersBibliography.bib
command! OldBib new ~/Library/texmf/bibtex/bib/local/bibliography.bib
function! Thesis(num)
	execute '!cd ~/Dropbox/PhD/AllThingsThesis/Thesis/ && ltex thesis && open thesis.pdf && osascript ~/Dropbox/UsefulScripts/changePage.scpt ' . a:num . '&& cd -'
endfunction

 
function! CompileAndOpen(fileName,num)
	execute '!ltex ' . a:fileName . ' && myLatexOpen ' . a:fileName .'.pdf && osascript ~/Dropbox/UsefulScripts/changePage.scpt ' . a:num 
endfunction

function! StartupEclimFunc()
	execute '!/Applications/Eclipse.app/Contents/Eclipse/eclimd &'
endfunction
command! StartupEclim call StartupEclimFunc()


"quick saving
inoremap <c-s> <c-o>:w<CR>
nnoremap <silent> <C-s> :<C-u>w<CR>
"language specific set up goes below

"PYTHON-MODE SETTINGS.  -{{{
"TAKEN FROM : "http://unlogic.co.uk/2013/02/08/vim-as-a-python-ide/

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 1

" Documentation
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1
let g:pymode_lint_ignore = "E125,E116,E261,E263,W391,E265,E111,E262,E302,E303,W0611,E231,E225,E402,E501,E266,E502,E203,E502,E128,E202,E201,W0401,E702"

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_rope_rename_bind = '<C-c>rr'

" Don't autofold code
let g:pymode_folding = 0

"stop documentation randomly opening
set completeopt=menu
let pymode_complete_on_dot = 0

"stops strange . autocomplete problem
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_complete_on_dot = 0
"-}}}

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
"temporary
nnoremap <leader>ll :%s/\\)/\\]/ge <bar> %s/\\(/\\[/ge<cr>


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

"Thesis spell checks
iabbrev algbera algebra

"gets YCM to play nice
set shortmess+=c
"Latex file specific set up -{{{
augroup filetype_tex 
	autocmd!
	"The following takes an inline $-marked mathmode and converts it to display mode. It does not handle edge cases well yet
	"TODO: this doesn't work if cursor is over the first $ and also doesn't handle inlines at the end of lines well as it
	"adds an extra newline. Also, make it so that it takes punctuation and moves it into the maths! 
	autocmd FileType tex nnoremap <buffer> <LocalLeader>mm F$xi\[<cr><esc>f$a<cr><esc>k$r\a]<esc>F\i<cr><esc>
	autocmd Filetype tex nnoremap <buffer> <LocalLeader>co :call CompileAndOpen('%', 1)<cr>
	autocmd FileType tex nnoremap <localleader>r :w<cr>:!tmux send-keys -t .1 "ltex %"; tmux send-keys -t .1 C-m<CR><CR>
	autocmd FileType tex nnoremap <buffer> <LocalLeader>dm i\[<cr><cr>\]<esc>ki<tab>
	autocmd FileType tex iabbrev texo \texorpdfstring
	autocmd FileType tex :setlocal colorcolumn=120
	autocmd FileType tex call Text_config()
augroup END
"Latex file specific set up -}}}

"Vimscript file specific set up -{{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim :set textwidth=0
	autocmd FileType vim :setlocal foldmethod=marker
augroup END
"Vimscript file specific set up -}}}
"Sage file specific set up -{{{
augroup filetype_sage
	autocmd!
	autocmd BufNewFile,BufRead *.sage set filetype=sage
	autocmd FileType sage nnoremap <localleader>r :w<cr>:!tmux send-keys -t .1 "sage %"; tmux send-keys -t .1 C-m<CR><CR>
	autocmd FileType sage nnoremap <localleader>x :!tmux send-keys -t .1 C-c<CR><CR>
augroup END
"-}}}
"Gap file specific set up -{{{
augroup filetype_gap
	autocmd!
	autocmd BufNewFile,BufRead *.g set filetype=gap
	autocmd FileType gap nnoremap <localleader>r :w<cr>:!tmux send-keys -t .1 "./gap.sh %"; tmux send-keys -t .1 C-m<CR><CR>
	autocmd FileType gap nnoremap <localleader>x :!tmux send-keys -t .1 "quit\;"; tmux send-keys -t .1 Enter<CR><CR>
augroup END
"-}}}
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
	autocmd FileType python nnoremap <localleader>r :!tmux send-keys -t .1 "python %"; tmux send-keys -t .1 C-m<CR><CR>
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
