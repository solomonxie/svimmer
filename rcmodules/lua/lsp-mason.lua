-- REF: https://github.com/mason-org/mason-lspconfig.nvim

local my_lsp_servers = {
    'pylsp',
    'vimls',
    'cssls',
    'sqlls',
    'emmet_ls',  --HTML
    'clangd',
    'lua_ls',
}

require('mason').setup({
    -- log_level = vim.log.levels.DEBUG,
})

require('mason-lspconfig').setup({
  ensure_installed = my_lsp_servers,
})
-- ^ IF GOT ERROR, run :MasonInstall <LSP_NAME> or :Mason
-- then manually select lsp serers

-- Init LSP models (we can still override each later)
for _, lsp in ipairs(my_lsp_servers) do
    vim.lsp.enable(lsp)  --New syntax after nvim v0.11
    vim.lsp.config(lsp, {})  --New syntax after nvim v0.11
end

print('Loaded Lua config: ' .. vim.fn.expand('<sfile>:t'))
