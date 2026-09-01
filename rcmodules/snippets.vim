" Custom minimal snippet engine over mysnippets/*.snippets, using Neovim's
" built-in vim.snippet (LSP snippet syntax). Replaces UltiSnips, which is
" disabled for now (see ultisnips.vim) — implementation in lua/snippets.lua.

let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/snippets.lua']


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
