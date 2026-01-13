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
    vim.cmd('botright 10 new') -- Create a new window, switch to new buf context
    local marks_buf = vim.api.nvim_get_current_buf()
    local content_lines = {
        'Marks Menu:',
        '',
        '(a) Add Mark',
        '(d) Delete Mark',
        '(l) List Marks',
        '(↵) Edit Annotation',
        '',
        "Press 'q' to close this window."
    }
    vim.api.nvim_buf_set_lines(marks_buf, 0, -1, false, content_lines)
    vim.api.nvim_buf_call(marks_buf, function()
        setupQuickWindow()
        vim.cmd('nnoremap <buffer> <silent> <nowait> a :lua addMark()<CR>')
        vim.cmd('nnoremap <buffer> <silent> <nowait> d :lua DelMark()<CR>')
        vim.cmd('nnoremap <buffer> <silent> <nowait> l :lua listMarks()<CR>')
        vim.cmd('nnoremap <buffer> <silent> <Enter> :lua editAnnotation()<CR>')
    end)
end
local main_buf = vim.api.nvim_get_current_buf()
vim.cmd('nnoremap <Leader>m :lua openMarks()<CR>')


function addMark()
    print('Add mark selected')
end

function DelMark()
    print('Mark deleted')
end

function listMarks()
    print('Listing marks!')
end

function editAnnotation()
    print('Editing annotation!')
    -- TODO: close current buffer and open a new buffer for annotation editing
    vim.cmd('close')
    vim.cmd('botright 10 new2')
    local annot_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_lines(annot_buf, 0, -1, false, {'-- Enter your annotation here. <Ctrl-s> to save and exit --'})
    vim.api.nvim_buf_call(annot_buf, function()
        vim.cmd('nmap <buffer> <silent> <nowait> <c-s> :lua saveAnnotation()<CR>')
        vim.cmd('imap <buffer> <silent> <nowait> <c-s> :lua saveAnnotation()<CR>')
        vim.cmd('vmap <buffer> <silent> <nowait> <c-s> :lua saveAnnotation()<CR>')
        -- vim.cmd('setlocal modifiable')
        -- vim.cmd('startinsert')
    end)
end

function saveAnnotation()
    -- Already in the annotation buffer context
    print('Annotation saved!')
    vim.cmd('bwipeout!')
    local all_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local content = table.concat(all_lines, "\n")
    listMarks()
end

function setupQuickWindow()
    -- Already in the new buffer context
    vim.opt_local.buftype = 'nofile'
    vim.cmd('mapclear <buffer>')
    vim.cmd('autocmd BufLeave,BufWinLeave,BufHidden <buffer> ++once  :bd!')
    vim.cmd('nnoremap <buffer> <silent> <nowait> q :bwipeout!<CR>')
    vim.cmd('setlocal buftype=nofile bufhidden=wipe noswapfile nonumber norelativenumber nowrap nocursorline nomodifiable readonly')
end
