"REF: https://github.com/lukas-reineke/indent-blankline.nvim

Plug 'lukas-reineke/indent-blankline.nvim', {'commit': '005b560'}
" let g:indent_blankline_indent_level = 4
" let g:indentLine_enabled = v:false

" Post-Vimplug setup
let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/blankline.lua']


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
