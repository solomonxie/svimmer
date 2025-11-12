local on_attach_general = function(_, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- REF: https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
-- $ pip install python-lsp-server[all]
-- $ pip install pycodestyle
-- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
-- if has_cmp_nvim_lsp then
--     -- vim.notify("Found cmp_nvim_lsp", vim.log.levels.INFO)
--     cmp_capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
--     cmp_capabilities.textDocument.completion.completionItem.snippetSupport = true
-- else
--     -- vim.notify("Not found cmp_nvim_lsp", vim.log.levels.INFO)
--     cmp_capabilities = nil
-- end

local conf_pylint_path = vim.fn.expand("~/.config/pylintrc")
local conf_falke8_path = vim.fn.expand("~/.config/flake8")

if not string.find(vim.o['runtimepath'], 'pylsp') then
    return
end
vim.lsp.config["pylsp"].setup{
    on_attach=on_attach_general,
    capabilities=cmp_capabilities,
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
                pylint =  { enabled = false, args = { "--rcfile", conf_pylint_path } },
                flake8 = { enabled = false, config = conf_falke8_path  },
                pylsp_mypy =  { enabled = false },
                mypy =  { enabled = false },
                pycodestyle =  { enabled = false },
                pyflakes =  { enabled = false },
                jedi_completion = { enabled = true, include_params = true },  -- Important for completion
            },
            -- ^ Have to specifically everything "enabled=false" otherwise enabled by default
        }
    }
}

-- -- REF: https://github.com/sourcery-ai/sourcery
-- vim.lsp.config["sourcery"].setup{
--     on_attach=on_attach_general,
-- }

-- -- REF: https://github.com/emanspeaks/pyls-flake8/
-- -- $ pip install pyls-flake8
-- vim.lsp.config["pylsp-flake8"].setup{  -- have to use this to cover another flake8 which I can't find where it is
--     on_attach=on_attach_general,
-- }

-- -- REF: https://github.com/pappasam/jedi-language-server
-- -- REF: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jedi_language_server
-- -- $ pip install jedi-language-server
-- vim.lsp.config["jedi_language_server"].setup{
--     on_attach=on_attach_general,
--     cmd = {"jedi-language-server"},
--     filetypes = {"python"},
--     single_file_support = true,
--     jediSettings = {
--         caseInsensitiveCompletion = true,
--     },
-- }

-- vim.lsp.config["pyright"].setup{
--     on_attach=on_attach_general,
--     cmd = { "pyright-langserver", "--stdio" },
--     filetypes = { "python" },
--     single_file_support = true,
--     settings = {
--         python = {
--             analysis = {
--                 autoSearchPaths = true,
--                 diagnosticMode = "workspace",
--                 useLibraryCodeForTypes = true
--             }
--         }
--     }
-- }

-- -- $ npm install -g diagnostic-languageserver
-- vim.lsp.config.diagnosticls.setup {
--     filetypes = { "python" },
--     init_options = {
--         filetypes = {
--             python = {"flake8"},
--         },
--         linters = {
--             flake8 = {
--                 debounce = 100,
--                 sourceName = "flake8",
--                 command = "flake8",
--                 args = {
--                     "--config",
--                     "~/.config/flake8",
--                     "--format",
--                     "%(row)d:%(col)d:%(code)s:%(code)s: %(text)s",
--                     "%file",
--                 },
--                 formatPattern = {
--                     "^(\\d+):(\\d+):(\\w+):(\\w).+: (.*)$",
--                     {
--                         line = 1,
--                         column = 2,
--                         message = {"[", 3, "] ", 5},
--                         security = 4
--                     }
--                 },
--                 securities = {
--                     E = "error",
--                     W = "warning",
--                     F = "info",
--                     B = "hint",
--                 },
--             },
--         },
--     }
-- }

-- -- REF: https://github.com/microsoft/pyright
-- -- REF: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright
-- -- $ npm -g install pyright
-- vim.lsp.config["pyright"].setup{
--     on_attach=on_attach_general,
--     cmd = {"pyright-python-langserver", "--stdio"},
--     filetypes = {"python"},
--     single_file_support = true,
--     -- root_dir = function(startpath)
--     --     return M.search_ancestors(startpath, matcher)
--     -- end,
--     settings = {
--       python = {
--         analysis = {
--           disableOrganizeImports = true,
--           disableLanguageServices = false,
--           autoSearchPaths = true,
--           autoImportCompletions = true,
--           autoSearchPaths = true,
--           typeCheckingMode = "off",  -- off|basic|strict
--           diagnosticMode = "workspace",  -- workspace | openFilesOnly
--           useLibraryCodeForTypes = true,
--         }
--       }
--     }
-- }
