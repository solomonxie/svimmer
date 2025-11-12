if not string.find(vim.o['runtimepath'], 'cssls') then
    return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config['cssls'].setup {
  capabilities = capabilities,
}
