------------------------------------------------------------------------
--                         NEOVIM UI SETTINGS                         --
------------------------------------------------------------------------

-- Change Linter result colors
vim.cmd [[
    highlight DiagnosticsError ctermfg=4 guifg=Red
    highlight DiagnosticsWarning ctermfg=4 guifg=Orange
    highlight DiagnosticsInformation ctermfg=4 guifg=Grey
    highlight DiagnosticsHint ctermfg=4 guifg=Grey

    highlight DiagnosticsVirtualTextError ctermfg=4 guifg=Red
    highlight DiagnosticsVirtualTextWarning ctermfg=4 guifg=Orange
    highlight DiagnosticsVirtualTextInformation ctermfg=4 guifg=Grey
    highlight DiagnosticsVirtualTextHint ctermfg=4 guifg=Grey
]]
local diagnostic_config = {
    virtual_text = {
        severity = {
            min = vim.diagnostic.severity.WARN,
        },
        source = "always",
        prefix = '●', -- Could be '■', '▎', 'x'
    },
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
}

vim.diagnostic.config(diagnostic_config)



-- ============= End of File ==================
print('Loaded ' .. vim.fn.expand('<sfile>:5'))
