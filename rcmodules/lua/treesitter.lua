--REF: https://github.com/nvim-treesitter/nvim-treesitter
require('nvim-treesitter.configs').setup({

    -- Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj
            keymaps = {
                ["af"] = "@function.outer",  -- type `vaf` to select whole function
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",  -- type `vac` to select whole class
                ["ic"] = "@class.inner",
            },
        },
        move = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj
            set_jumps = true, -- add jumps to the jumplist (CTRL-O/I)
            goto_next_start = {
                ["]]"] = "@function.outer",
                ["]c"] = "@class.outer",
            },
            goto_next_end = {
                ["]["] = "@function.outer",
                ["]C"] = "@class.outer",
            },
            goto_previous_start = {
                ["[["] = "@function.outer",
                ["[c"] = "@class.outer",
            },
            goto_previous_end = {
                ["[]"] = "@function.outer",
                ["[C"] = "@class.outer",
            },
        }
    },


    -- Plug 'nvim-treesitter/playground'
    playground = {
        -- GENERAL
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        -- KEY
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
        },
        -- HIGHLIGHTING
        highlight = {
            -- `false` will disable the whole extension
            enable = true,
            -- list of language that will be disabled
            disable = { "c", "rust" },
            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },
    }
})
