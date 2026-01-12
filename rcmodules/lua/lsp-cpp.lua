-- REF: https://clangd.llvm.org/installation
-- REF: https://github.com/clangd/clangd
if vim.fn.executable('clangd') ~= 1 then
    print('LSP server not installed, please do $ brew install llvm')
    return
end

vim.lsp.enable('clangd')
vim.lsp.config('clangd', {})

print('Loaded Lua config: C++')
