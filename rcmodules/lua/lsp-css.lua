if not string.find(vim.o['runtimepath'], 'lspconfig') then
    return
end
local lspc = require "lspconfig"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspc['cssls'].setup {
  capabilities = capabilities,
}
