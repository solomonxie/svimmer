-- Minimal LSP-based tagbar: bottom bar, nested by real hierarchy (or by
-- containerName when a server only returns a flat symbol list), filtered
-- to the kinds below. No ctags, no plugin dependency.

local M = {}

local KIND_LABEL = {
    [5] = 'CLASS',
    [6] = 'METHOD',
    [9] = 'METHOD',  -- Constructor
    [12] = 'FUNC',
}

M.win, M.buf, M.src_win, M.src_buf = nil, nil, nil, nil

local function is_document_symbol(list)
    return list[1] and list[1].selectionRange ~= nil
end

-- SymbolInformation[] (flat, containerName-linked) -> tree via containerName
local function nest_by_container_name(list)
    local by_name, roots = {}, {}
    for _, s in ipairs(list) do
        s.children = {}
        by_name[s.name] = by_name[s.name] or s
    end
    for _, s in ipairs(list) do
        local parent = s.containerName and by_name[s.containerName]
        if parent and parent ~= s then
            table.insert(parent.children, s)
        else
            table.insert(roots, s)
        end
    end
    return roots
end

local function jump_pos(s)
    if s.selectionRange then
        return s.selectionRange.start
    end
    return s.location.range.start
end

local function build_lines(list, depth, lines, jumps)
    for _, s in ipairs(list) do
        local label = KIND_LABEL[s.kind]
        if label then
            table.insert(lines, string.rep('  ', depth) .. label .. ' ' .. s.name)
            table.insert(jumps, jump_pos(s))
        end
        if s.children and #s.children > 0 then
            -- kept nodes recurse one deeper only if this node itself was
            -- shown; filtered-out containers still walk their children at
            -- the same depth so a stray Function under an unlisted kind
            -- (e.g. Namespace) isn't lost.
            build_lines(s.children, label and (depth + 1) or depth, lines, jumps)
        end
    end
end

function M.close()
    if M.win and vim.api.nvim_win_is_valid(M.win) then
        vim.api.nvim_win_close(M.win, true)
    end
    M.win, M.buf = nil, nil
end

local function goto_jump()
    local jumps = vim.b[M.buf].jumps
    local pos = jumps[vim.api.nvim_win_get_cursor(0)[1]]
    if not pos then
        return
    end
    local src_win = M.src_win
    M.close()
    if src_win and vim.api.nvim_win_is_valid(src_win) then
        vim.api.nvim_set_current_win(src_win)
    end
    vim.api.nvim_win_set_cursor(0, { pos.line + 1, pos.character })
    vim.cmd('normal! zz')
end

local function render(result)
    if not (M.buf and vim.api.nvim_buf_is_valid(M.buf)) then
        return
    end
    local lines, jumps = {}, {}
    if not result or vim.tbl_isempty(result) then
        lines = { 'No symbols' }
    else
        local tree = is_document_symbol(result) and result or nest_by_container_name(result)
        build_lines(tree, 0, lines, jumps)
        if vim.tbl_isempty(lines) then
            lines = { 'No matching symbols' }
        end
    end
    vim.bo[M.buf].modifiable = true
    vim.api.nvim_buf_set_lines(M.buf, 0, -1, false, lines)
    vim.bo[M.buf].modifiable = false
    vim.b[M.buf].jumps = jumps
end

function M.refresh()
    if not (M.buf and M.src_buf and vim.api.nvim_buf_is_valid(M.src_buf)) then
        return
    end
    local params = { textDocument = vim.lsp.util.make_text_document_params(M.src_buf) }
    vim.lsp.buf_request(M.src_buf, 'textDocument/documentSymbol', params, function(err, result)
        if err then
            render(nil)
        else
            render(result)
        end
    end)
end

function M.open()
    M.src_win = vim.api.nvim_get_current_win()
    M.src_buf = vim.api.nvim_get_current_buf()

    vim.cmd('botright 10split')
    M.win = vim.api.nvim_get_current_win()
    M.buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(M.win, M.buf)

    vim.bo[M.buf].buftype = 'nofile'
    vim.bo[M.buf].bufhidden = 'wipe'
    vim.bo[M.buf].filetype = 'lsptagbar'
    vim.wo[M.win].number = false
    vim.wo[M.win].wrap = false

    local opts = { buffer = M.buf, silent = true }
    vim.keymap.set('n', '<CR>', goto_jump, opts)
    vim.keymap.set('n', 'q', M.close, opts)
    vim.keymap.set('n', '<Esc>', M.close, opts)

    M.refresh()
end

function M.toggle()
    if M.win and vim.api.nvim_win_is_valid(M.win) then
        M.close()
    else
        M.open()
    end
end

-- Slow LSP servers may still be attaching when the bar first opens.
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function()
        if M.win and vim.api.nvim_win_is_valid(M.win) then
            M.refresh()
        end
    end,
})

vim.keymap.set('n', 'ft', M.toggle, { silent = true })
