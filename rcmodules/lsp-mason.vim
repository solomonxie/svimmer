""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        MASON - MODERN LSP INSTALLER                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mason is alternative to `lspinstaller`, `npm`, `homebrew`...
" REF: https://github.com/williamboman/mason.nvim
" REF: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
" REF: https://github.com/mason-org/mason-lspconfig.nvim

"NOTE: This plugin only manages installation (including virtual env of each package)
"NOTE: but it does not care about configurations of each LLP

Plug 'neovim/nvim-lspconfig', {'tag': 'v2.5.0'}
Plug 'mason-org/mason.nvim', {'tag': 'v2.2.1'}
Plug 'mason-org/mason-lspconfig.nvim', {'tag': 'v1.32.0'}  "Auto install/enable/configure multiple LSPs

" All pre-enabled LSPs are defined here:
let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/lsp-mason.lua']


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t')
