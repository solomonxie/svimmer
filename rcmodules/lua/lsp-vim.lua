-- Setup:
--   $ npm install -g vim-language-server
--   $ npm i -g bash-language-server
--   $ npm install -g typescript typescript-language-server
--   $ pip install python-lsp-server

local on_attach = function(_, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

vim.lsp.config('vimls', {
    on_attach=on_attach,
    settings = {
        vimls = {
            cmd = {"vim-language-server", "--stdio"},
            filetypes = {"vim"},
            init_options = {
                diagnostic = {enable = true},
                indexes = {
                    count = 3,
                    gap = 100,
                    projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
                    runtimepath = true
                },
                iskeyword = "@,48-57,_,192-255,-#",
                runtimepath = "",
                suggest = {
                    fromRuntimepath = true,
                    fromVimruntime = true
                },
                vimruntime = ""
            }
        }
    }
})
