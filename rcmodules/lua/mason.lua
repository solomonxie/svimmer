-- REF: https://github.com/williamboman/mason.nvim?tab=readme-ov-file
if string.find(vim.o['runtimepath'], 'mason')  then
    require("mason").setup()
end
