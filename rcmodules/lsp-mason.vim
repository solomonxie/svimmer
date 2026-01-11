""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        MASON - MODERN LSP INSTALLER                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mason is alternative to `lspinstaller`, `npm`, `homebrew`...
" REF: https://github.com/williamboman/mason.nvim
" REF: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
" REF: https://github.com/mason-org/mason-lspconfig.nvim

Plug 'neovim/nvim-lspconfig', {'tag': 'v2.5.0'}
Plug 'mason-org/mason.nvim', {'tag': 'v2.2.1'}
Plug 'mason-org/mason-lspconfig.nvim', {'tag': 'v1.32.0'}  "Auto install/enable/configure multiple LSPs

" Predefined LSPs are defined in 'lsp-mason.lua'
let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/lsp-mason.lua']  "Pre-enabled LSPs defined here
"^^^^^^^^^ Current issue: I cannot do `require('pylsp').setup()` with mason, always saying the lsp model isn't loaded

" let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/lsp-python.lua']
" let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/lsp-sql.lua']
" let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/lsp-vim.lua']
" let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/lsp-lua.lua']
" let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/lsp-css.lua']
" let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/lsp-js.lua']
" let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/lsp-html.lua']
" luafile ~/myconf/dotfiles/vim/rcmodules/lua/lsp-ruby.lua


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
