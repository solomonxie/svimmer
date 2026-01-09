" Instructions: https://github.com/github/copilot.vim
" Authentication: do ":Copilot setup" then follow instructions to jump to browser
" Verify: $ cat ~/.config/github-copilot/apps.json

Plug 'github/copilot.vim'

" Set keymap for accept copilot suggestion
" nnoremap <silent> <C-l> <Plug>(copilot-accept)

" let g:copilot_no_tab_map = 1  "Disable default tab mapping
" imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")

" let g:copilot_enabled = 0  "Disable by default, do `:Copilot enable` to use

Plug 'CopilotC-Nvim/CopilotChat.nvim', {'branch': 'main'}  "Require nvim>0.10
