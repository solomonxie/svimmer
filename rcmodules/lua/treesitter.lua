--REF: https://github.com/nvim-treesitter/nvim-treesitter
require('nvim-treesitter.configs').setup({
    -- UI
    highlight = {enable = true},

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

    -- (Playground removed as it is deprecated)
})

-- Syntax Highlights are handled in vim/vimrc-ui.vim