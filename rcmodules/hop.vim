"REF: https://github.com/phaazon/hop.nvim
Plug 'phaazon/hop.nvim'  "Motion movement (stopped maintenance)

let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/hop.lua']

nnoremap <Leader>l <cmd>HopLineStart<CR>
vnoremap <Leader>l <cmd>HopLineStart<CR>
