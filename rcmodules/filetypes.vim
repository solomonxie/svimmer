" Custom filetype detection for extensions nvim doesn't know by default.

" Arduino sketches: map to cpp so clangd (already enabled) covers
" syntax/completion. Skips arduino-language-server/arduino-cli on purpose —
" heavier dependency than warranted here.
autocmd BufNewFile,BufRead *.ino set filetype=cpp
