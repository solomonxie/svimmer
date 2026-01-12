-- REF: https://github.com/sumneko/lua-language-server
-- Setup:
--   $ brew install lua-language-server
--   OR:
--   :MasonInstall lua_ls
-- NOTE >>>>>> lua_ls IS SLOW, 20s+ TO LOAD, BE PATIENT...

-- if vim.fn.executable('lua-language-server') ~= 1 then
--     print('LSP server not installed, please do $ brew install lua-language-server')
--     return
-- end

local on_attach = function(_, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

vim.lsp.config('lua_ls', {
    on_attach=on_attach,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                -- path = runtime_path,
            },
            diagnostics = {
                globals = {'vim'},
                disable = { 'lowercase-global', 'unused-local', 'undefined-global' }
            },
            workspace = {
                library = {
                    -- Adjust the paths as needed
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
                maxPreload = 1000,
                preloadFileSize = 1000,
            },
            telemetry = {
                enable = false,
            },

        },
    }
})

print('Loaded Lua config: ' .. vim.fn.expand('<sfile>:t'))
