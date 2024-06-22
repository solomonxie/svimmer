if not string.find(vim.o['runtimepath'], 'lspsaga')  then
    return
end

require('lspsaga').init_lsp_saga()
