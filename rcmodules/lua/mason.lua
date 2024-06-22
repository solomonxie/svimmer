-- REF: https://github.com/williamboman/mason.nvim?tab=readme-ov-file
if not string.find(vim.o['runtimepath'], 'mason')  then
    return
end
    
require("mason").setup()
