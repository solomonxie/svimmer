if not string.find(vim.o['runtimepath'], 'sqlls') then
    return
end
local on_attach = function(_, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end


-- REF: https://github.com/joe-re/sql-language-server
-- $ npm i -g sql-language-server
-- OR:
-- :MasonInstall sqlls
vim.lsp.config['sqlls'].setup{
    on_attach=on_attach,
    cmd = { 'sql-language-server', 'up', '--method', 'stdio' },
    filetypes = { 'sql', 'mysql' },
    settings = {
    }
}
