"----------------------------------------------------
"            __     ___           ____   ____       -
"            \ \   / (_)_ __ ___ |  _ \ / ___|      -
"             \ \ / /| | '_ ` _ \| |_) | |          -
"              \ V / | | | | | | |  _ <| |___       -
"               \_/  |_|_| |_| |_|_| \_\\____|      -
"                                                   -
"----------------------------------------------------
"------Modularized Neovim Configuration File---------

" DEFINE AT TOP BEFORE PLUGINS REGISTER
let mapleader = ","
" let maplocalleader = ""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            INSTALL DEPENDENCIES                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" $ brew install ctags
" $ brew install --HEAD universal-ctags/universal-ctags/universal-ctags
" $ pip install pynvim neovim
" $ pip install python-lsp-server[all] pycodestyle
" $ pip install python-language-server
" $ pip install pyright  # requires npm install neovim typescript
" $ pip install pylint mypy
" $ pip install flake8==3.9.2  # 4.0 no longer respect user config file
" $ npm install -g neovim
" $ npm install -g vim-language-server
" $ npm install -g typescript typescript-language-server
" $ npm install -g bash-language-server
" For more missing dependencies:
" :checkhealth
" On MacOS, grand permission for entire Neovim program:
" $ sudo xattr -r -d com.apple.quarantine ~/nvim-macos-0.11.4/

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        VIM-PLUG MANAGER FOR PLUGINS                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://github.com/junegunn/vim-plug
" if !filereadable(expand('~/.vim/autoload/plug.vim'))
"     echo 'Downlading vim-plug manager...'
"     let url='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"     call system('curl -fLo ~/.vim/autoload/plug.vim --create-dirs ' . url)
"     echo 'Done.'
" endif

let g:lua_configs = []  "Append if a plugin module requires a Lua config after all plugins are loaded

call plug#begin('~/vim_plugged')
    "{Common}
        source ~/myconf/dotfiles/vim/rcmodules/perf_profiling.vim  "Performance Profiling tips
        source ~/myconf/dotfiles/vim/rcmodules/nvim_provider.vim  "Important
        source ~/myconf/dotfiles/vim/rcmodules/misc.vim
        source ~/myconf/dotfiles/vim/rcmodules/hop.vim
    "{UI}
        " source ~/myconf/dotfiles/vim/rcmodules/indent_line.vim  "BUGGY
        source ~/myconf/dotfiles/vim/rcmodules/blankline.vim  "INDENT-LINE
        " source ~/myconf/dotfiles/vim/rcmodules/airline.vim  "681ms+
        source ~/myconf/dotfiles/vim/rcmodules/buftabline.vim  "Blazing fast!
        source ~/myconf/dotfiles/vim/rcmodules/lightline.vim  "Blazing fast!
        " source ~/myconf/dotfiles/vim/rcmodules/statusline.vim
        source ~/myconf/dotfiles/vim/rcmodules/nerdtree.vim
        " source ~/myconf/dotfiles/vim/rcmodules/neotree.vim  "BUGGY!!! HEAVY
        source ~/myconf/dotfiles/vim/rcmodules/netrw.vim
        " source ~/myconf/dotfiles/vim/rcmodules/vinegar.vim
        " source ~/myconf/dotfiles/vim/rcmodules/chadtree.vim
        " source ~/myconf/dotfiles/vim/rcmodules/semshi.vim
        " source ~/myconf/dotfiles/vim/rcmodules/ctags.vim  "300ms+, 99% CPU
        source ~/myconf/dotfiles/vim/rcmodules/tagbar.vim  "300ms+
        " source ~/myconf/dotfiles/vim/rcmodules/vista.vim  "TAG BAR
        " source ~/myconf/dotfiles/vim/rcmodules/markbar.vim
        " source ~/myconf/dotfiles/vim/rcmodules/syntastic.vim
        " source ~/myconf/dotfiles/vim/rcmodules/telescope.vim  "SLOW
        " source ~/myconf/dotfiles/vim/rcmodules/which_key.vim
    "{Completion | Usages | Definitions}
        " source ~/myconf/dotfiles/vim/rcmodules/replace.vim
        source ~/myconf/dotfiles/vim/rcmodules/fzf.vim
        " source ~/myconf/dotfiles/vim/rcmodules/ale.vim  "Async linting
        " source ~/myconf/dotfiles/vim/rcmodules/deoplete.vim
        source ~/myconf/dotfiles/vim/rcmodules/ultisnips.vim
        source ~/myconf/dotfiles/vim/rcmodules/anyjump.vim
        " source ~/myconf/dotfiles/vim/rcmodules/YCM.vim
        " source ~/myconf/dotfiles/vim/rcmodules/coc.vim
        " source ~/myconf/dotfiles/vim/rcmodules/coq.vim
        " source ~/myconf/dotfiles/vim/rcmodules/ncm2.vim
        source ~/myconf/dotfiles/vim/rcmodules/autopairs.vim  "Brakets/Quotes
        " source ~/myconf/dotfiles/vim/rcmodules/treesitter.vim
    "{Language Servers - LSP}
        " LSP
        source ~/myconf/dotfiles/vim/rcmodules/lsp-mason.vim  "LSP Installer, all languages
        " source ~/myconf/dotfiles/vim/rcmodules/nvim_lsp_compl.vim
        " source ~/myconf/dotfiles/vim/rcmodules/nvim_compe.vim  "Deprecated
        source ~/myconf/dotfiles/vim/rcmodules/nvim_cmp.vim
        " source ~/myconf/dotfiles/vim/rcmodules/lspsaga.vim  "Buggy
    "{Git}
        source ~/myconf/dotfiles/vim/rcmodules/tig.vim
        " source ~/myconf/dotfiles/vim/rcmodules/fugitive.vim
        source ~/myconf/dotfiles/vim/rcmodules/gitgutter.vim  "50ms+
        " source ~/myconf/dotfiles/vim/rcmodules/gitsigns.vim  "BLAZING FAST: 0.2262ms
        " source ~/myconf/dotfiles/vim/rcmodules/blame.vim
    "{Python}
        " source ~/myconf/dotfiles/vim/rcmodules/jedi.vim
        " source ~/myconf/dotfiles/vim/rcmodules/ped.vim
    "{NodeJS}
        " source ~/myconf/dotfiles/vim/rcmodules/vimspector.vim
        " source ~/myconf/dotfiles/vim/rcmodules/nvim_dap.vim
    "{AI}
        source ~/myconf/dotfiles/vim/rcmodules/llm-copilot.vim
        " source ~/myconf/dotfiles/vim/rcmodules/llm-gen.vim  "For local LLMs (Ollama)
        " source ~/myconf/dotfiles/vim/rcmodules/llm-llm_nvim.vim  "Complex settings, buggy UI
        " source ~/myconf/dotfiles/vim/rcmodules/llm-chatgpt.vim  "Failed to setup, too many heavy deps caused many errors
        " source ~/myconf/dotfiles/vim/rcmodules/llm-gp.vim  "Ugly design, not easy to use
        " source ~/myconf/dotfiles/vim/rcmodules/llm-codecompanion.vim  "Not yet knowing how to autocomplete
    "{Misc}
        " source ~/myconf/dotfiles/vim/rcmodules/dadbod.vim  "DB client
call plug#end()


" Some plugins require env variables (vim/neovim does not take env from shell)
silent! source ~/.vimrc-env.vim


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"              NVIM LUA CONFIGS (MUST BE LOADED AFTER PLUGINS)               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LSPs:
luafile ~/myconf/dotfiles/vim/rcmodules/lua/lsp-python.lua
luafile ~/myconf/dotfiles/vim/rcmodules/lua/lsp-sql.lua
luafile ~/myconf/dotfiles/vim/rcmodules/lua/lsp-vim.lua
luafile ~/myconf/dotfiles/vim/rcmodules/lua/lsp-lua.lua
luafile ~/myconf/dotfiles/vim/rcmodules/lua/lsp-css.lua
luafile ~/myconf/dotfiles/vim/rcmodules/lua/lsp-js.lua
luafile ~/myconf/dotfiles/vim/rcmodules/lua/lsp-html.lua
luafile ~/myconf/dotfiles/vim/rcmodules/lua/lsp-cpp.lua
" luafile ~/myconf/dotfiles/vim/rcmodules/lua/lsp-ruby.lua
" Misc:
luafile ~/myconf/dotfiles/vim/rcmodules/lua/nvimrc-functions.lua

" Load other lua configs defined elsewhere
for path in g:lua_configs
    execute 'luafile ' . path
    echom 'Loaded Lua config: ' . path |redraw  "Redraw prevent echo popup message
endfor


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               IMPORT MODULES                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source ~/myconf/dotfiles/vim/vimrc-basic.vim
source ~/myconf/dotfiles/vim/vimrc-functions.vim
source ~/myconf/dotfiles/vim/vimrc-commands.vim
source ~/myconf/dotfiles/vim/vimrc-keymappings.vim
source ~/myconf/dotfiles/vim/vimrc-ui.vim

" POC:
luafile ~/myconf/dotfiles/vim/scripts/poc_marks.lua


"Local overrides if there's any
silent! source ~/.vimrc-local.vim
