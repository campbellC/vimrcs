set nocompatible              " be iMproved, required
filetype off                  " required
"" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'vim-scripts/AutoComplPop'
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
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" End of Vundle stuff!
syntax on
set relativenumber "show line numbers
"below makes space an 'insert one character' button
nmap <Space> i_<Esc>r 
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
set history=1000 "record 1000 commands for history
set undolevels=1000 "record 100 undolevels
set wildignore=*.out,*.pyc,*.aux,*.bbl,*.blg,*.log,*.fdb_latexmk,*.synctex.gz,*.fls,*.dvi  "this ignores pyc files in tab expansion, add other filetypes that bug you here
"below lets ,/ clear search buffer without deleting search history
nmap <silent> ,/ :nohlsearch<CR>  
"the three lines below make <Leader>h highlight your current row and column
hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
nnoremap <Leader>h :set cursorline! cursorcolumn!<CR> 
"make a status line with file name, encoding and ruler info appear at bottom
"of screen
set laststatus=2
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
command WQ wq 
command Wq wq 
command W w
command Q q
"below lets you hit enter to get rid of highlights of a search
nnoremap <CR> :noh<CR><CR> 
"below makes the space bar a insert one character button
nnoremap <Space> i_<Esc>r
"below makes shift-enter add a new line above current position
nnoremap <S-CR> O<Esc>j
hi clear SpellBad
hi SpellBad cterm=underline
hi clear SpellLocal
hi SpellLocal cterm=underline
"" the following commands let you jump to snippets pages quickly, and also .vimrc
command Csnip new ~/.vim/bundle/vim-snippets/snippets/c.snippets
command Pysnip new ~/.vim/bundle/vim-snippets/snippets/python.snippets
command Vimrc vsplit ~/.Vimrc
command Cppsnip new ~/.vim/bundle/vim-snippets/snippets/cpp.snippets
command Jsnip new ~/.vim/bundle/vim-snippets/snippets/java.snippets
command Texsnip new ~/.vim/bundle/vim-snippets/snippets/tex.snippets
cabbrev newtab <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'tabedit' : '')<CR>

""snippets variables
let g:snips_author='Chris Campbell'
let g:snips_email='c (dot) j (dot)  campbell (at) ed (dot) ac (dot) uk'
let g:snips_github='https://github.com/chriscampbell19'
let g:email='c (dot) j (dot)  campbell (at) ed (dot) ac (dot) uk'
let g:github='https://github.com/chriscampbell19'

set noea ""this means windows don't always resize after opening or closing other windows.

"Thesis specific command
command Sty vsplit ~/Library/texmf/tex/latex/local/MyThesis.sty
command Bib new ~/Library/texmf/bibtex/bib/local/bibliography.bib
function Thesis(num)
	execute '!cd ~/Dropbox/PhD/AllThingsThesis/Thesis/ && ltex thesis && open thesis.pdf && osascript ~/Dropbox/UsefulScripts/changePage.scpt ' . a:num . '&& cd -'
endfunction

 
function CompileAndOpen(fileName,num)
	execute '!ltex ' . a:fileName . ' && myLatexOpen ' . a:fileName .'.pdf && osascript ~/Dropbox/UsefulScripts/changePage.scpt ' . a:num 
endfunction

"mappinng to make movements operate on 1 screen line in wrap mode
function! ScreenMovement(movement)
	   if &wrap
	   		return "g" . a:movement
		else
			return a:movement
		endif
	endfunction




"language specific set up goes below
autocmd BufNewFile,BufRead *.txt set filetype=text
autocmd FileType text call Text_config()
	function Text_config()
		set wrap linebreak nolist
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
autocmd FileType tex call Tex_config()
	function Tex_config()
		set cc=150
		set wrap linebreak nolist
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


"PYTHON-MODE SETTINGS. TAKEN FROM :
"http://unlogic.co.uk/2013/02/08/vim-as-a-python-ide/

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

"Gundo Toggle
nnoremap <F5> :GundoToggle<CR>

"NerdTreeToggle
map <C-n> :NERDTreeToggle<CR>

let leader = ','
