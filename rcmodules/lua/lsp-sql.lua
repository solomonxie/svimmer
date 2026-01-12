-- REF: https://github.com/joe-re/sql-language-server
-- Setup:
--   $ npm i -g sql-language-server
--   OR:
--   :MasonInstall sqlls

--
local on_attach = function(_, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

vim.lsp.config('sqlls', {
    on_attach=on_attach,
    cmd = { 'sql-language-server', 'up', '--method', 'stdio' },
    filetypes = { 'sql', 'mysql' },
    settings = {
    }
})

print('Loaded Lua config: ' .. vim.fn.expand('<sfile>:t'))
