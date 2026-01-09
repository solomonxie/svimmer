""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        MASON - MODERN LSP INSTALLER                        " """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mason is alternative to lspinstaller, npm, homebrew...
" REF: https://github.com/williamboman/mason.nvim
" REF: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Predefined LSPs are defined in 'lsp-mason.lua'
let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/lsp-mason.lua']  "Pre-enabled LSPs defined here
let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/lsp-python.lua']
let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/lsp-sql.lua']
let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/lsp-vim.lua']
let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/lsp-lua.lua']
let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/lsp-css.lua']
let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/lsp-js.lua']
let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/lsp-html.lua']
" luafile ~/myconf/dotfiles/vim/rcmodules/lua/lsp-ruby.lua
