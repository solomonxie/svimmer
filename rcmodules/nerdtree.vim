" --- NERDTREE - FILE BROWSER ---

"LOAD SIGNIFICANTLY FASTER
"REF: https://github.com/preservim/nerdtree/issues/276
Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind', 'NERDTree'], 'commit': '690d061'}

" Plug 'scrooloose/nerdtree'  ", {'on': ['NERDTree', 'NERDTreeFind', 'NERDTreeToggle']}
" Plug 'jistr/vim-nerdtree-tabs'      " enhance nerdtree's tabs
" Plug 'ryanoasis/vim-devicons'       " add beautiful icons besides files
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  "Slow down vim significantly

">> Key Mappings
nnoremap <Leader>f :<C-U>call NerdTreeAtProjectRoot()<CR>
" nnoremap <Leader>F :NERDTreeFind<CR>zz
" nnoremap FF :NERDTree<CR>
nnoremap ff :<C-U>call NerdTreeFindOrRoot()<CR>zz

" Git root of the current file (symlinks resolved, so a symlinked checkout
" still matches the path NERDTreeFind resolves), else the cwd.
function! s:NerdTreeProjectRoot() abort
    let l:dir = empty(expand('%')) ? getcwd() : fnamemodify(resolve(expand('%:p')), ':h')
    let l:root = trim(system('git -C ' . shellescape(l:dir) . ' rev-parse --show-toplevel'))
    return v:shell_error == 0 && isdirectory(l:root) ? resolve(l:root) : resolve(getcwd())
endfunction

function! NerdTreeAtProjectRoot() abort
    exec 'NERDTree ' . fnameescape(s:NerdTreeProjectRoot())
endfunction

" Always rooted at the project root, then reveal the current file in it
function! NerdTreeFindOrRoot() abort
    let l:root = s:NerdTreeProjectRoot()
    " g:NERDTree is undefined until the lazy-loaded plugin's first command runs
    if !exists('g:NERDTree') || !g:NERDTree.ExistsForTab()
                \ || g:NERDTree.ForCurrentTab().root.path.str() !=# l:root
        let l:file = expand('%:p')
        exec 'NERDTree ' . fnameescape(l:root)
        if empty(l:file)
            return
        endif
        wincmd p
    elseif empty(expand('%'))
        NERDTreeFocus
        return
    endif
    NERDTreeFind
endfunction
" nnoremap <Leader>F :NERDTree %:p:h<CR>
" Add '%' for changing root accordingly
"nnoremap <Leader>f :NERDTree %:p:h<CR>
" nnoremap gd :NERDTreeFind<CR>zz
" nnoremap gD :NERDTree<CR>

">> UI settings
let NERDTreeQuitOnOpen=0   " Keep NERDTree open after opening a file
let NERDTreeMinimalUI=1    " Start NERDTree in minimal UI mode (No help lines)
let NERDTreeDirArrows=1    " Display arrows instead of ascii art in NERDTree
let NERDTreeHighlightCursorline = 1  "Conflict with other addon-plugins for nerdtree
"let NERDTreeChDirMode=2    " Change current working directory based on root directory in NERDTree
let g:NERDTreeHidden=1     " Don't show hidden files
let NERDTreeWinSize=40     " Initial NERDTree width
let NERDTreeAutoDeleteBuffer = 1  " Auto delete buffer deleted with NerdTree
"let NERDTreeShowBookmarks=0   " Show NERDTree bookmarks
let NERDTreeIgnore = ['\.pyc$', '\.swp', '\.swo', '__pycache__', 'node_modules']   " Hide temp files in NERDTree
"let g:NERDTreeShowLineNumbers=1  " Show Line Number

"let NERDTreeAutoCenter = 1  "Not working

" Open Nerdtree when there's no file opened
"autocmd vimenter * if !argc()|NERDTree|endif
" Or, auto-open Nerdtree
"autocmd vimenter * NERDTree
function NerdTreeCustom()
    echom "nerd"
    " Close NERDTree when there's no other windows
    if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree())
        q
    endif
    " Manually turn on syntax
    " syntax manual
    " set syntax=on
endfunction

autocmd FileType nerdtree call NerdTreeCustom()

" NERDTree caches its "previous buffer" number at open time and jumps back to
" it on quit. Netrw's own buffer wiping (bufhidden=wipe, CloseNetrw) can free
" that number out from under it, throwing E86. Guard with bufexists() first.
function! SafeNERDTreeQuit() abort
    if exists('b:NERDTree') && b:NERDTree.isWinTree()
                \ && b:NERDTree.previousBuf() !=# -1 && bufexists(b:NERDTree.previousBuf())
        exec 'buffer ' . b:NERDTree.previousBuf()
    elseif winnr('$') > 1
        call g:NERDTree.Close()
    else
        call nerdtree#echo('Cannot close last window')
    endif
endfunction
autocmd FileType nerdtree nnoremap <buffer> q :call SafeNERDTreeQuit()<CR>

" Dim the tree while another window has focus, so its cursorline doesn't
" compete with the file window's. NERDTree opens files under eventignore=all
" (no WinLeave/WinEnter), so sync on SafeState, which fires on every idle.
function! s:NerdTreeDimColors() abort
    highlight default NERDTreeDim ctermfg=241 ctermbg=232 guifg=#666462 guibg=#141413
    highlight default NERDTreeDimDirty ctermfg=64 ctermbg=232 guifg=#5f8700 guibg=#141413
    highlight default NERDTreeDimCursorLine ctermfg=NONE ctermbg=234 guibg=#1c1c1c
endfunction
call s:NerdTreeDimColors()
autocmd ColorScheme * call s:NerdTreeDimColors()

let s:nerdtree_dim_groups = ['Normal', 'NormalNC', 'EndOfBuffer', 'Directory',
            \ 'NERDTreeDir', 'NERDTreeUp', 'NERDTreeFile', 'NERDTreeCWD', 'NERDTreeExecFile',
            \ 'NERDTreeOpenable', 'NERDTreeClosable', 'NERDTreeDirSlash',
            \ 'NERDTreeLinkFile', 'NERDTreeLinkDir', 'NERDTreeLinkTarget']
let s:nerdtree_dim_hl = join(map(copy(s:nerdtree_dim_groups), 'v:val . ":NERDTreeDim"'), ',')
            \ . ',NERDTreeGitDirtyFile:NERDTreeDimDirty,NERDTreeGitDirtyDir:NERDTreeDimDirty'
            \ . ',CursorLine:NERDTreeDimCursorLine'

function! s:NerdTreeSyncDim() abort
    if !exists('g:NERDTree') || !g:NERDTree.IsOpen()
        return
    endif
    let l:treeWin = win_getid(g:NERDTree.GetWinNum())
    let l:wanted = l:treeWin ==# win_getid() ? '' : s:nerdtree_dim_hl
    if getwinvar(l:treeWin, '&winhighlight') !=# l:wanted
        call setwinvar(l:treeWin, '&winhighlight', l:wanted)
    endif
endfunction
if exists('##SafeState')
    autocmd SafeState * call s:NerdTreeSyncDim()
endif

" Pin the side tree to its window: = - :bn :bp would swap a file into it.
" Only for the side (tab) tree -- a window tree replaces itself by design.
function! s:PinNerdTreeWindow() abort
    if exists('b:NERDTree') && b:NERDTree.isTabTree()
        setlocal winfixbuf
        nnoremap <buffer> = <Nop>
        nnoremap <buffer> - <Nop>
    endif
endfunction
autocmd User NERDTreeInit call s:PinNerdTreeWindow()
" winfixbuf is window-local: reopening the tree (toggle, ,f) puts the existing
" buffer in a new window without NERDTreeInit, so re-pin it. Otherwise quickfix
" <CR> may pick the tree as the previous window and open the file there.
autocmd BufWinEnter NERD_tree_tab_* call s:PinNerdTreeWindow()

" Auto-refresh NERDTree root every second, replacing manual R press.
" Timer only runs while the NERDTree buffer is open.
let s:nerdtree_refresh_timer = -1

" A refresh re-reads the whole tree from disk (~600ms with ~1000 lines open),
" blocking j/k -- so hold it off while the cursor is moving in the tree.
let s:nerdtree_last_move = 0.0
autocmd CursorMoved NERD_tree_* let s:nerdtree_last_move = reltimefloat(reltime())

function! s:NerdTreeAutoRefresh(timer) abort
    if reltimefloat(reltime()) - s:nerdtree_last_move < 2
        return
    endif
    silent! NERDTreeRefreshRoot
    silent! call s:NerdTreeGitHighlight()
endfunction

" Highlight dirty files/folders in NERDTree. Base follows :ChangeGitDiffBase
" (g:gitgutter_diff_base), default HEAD. Git is re-queried at most every 3s.
" Own colors rather than Diff* links: badwolf's DiffChange is a near-invisible bg
function! s:NerdTreeGitHighlightColors() abort
    highlight default NERDTreeGitDirtyFile cterm=bold ctermfg=154 gui=bold guifg=#aeee00
    highlight default NERDTreeGitDirtyDir ctermfg=154 guifg=#aeee00
endfunction
call s:NerdTreeGitHighlightColors()
autocmd ColorScheme * call s:NerdTreeGitHighlightColors()
let s:git_dirty = {}
let s:git_dirty_key = ''
let s:git_dirty_at = 0.0

function! s:NerdTreeGitDirtySet(root) abort
    let l:base = get(g:, 'gitgutter_diff_base', '')
    let l:base = empty(l:base) ? 'HEAD' : l:base
    let l:key = a:root . '@' . l:base
    if l:key ==# s:git_dirty_key && reltimefloat(reltime()) - s:git_dirty_at < 3
        return s:git_dirty
    endif
    let s:git_dirty_key = l:key
    let s:git_dirty_at = reltimefloat(reltime())
    let s:git_dirty = {}
    " Paths relative to the tree root (not the git toplevel) so symlinked roots match
    let l:git = 'git -C ' . shellescape(a:root) . ' '
    call system(l:git . 'rev-parse --git-dir')
    if v:shell_error != 0
        return s:git_dirty
    endif
    let l:files = systemlist(l:git . 'diff --name-only --relative ' . shellescape(l:base))
                \ + systemlist(l:git . 'ls-files --others --exclude-standard')
    for l:rel in l:files
        let l:path = a:root . '/' . l:rel
        let s:git_dirty[l:path] = 'NERDTreeGitDirtyFile'
        let l:dir = fnamemodify(l:path, ':h')
        while len(l:dir) > len(a:root) && !has_key(s:git_dirty, l:dir)
            let s:git_dirty[l:dir] = 'NERDTreeGitDirtyDir'
            let l:dir = fnamemodify(l:dir, ':h')
        endwhile
    endfor
    return s:git_dirty
endfunction

function! s:NerdTreeGitHighlight() abort
    if !g:NERDTree.IsOpen()
        return
    endif
    let l:curWin = win_getid()
    noautocmd call win_gotoid(win_getid(g:NERDTree.GetWinNum()))
    let l:dirty = s:NerdTreeGitDirtySet(b:NERDTree.root.path.str())
    let l:positions = {'NERDTreeGitDirtyFile': [], 'NERDTreeGitDirtyDir': []}
    " Skip when neither the tree nor the git set changed since last time
    let l:sig = b:changedtick . '@' . s:git_dirty_at
    if get(b:, 'nerdtree_git_hl_sig', '') ==# l:sig
        noautocmd call win_gotoid(l:curWin)
        return
    endif
    let b:nerdtree_git_hl_sig = l:sig
    " One top-down pass tracking the dir at each indent level. ui.getPath()
    " walks upward per line, which is O(n^2) and froze big trees for seconds.
    let l:ui = b:NERDTree.ui
    let l:dirs = {}
    let l:root = substitute(b:NERDTree.root.path.str(), '/$', '', '')
    let l:rootLine = l:ui.getRootLineNum()
    for l:lnum in empty(l:dirty) ? [] : range(l:rootLine + 1, line('$'))
        let l:line = getline(l:lnum)
        let l:name = l:ui._stripMarkup(l:line)
        if empty(l:name)
            continue
        endif
        let l:indent = l:ui._indentLevelFor(l:line)
        let l:isDir = l:name =~# '/$'
        let l:name = substitute(l:name, '/$', '', '')
        let l:path = get(l:dirs, l:indent - 1, l:root) . '/' . l:name
        if l:isDir
            let l:dirs[l:indent] = l:path
        endif
        let l:group = get(l:dirty, l:path, '')
        if empty(l:group)
            continue
        endif
        " Highlight just the name, not the indent/arrow/icon
        let l:col = stridx(l:line, l:name)
        if l:col >= 0
            call add(l:positions[l:group], [l:lnum, l:col + 1, strlen(l:name)])
        endif
    endfor
    for l:m in getmatches()
        if l:m.group =~# '^NERDTreeGitDirty'
            call matchdelete(l:m.id)
        endif
    endfor
    for [l:group, l:pos] in items(l:positions)
        " Older vims accept at most 8 positions per matchaddpos() call
        for l:i in range(0, len(l:pos) - 1, 8)
            call matchaddpos(l:group, l:pos[l:i : l:i + 7])
        endfor
    endfor
    noautocmd call win_gotoid(l:curWin)
endfunction

function! s:StartNerdTreeAutoRefresh() abort
    if s:nerdtree_refresh_timer ==# -1
        let s:nerdtree_refresh_timer = timer_start(1000, function('s:NerdTreeAutoRefresh'), {'repeat': -1})
    endif
endfunction

function! s:StopNerdTreeAutoRefresh() abort
    if s:nerdtree_refresh_timer !=# -1
        call timer_stop(s:nerdtree_refresh_timer)
        let s:nerdtree_refresh_timer = -1
    endif
endfunction

if has('timers')
    autocmd FileType nerdtree call s:StartNerdTreeAutoRefresh()
    " BufWinLeave stops the timer, but reshowing the buffer doesn't re-fire FileType
    autocmd BufWinEnter NERD_tree_* call s:StartNerdTreeAutoRefresh()
    autocmd BufWinLeave NERD_tree_* call s:StopNerdTreeAutoRefresh()
endif
" Open/close re-renders the buffer and shifts lines; re-highlight right away
" instead of waiting for the next timer tick (git set is cached, so this is cheap)
autocmd TextChanged NERD_tree_* silent! call s:NerdTreeGitHighlight()
" :ChangeGitDiffBase (gitgutter.vim) -- drop the cached git set and repaint now
autocmd User GitDiffBaseChanged let s:git_dirty_key = '' | silent! call s:NerdTreeGitHighlight()


" Customize icons on Nerdtree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Git related
" Special characters
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
\ }


" --- Customized Abilities on Nerdtree ---
" call NERDTreeAddKeyMap({
"         \ 'key': 'E',
"         \ 'callback': 'MyNerdtreeFunc',
"         \ 'quickhelpText': 'put full path of current node into the default register' })
"
" function! MyNerdtreeFunc()
"     let n = g:NERDTreeFileNode.GetSelected()
"     if n != {}
"         call setreg('"', n.path.str())
"     endif
" endfunction



" --- Vim-Devicons - Icons for Nerdtree ---
"https://github.com/ryanoasis/vim-devicons/wiki/Extra-Configuration
if &runtimepath =~ 'vim-devicons'
    let g:webdevicons_enable = 1  "Enable plugin
    let g:webdevicons_enable_nerdtree = 1
    let g:webdevicons_enable_airline_tabline = 0
    let g:webdevicons_enable_airline_statusline = 0
    set guifont=DroidSansMono_Nerd_Font:h11
endif


" --- Nerdtree Syntax Highlight ---
"https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
if &runtimepath =~ 'nerdtree-syntax-highlight'
    let g:NERDTreeFileExtensionHighlightFullName = 1
    let g:NERDTreeExactMatchHighlightFullName = 1
    let g:NERDTreePatternMatchHighlightFullName = 1
    let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
    let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
    let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
    let g:NERDTreeLimitedSyntax = 1  "Disable uncommon file extensions highlighting
    " Disable
    " let g:NERDTreeDisableFileExtensionHighlight = 1
    " let g:NERDTreeDisableExactMatchHighlight = 1
    " let g:NERDTreeDisablePatternMatchHighlight = 1
endif


" ============= End of File ==================
" Follow the current buffer: reveal it in the open tree without taking focus.
" Only for files under the tree root, so the root never jumps. Opening from the
" tree itself runs under eventignore=all and is already highlighted anyway.
let s:nerdtree_revealing = 0
function! s:NerdTreeRevealCurrent() abort
    if s:nerdtree_revealing || !exists('g:NERDTree') || !g:NERDTree.IsOpen()
                \ || exists('b:NERDTree') || &buftype !=# '' || empty(expand('%'))
        return
    endif
    " Tree may still be initializing (BufEnter mid-creation): no root yet
    let l:tree = g:NERDTree.ForCurrentTab()
    if type(l:tree) != v:t_dict
        return
    endif
    let l:file = resolve(expand('%:p'))
    let l:root = substitute(resolve(l:tree.root.path.str()), '/$', '', '')
    if !filereadable(l:file) || stridx(l:file, l:root . '/') != 0
        return
    endif
    let s:nerdtree_revealing = 1
    let l:win = win_getid()
    try
        silent NERDTreeFind
    finally
        noautocmd call win_gotoid(l:win)
        let s:nerdtree_revealing = 0
    endtry
endfunction
autocmd BufEnter * call s:NerdTreeRevealCurrent()

" Only NERDTree left in the tab:
" - after :q/:wq/ZZ (QuitPre) -> quit nvim, as before the tree stayed open.
"   Unsaved hidden buffers block the quit; show one of them instead.
" - after :bdelete (,q), which closes every window showing the buffer -> keep
"   the tree and open an empty window beside it.
" Deferred because layout changes are not allowed mid-:quit/:bdelete.
let s:nerdtree_quit_requested = 0
autocmd QuitPre * let s:nerdtree_quit_requested = 1
" QuitPre also fires for :q on a split with other windows left; drop it once idle
if exists('##SafeState')
    autocmd SafeState * let s:nerdtree_quit_requested = 0
endif

function! s:NerdTreeKeepEditWindow(quit, ...) abort
    if winnr('$') != 1 || !exists('b:NERDTree') || !b:NERDTree.isTabTree()
        return
    endif
    if a:quit
        let l:modified = filter(range(1, bufnr('$')), 'buflisted(v:val) && getbufvar(v:val, "&modified")')
        if empty(l:modified)
            quit
            return
        endif
    endif
    rightbelow vnew
    wincmd p
    exec 'vertical resize ' . g:NERDTreeWinSize
    wincmd p
    if a:quit
        exec 'buffer ' . l:modified[0]
        echohl ErrorMsg | echo 'No write since last change' | echohl None
    endif
endfunction
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree')
            \ | call timer_start(0, function('s:NerdTreeKeepEditWindow', [s:nerdtree_quit_requested]))
            \ | let s:nerdtree_quit_requested = 0 | endif

echom 'Loaded ' . expand('<sfile>:t') |redraw
