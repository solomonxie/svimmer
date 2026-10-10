" --- NEOVIM PROVIDERS ---

":checkhealth provider


" Hosts are found on PATH ($ npm install -g neovim; $ pip install pynvim).
" Pin them per machine in ~/.vimrc-local.vim: g:python3_host_prog, g:node_host_prog

let g:loaded_python_provider = 0


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
