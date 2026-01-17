--REF: https://github.com/hrsh7th/nvim-cmp

-- SUPPORTED SOURCES: https://github.com/topics/nvim-cmp

local cmp = require('cmp')

-- Setup nvim-cmp.
-- vim.opt.completeopt = 'menu,menuone,noinsert,noselect'
cmp.setup({
    completeopt = 'menu,menuone,noinsert,noselect',  -- Important! It's annoying to "pre-select" for you
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    -- Order matters: decides suggestion order
    -- Grouping matters: will only show 2nd group if 1st group has no result at all
    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp', priority = 1000 },  -- Any LSP installed by Mason will be used
            { name = 'ultisnips', priority = 900 },
            { name = 'buffer', priority = 500 },
            -- { name = 'cmdline', priority = 500 },  -- Buggy
            -- { name = 'omni', priority = 500 },  -- Vim native Omnifunc, slow
            -- { name = 'treesitter', priority = 600, keyword_length = 3 },  -- Buggy
            {
                -- `cmp-path` source is picky about path patterns, starts with `./` to trigger
                name = 'path', priority = 700, keyword_length = 2,
                option = {
                    trailing_slash = true,
                    label_trailing_slash = true,
                    get_cwd = function()
                        return vim.fn.getcwd()
                    end,
                }
            },
        },
        {
            -- { name = 'vsnip' }, -- For vsnip users.
            -- { name = 'luasnip' }, -- For luasnip users.
            -- { name = 'snippy' }, -- For snippy users.
        }
    ),
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = false}),
        ['<C-l>'] = cmp.mapping.complete(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Less used:
        -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- ['<C-e>'] = cmp.mapping.abort(),
        -- Disable: <Enter> or <Space> for candidate selection, conflict with enter for newline
        -- ['<CR>'] = cmp.mapping.confirm({ select = false }),
        -- ['<Space>'] = cmp.mapping.confirm({ select = false }),
    }),
})

-- Settings for <cmp-spell>
vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    -- "Works only for neovim 0.7+ -->
    -- mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' },
        { name = 'path' },
        { name = 'cmdline' },
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    -- "Works only for neovim 0.7+ -->
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
        {
            { name = 'path' },
            { name = 'cmdline' },
            { name = 'buffer' },
        },
        {
            -- { name = 'buffer' },
        }
    )
})

-- -- Setup lspconfig.
-- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- local lspc = require('lspconfig')
-- lspc['pylsp'].setup { capabilities = capabilities }
-- -- lspc['jedi_language_server'].setup { capabilities = capabilities }
-- lspc['vimls'].setup { capabilities = capabilities }
-- lspc['tsserver'].setup { capabilities = capabilities }

-- Dictionary
-- require("cmp_dictionary").setup({
--     dic = {
--         ["*"] = { "/usr/share/dict/words" },
--         -- ["lua"] = "path/to/lua.dic",
--         -- ["javascript,typescript"] = { "path/to/js.dic", "path/to/js2.dic" },
--         -- filename = {
--         --     ["xmake.lua"] = { "path/to/xmake.dic", "path/to/lua.dic" },
--         -- },
--         -- filepath = {
--         --     ["%.tmux.*%.conf"] = "path/to/tmux.dic"
--         -- },
--         -- spelllang = {
--         --     en = "path/to/english.dic",
--         -- },
--     },
--     -- The following are default values.
--     exact = 2,
--     first_case_insensitive = false,
--     document = false,
--     document_command = "wn %s -over",
--     async = false,
--     max_items = -1,
--     capacity = 5,
--     debug = false,
-- })
