" REF: https://github.com/neovim/nvim-lspconfig
Plug 'neovim/nvim-lspconfig', {'tag': 'v2.5.0'}

" AVAILABLE LANGUAGE SERVERS:
" REF: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

" HELP: DEBUG WITH :LspLog or :LspInfo

" PREREQUISITE:
" INSTALLATION:
" pip install neovim
" pip install python-language-server
" pip install python-lsp-server
" npm install -g neovim
" npm install -g vim-language-server
" npm install -g typescript typescript-language-server
" npm install -g bash-language-server

" Important:
nnoremap <Leader>d :lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>r :lua vim.lsp.buf.rename('')<LEFT><LEFT>
vnoremap <Leader>r :lua vim.lsp.buf.rename('')<LEFT><LEFT>
nnoremap <Leader>u :lua vim.lsp.buf.references()<CR>
nnoremap <C-p> :lua vim.diagnostic.goto_prev()<CR>
nnoremap <C-n> :lua vim.diagnostic.goto_next()<CR>
nnoremap <Leader>a :lua vim.diagnostic.set_loclist()<CR>
nnoremap <Leader>x :lua vim.lsp.buf.formatting()<CR>
nnoremap K :lua vim.lsp.buf.hover()<CR>


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
