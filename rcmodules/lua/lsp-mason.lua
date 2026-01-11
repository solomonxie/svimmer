-- REF: https://github.com/mason-org/mason-lspconfig.nvim

local my_lsp_servers = {
    'pylsp',
    'vimls',
    -- 'html',
    'cssls',
    'sqlls',
    'emmet_ls',
    'clangd',
    'lua_ls',
}

require('mason').setup({
    -- log_level = vim.log.levels.DEBUG,
})
require('mason-lspconfig').setup({
  ensure_installed = my_lsp_servers,
})
-- ^ IF GOT ERROR, run :MasonInstall <LSP_NAME> or :Mason then manually select lsp serers

-- Init LSP models
-- for _, lsp in ipairs(my_lsp_servers) do
--     print(lsp)
--     -- vim.lsp.config[lsp].setup({})
--     vim.lsp.enable(lsp)
-- end
