-- :help ibl.config
require('ibl').setup({
    indent = {
        char = "▏",
        -- tab_char = { "a", "b", "c" },
        -- highlight = { "Function", "Label" },
        smart_indent_cap = true,
        priority = 2,
        repeat_linebreak = false,
    },
    whitespace = {
        remove_blankline_trail = false,
    },
    scope = { enabled = false },  -- highlight current scope
    -- show_trailing_blankline_indent = true,

    -- space_char_blankline = " ",
    -- show_current_context = true,
    -- show_current_context_start = true,
    -- char_highlight_list = {
    --     "IndentBlanklineIndent1",
    --     "IndentBlanklineIndent2",
    --     "IndentBlanklineIndent3",
    --     "IndentBlanklineIndent4",
    --     "IndentBlanklineIndent5",
    --     "IndentBlanklineIndent6",
    -- },
})

local hooks = require("ibl.hooks")
hooks.register(
    hooks.type.WHITESPACE,
    hooks.builtin.hide_first_space_indent_level
)
