"REF: https://github.com/phaazon/hop.nvim
Plug 'phaazon/hop.nvim', {'commit': '1a1ecea'}  "Motion movement (stopped maintenance)

let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/hop.lua']

nnoremap <Leader>l <cmd>HopLineStart<CR>
vnoremap <Leader>l <cmd>HopLineStart<CR>


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
