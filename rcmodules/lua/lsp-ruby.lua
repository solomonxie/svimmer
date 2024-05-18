------------------------------------------------------------------------
--                           Solargraph LSP                           --
------------------------------------------------------------------------
-- -- REF: https://github.com/castwide/solargraph
-- -- Dependencies:
-- -- $ export PATH="$HOME/.rbenv/versions/3.3.0/bin:$PATH"
-- -- $ gem install phashion -v '1.2.0'
-- local lspc = require('lspconfig')
-- lspc["solargraph"].setup{
--   cmd = { 'solargraph', 'stdio' },
--   root_dir = lspc.util.root_pattern("Gemfile", ".git", "."),
--   settings = {
--     solargraph = {
--       autoformat = false,
--       formatting = false,
--       completion = true,
--       diagnostic = true,
--       folding = true,
--       references = true,
--       rename = true,
--       symbols = true
--     }
--   }
-- }


------------------------------------------------------------------------
--                          Shopify/ruby-lsp                          --
------------------------------------------------------------------------
-- REF: https://github.com/Shopify/ruby-lsp
-- Dependencies:
-- $ gem install ruby-lsp
local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')
local util = require('lspconfig.util')

if not configs.ruby_lsp then
    local enabled_features = {
        "documentHighlights",
        "documentSymbols",
        "foldingRanges",
        "selectionRanges",
        -- "semanticHighlighting",
        "formatting",
        "codeActions",
    }

    configs.ruby_lsp = {
        default_config = {
            cmd = { "bundle", "exec", "ruby-lsp" },
            filetypes = { "ruby" },
            root_dir = util.root_pattern("Gemfile", ".git"),
            init_options = {
                enabledFeatures = enabled_features,
            },
            settings = {},
        },
        commands = {
            FormatRuby = {
                function()
                    vim.lsp.buf.format({
                        name = "ruby_lsp",
                        async = true,
                    })
                end,
                description = "Format using ruby-lsp",
            },
        },
    }
end

lspconfig.ruby_lsp.setup({ on_attach = on_attach, capabilities = capabilities })
