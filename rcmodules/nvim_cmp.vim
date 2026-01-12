"REF: https://github.com/hrsh7th/nvim-cmp
Plug 'hrsh7th/nvim-cmp', {'commit': '8c82d0b'}

"DEPs:
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-omni'
" Plug 'f3fora/cmp-spell'
" Plug 'dmitmel/cmp-cmdline-history'
" Plug 'quangnguyen30192/cmp-nvim-ultisnips'
" Plug 'uga-rosa/cmp-dictionary'

let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/nvim_cmp.lua']


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
