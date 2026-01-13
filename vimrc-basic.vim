""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         GENERAL BUILT-IN SETTINGS                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set encoding=utf8
"set spell spelllang=en,en_us,cjk  "Spell check [Ugly]
set nospell
set ignorecase "Case Insensitive
set smartcase  "Case sensitive when there's upper case in search
set hidden "Enable to switch buffer without saving
set number "show line number
set mouse=a  "a -> all, enbles mouse in Tmux (but text selection will trigger visual mode)
" Disable mouse selection into visual mode
"set mouse=nicr
"noremap <LeftDrag> <LeftMouse>
"noremap! <LeftDrag> <LeftMouse>

set shell=/bin/sh

" Persistent Session Options
set sessionoptions-=options    " do not store global and local values in a session
set sessionoptions-=folds      " do not store folds
" set sessionoptions-=buffers      " do not store closed buffers with :bd
" set sessionoptions=blank,buffers,curdir,tabpages,winsize,terminal

"Avoid annoying continuation of comment (:help fo-table)
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

" Avoid prompt to hit enter for every echo when it's not enough to show full msg
set shortmess+=T
set cmdheight=1

filetype plugin on
set omnifunc=syntaxcomplete#Complete
set completeopt=menu,menuone,noselect
" Bugfix for insert mode in SQL file:
" SQLComplete, The dbext plugin must be loaded for dynamic SQL completion -->
let g:omni_sql_default_compl_type = 'syntax'

autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

set nopaste  "IMPORTANT: If it's on, vim will auto indent (messed up) on your paste
set showcmd " show keypress at right-bottom
set backspace=2 "backspace over everything in insert mode
set tabstop=4 "Set a tab=4spaces
set smartindent "Auto indent after hit RETURN: autoindent, smartindent, cindent
set shiftwidth=4 "Set auto-indent to 4 spaces
set expandtab "Expand tab to spaces
retab "Replace all tabs to spaces on file opened
filetype plugin indent on

"[Key maps timeout]
set timeout
set ttimeout
set timeoutlen=1000
set ttimeoutlen=0
"Word recognizing
"set iskeyword-=_
"[Auto reload current file]
set autoread
au FocusGained,BufEnter * :checktime

" Automatically set view in the center when jump to the matches
" https://vim.fandom.com/wiki/Make_search_results_appear_in_the_middle_of_the_screen
set scrolloff=5  "Set 99 to make it center

" Neovim feature of :%s/a/b/
" if has('nvim')
"     set inccommand=split
" endif

set isfname-==  "When using 'gf', ignore '=' as part of the file name


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"              Vim / NeoVim Persistent Layer (Shada & VimInfo)               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Persistent mechanism will keep session/marks/jumplist/buffers...

" SHADA: (Neovim) options - format: set shada=FLAGS
"   'N - Required: Save marks for the last N files (0 = disable marks/jump locations)
"   !  - Save/restore global variables that start with uppercase and contain lowercase (e.g., MyVar)
"        Marks include: file marks ('a, 'b), jump locations (Ctrl-O/Ctrl-I), last position in files
"   <N - Save up to N lines for each register (yank/delete history)
"   @N - Save the last N registers (yank/delete history)
"   :N - Save the last N command-line history entries
"   /N - Save the last N search history entries
"   %N - Save/restore buffer list (N = number of buffers, 0 = disable)
"   sN - Only save items smaller than N KB (prevents saving large text blocks)
"   c  - Save encoding of the file (when 'encoding' differs from 'utf-8')
"   n  - Name of the shada file (default: ~/.local/share/nvim/shada/main.shada)
"   r  - Removable media (comma-separated list of paths, e.g., r/tmp,r/media)
"   h  - Disable search highlighting (hlsearch) when loading shada file
"
" Example: set shada=!,'0,<50,@100,:100,/100,%,s10,h
"          (saves everything except marks/jump locations)
set shada=
"^  super annoying, hence disable it all.

" VIMINFO: (Vim only, not used by Neovim) options - format: set viminfo=FLAGS
"   'N - Required: Save marks for the last N files (0 = disable marks)
"   !  - Save/restore global variables that start with uppercase and contain lowercase
"   <N - Save up to N lines for each register
"   @N - Save the last N registers
"   :N - Save the last N command-line history entries
"   /N - Save the last N search history entries
"   %N - Save/restore buffer list (N = number of buffers, 0 = disable)
"   sN - Only save items smaller than N KB
"   c  - Save encoding of the file
"   n  - Name of the viminfo file (default: ~/.viminfo)
"   r  - Removable media (comma-separated list of paths)
"   h  - Disable search highlighting when loading viminfo file
"   f1 - Store file marks (marks set in files)
"
" Example: set viminfo='100,<50,@100,:100,/100,%,s10,h,f1
"          (saves marks for 100 files, registers, history, buffer list, file marks)
set viminfo='100,f1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                         ADVANCED BUILT-IN SETTINGS                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set wildmenu
"set wildmode=longest:full,full
"Search Highlighting
set incsearch "Enable instant search Highlighting
set hlsearch " Enable Highlighting all matches

"Disable runtime matchit.vim (SLOW)
let g:loaded_matchit = 1

"Disable new line with comment
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

"<Buffer>
    "Change pwd/current-dir
    " set autochdir " Automatically change current directory
    set noautochdir " Dynamic cwd might messup after navigating to diff subfolders
    "autocmd BufEnter * cd %:p:h  "Auto change 'pwd' to current folder when enter a buffer
    set splitright  "Default split at right
    "set splitbelow  "Default split at right

"<Tag>
    set tags=./tags;,tags;./.git/tags;,../.git/tags


"IMPORTANT: FOR OPENNING LARGE FILE
let g:large_file_size = 10000000  "10MB
autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:large_file_size | set noswapfile | syntax clear | endif
autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) <= g:large_file_size | syntax clear | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          PERSISTENT FILE SETTINGS                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [  Backup Files  ]--------{
    set nobackup
    " set backup
    " set writebackup
    " " set backupcopy=yes  " Force backups to be copied from original, not renamed
    " " Create folder if not exists
    " set backupdir=~/do.not.move/vim_backup//
    " if !isdirectory(&backupdir)
    "    silent! call mkdir(&backupdir, 'p')
    " endif
" }


" [  Swap files  ]--------{
    set noswapfile  "Disable Swap files
    ""set swapfile  "Enable swap file
    "set directory=/tmp/vim_swap//    "set swp file directory.
    "" Create folder if not exists
    "if !isdirectory(&directory)
    "   silent! call mkdir(&directory, 'p')
    "endif
    "set updatecount=100     "save swp file every amount of characters
    "" ▼ update also check cursor-holds and other functions, bit expensive one.
    "set updatetime=100   "save swap file every amount of ms
" }


" [  Persistent undo  ]--------{
    if has("persistent_undo")
        set undofile "Save UNDO history to local files
        set undodir=~/do.not.move/undo//
        " Create folder if not exists
        if !isdirectory(&undodir)
           silent! call mkdir(&undodir, 'p')
        endif
    endif
" }

set history=1000


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    FOLD                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nofoldenable  "Cancel all folds when enter vim (faster)
set foldmethod=manual  "manual|syntax
autocmd BufEnter * set foldmethod=manual
" set foldlevelstart=99  "No folding on file open
" set foldlevel=1
" set foldclose=all  "Auto-close folding
" set foldnestmax=1
" set foldcolumn=0

" [Persistent Folding]
" augroup AutoSaveFolds
"   autocmd!
"   autocmd BufWinLeave * mkview 1
"   autocmd BufWinEnter * silent! loadview 1
" augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              OTHER SETTINGS                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [  Builtin Autocomplete (omnifunc) ] ----{
    "autocmd FileType python set omnifunc=python3complete#Complete
    "autocmd FileType python setl ofu=pythoncomplete#CompletePHP
    "autocmd FileType php setl ofu=phpcomplete#CompletePHP
    "autocmd FileType ruby,eruby setl ofu=rubycomplete#Complete
    "autocmd FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
    "autocmd FileType c setl ofu=ccomplete#CompleteCpp
    "autocmd FileType css setl ofu=csscomplete#CompleteCSS
" }



" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
