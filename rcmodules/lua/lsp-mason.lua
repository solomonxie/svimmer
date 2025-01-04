if not string.find(vim.o['runtimepath'], 'lspconfig') then
    return
end
local lspc = require 'lspconfig'

local my_lsp_servers = {
    'pylsp',
    'vimls',
    'html',
    'cssls',
    'ts_ls',
    'sqlls',
    'lua_ls'
}

require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = my_lsp_servers,
}
-- ^ IF GOT ERROR, run :MasonInstall <LSP_NAME> or :Mason then manually select lsp serers

-- Initially setup LSP servers
-- NOTE: Will not override existing setups, and can be overridden by later setups
for _, lsp in ipairs(my_lsp_servers) do
    if not lspc[lsp].manager then
        lspc[lsp].setup {}
    end
end
