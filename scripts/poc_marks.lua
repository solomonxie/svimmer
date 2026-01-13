-- Define the list of marks to check
local local_marks = {
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
}
local global_marks = {
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
}
local other_marks = {
    --"'", '"', '^', '.', '[', ']', '<', '>', '`'
}


-- Step1: UI/UX
-- User hit `m`, pops a bottom split window shows these options: (a) add mark, (d) delete mark, (l) list marks, (Enter) add annotation
-- (a) Add mark: show a list of existing marks, allow user to type a char to add/replace a mark at current location,
--               this is a trade-off of changing native behavior of `m{char}` to `ma{char}`, but I think it's more intuitive.
-- (d) Delete mark: show a list of existing marks, allow user to type a char to delete
-- (Enter) Add annotation: pop window is changed to an empty mutable buffer allow user to add annotation


-- Step2: Implement Annotation saving logic
-- When user add/edit annotation, save the annotation to a file (default to `~/.config/nvim/marks_annotations.json`, but is configuerable)


-- Step3: Implement marks listing logic
-- When user hit (l) List marks: pop a bottom split window shows all marks in


-- Step4: Implement jump logic
-- User can navigate to a mark by selecting it in the list (press Enter), or typing


-- Step5: Implement persistent marks matching logic
-- When user open a file, load the marks annotations from the file, and use matchinmg algorithm to set the marks



-- Step1: UI/UX

function openMarks()
    local buf = setupQuickWindow()
    vim.cmd('setlocal modifiable noreadonly')
    local content_lines = {
        'Marks Menu:',
        '',
        '(a) Add Mark',
        '(d) Delete Mark',
        '(l) List Marks',
        '(e) Edit Annotation',
        '',
        "Press 'q' to close this window."
    }
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, content_lines)
    vim.cmd('nnoremap <buffer> <silent> <nowait> a :lua addMark()<CR>')
    vim.cmd('nnoremap <buffer> <silent> <nowait> d :lua DelMark()<CR>')
    vim.cmd('nnoremap <buffer> <silent> <nowait> l :lua listMarks()<CR>')
    vim.cmd('nnoremap <buffer> <silent> <nowait> e :lua editAnnotation()<CR>')
end
local main_buf = vim.api.nvim_get_current_buf()
vim.cmd('nnoremap <Leader>m :lua openMarks()<CR>')


function addMark()
    listMarks()
    local char = vim.fn.getcharstr()  -- Listen for a keypress
    print("Mark added: " .. char)
end

function DelMark()
    listMarks()
    local char = vim.fn.getcharstr()  -- Listen for a keypress
    print("Mark deleted: " .. char)
end

function listMarks()
    local buf = setupQuickWindow()
    vim.cmd('setlocal modifiable noreadonly')
    local content_lines = {
        'Marks Viewer:',
        '',
        '(a) abc | poc_marks.lua:10',
        '(b) def | poc_marks.lua:50',
        '(D) xyz | nvim_cmp.lua:23',
        '(X) haha | vim-profiler.py:100',
        '',
        "Press 'q' to close this window."
    }
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, content_lines)
end

function editAnnotation()
    local buf = setupQuickWindow()
    vim.cmd('setlocal modifiable noreadonly')
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {'-- Enter your annotation here. <Ctrl-s> to save and exit --'})
    vim.keymap.set({'n', 'i', 'v'}, '<C-s>', saveAnnotation, {
        buffer = true,
        silent = true,
        nowait = true,
        desc = "Save annotation"
    })
end

function saveAnnotation()
    -- Already in the annotation buffer context
    local all_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local text = table.concat(all_lines, "\n")
    print('Annotation saved: \n' .. text)
    listMarks()
end

function setupQuickWindow()
    if vim.b.mark_quick_window == true then vim.cmd('bwipeout!') end  -- Close existing quick window
    vim.cmd('botright 10 new')  -- Create new window and jump to the buffer context
    vim.b.mark_quick_window = true
    vim.opt_local.buftype = 'nofile'
    vim.cmd('mapclear <buffer>')
    vim.cmd('autocmd BufLeave,BufWinLeave,BufHidden <buffer> ++once  :bd!')
    vim.cmd('nnoremap <buffer> <silent> <nowait> q :bwipeout!<CR>')
    vim.cmd('setlocal buftype=nofile bufhidden=wipe noswapfile nonumber norelativenumber nowrap nocursorline nomodifiable readonly')
    return vim.api.nvim_get_current_buf()
end
