-- -- Check environment (Very fast, only check $PATH variable)
-- if vim.fn.executable('pylsp') ~= 1 then
--     print('LSP server not installed, please do $ pip install python-lsp-server[all]')
--     return
-- end

-- REF: https://github.com/python-lsp/python-lsp-server
vim.lsp.enable('pylsp')
vim.lsp.config('pylsp', {
    settings = {
        pylsp = {
            cmd = { "pylsp" },
            filetypes = {"python"},
            debounce = 100,
            single_file_support = true,
            skip_token_initialization=true,
            -- -- configurationSources = { "flake8" },  -- CONFLICT WITH pylsp.plugins.flake8.config
            init_options = { lint = false },
            plugins = {
                pylint =  { enabled = false, args = { "--rcfile", vim.fn.expand("~/.config/pylintrc") } },
                flake8 = { enabled = false, config = vim.fn.expand("~/.config/flake8")  },
                pylsp_mypy =  { enabled = false },
                mypy =  { enabled = false },
                pycodestyle =  { enabled = false },
                pyflakes =  { enabled = false },
                jedi_completion = { enabled = true, include_params = true },  -- Important for completion
            },
            -- ^ Have to specifically everything "enabled=false" otherwise enabled by default
        }
    }
})

print('Loaded Lua config: ' .. vim.fn.expand('<sfile>:t'))
