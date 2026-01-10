" Instructions: https://github.com/github/copilot.vim
" Authentication: do ":Copilot setup" then follow instructions to jump to browser
" Verify: $ cat ~/.config/github-copilot/apps.json
Plug 'github/copilot.vim', {'commit': 'a12fd56'}

" Set keymap for accept copilot suggestion
" nnoremap <silent> <C-l> <Plug>(copilot-accept)

" let g:copilot_no_tab_map = 1  "Disable default tab mapping
" imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")

" let g:copilot_enabled = 0  "Disable by default, do `:Copilot enable` to use

"REF: https://github.com/CopilotC-Nvim/CopilotChat.nvim
Plug 'CopilotC-Nvim/CopilotChat.nvim', {'commit': '21bdecb'}  "Require nvim>0.10


" Post-Vimplug setup
let g:lua_configs += ['~/myconf/dotfiles/vim/rcmodules/lua/llm-copilot.lua']


" ============= End of File ==================
echom 'Loaded ' . expand('<sfile>:t') |redraw
