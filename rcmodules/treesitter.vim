""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     TREE SITTER - FOR BUILDING PLUGINS                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" REF: https://tree-sitter.github.io/tree-sitter/
" REF: https://github.com/nvim-treesitter/nvim-treesitter

" ACTIONS:
" 1. Download Nvim 0.5+ Release
" 2. :PlugInstall
" 3. :TSInstall python javascript bash json

Plug 'nvim-treesitter/nvim-treesitter', {'tag': 'v0.10.0'}
Plug 'nvim-treesitter/playground'

Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" NOTE: also check settings in `./vim/nvimrc.vim` to avoid conflicts
set foldmethod=expr
set foldexpr=v:lua.vim.treesitter.foldexpr()  "Do this if installed treesitter


" Post-Vimplug setup
let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/treesitter.lua']
