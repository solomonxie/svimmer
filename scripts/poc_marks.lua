-- Step1: UI/UX
-- User hit `m`, pops a bottom split window shows these options: (a) add mark, (d) delete mark, (l) list marks, (Enter) add annotation
-- (a) Add mark: show a list of existing marks, allow user to type a char to add/replace a mark at current location,
--               this is a trade-off of changing native behavior of `m{char}` to `ma{char}`, but I think it's more intuitive.
-- (d) Delete mark: show a list of existing marks, allow user to type a char to delete
-- (Enter) Add annotation: pop window is changed to an empty mutable buffer allow user to add annotation


-- Step2: Implement marks listing logic
-- When user hit (l) List marks: pop a bottom split window shows all marks in


-- Step3: Implement jump logic
-- User can navigate to a mark by selecting it in the list (press Enter), or typing


-- Step4: Implement persistent marks Saving logic
-- When user add/edit annotation, save the annotation to a file (default to `~/.config/nvim/marks_annotations.json`, but is configuerable)


-- Step5: Implement persistent marks Matching logic
-- When user open a file, load the marks annotations from the file, and use matchinmg algorithm to set the marks



-- Step1: UI/UX

local source_buf = nil
vim.cmd('nnoremap <Leader>m :lua openMarks()<CR>')

function openMarks()
    source_buf = vim.api.nvim_get_current_buf()
    local buf = setupQuickWindow()
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
    vim.cmd('setlocal readonly nomodifiable')
    vim.cmd('nnoremap <buffer> <silent> <nowait> a :lua addMark()<CR>')
    vim.cmd('nnoremap <buffer> <silent> <nowait> d :lua DelMark()<CR>')
    vim.cmd('nnoremap <buffer> <silent> <nowait> l :lua listMarks()<CR>')
    vim.cmd('nnoremap <buffer> <silent> <nowait> e :lua editAnnotation()<CR>')
end


function addMark()
    listMarks()
    local char = vim.fn.getcharstr()  -- Listen for a keypress
    print("Mark added: " .. char)
    vim.cmd('bwipeout!')
end

function DelMark()
    listMarks()
    local char = vim.fn.getcharstr()  -- Listen for a keypress
    print("Mark deleted: " .. char)
    vim.cmd('bwipeout!')
end

function listMarks()
    local buf = setupQuickWindow()
    local content_lines = {'Marks Viewer:', ''}
    local marks = getAllMarks()
    print('Total marks found: ', #marks)
    for _, meta in ipairs(marks) do
        print('Mark display: ', meta.display)
        table.insert(content_lines, meta.display)
    end
    table.insert(content_lines, '')
    table.insert(content_lines, 'Press `q` to close this window.')
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, content_lines)
    vim.cmd('setlocal readonly nomodifiable')
    vim.cmd('redraw')
end


function getAllMarks()
    if not source_buf then return {} end
    local filename = vim.api.nvim_buf_get_name(source_buf)
    print('Source buffer filename: ', filename)
    local marks = {}
    local local_marks = 'abcdefghijklmnopqrstuvwxyz'
    local global_marks = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    local mark_chars = local_marks..global_marks
    for i=1, #mark_chars do
        local c = mark_chars:sub(i,i)
        local linenum, column, scope
        if string.find(local_marks, c) ~= nil then
            scope = 'local'
            local mark = vim.api.nvim_buf_get_mark(source_buf, c)
            lnum, col = mark[1], mark[2] + 1 -- Convert col to 1-indexed
            -- print('Local: ', lnum, col, filename)
        elseif string.find(global_marks, c) ~= nil then
            scope = 'global'
            local mark = vim.fn.getpos("'" .. c)
            bufnum, lnum, col = mark[1], mark[2], mark[3]
            filename = vim.api.nvim_buf_get_name(bufnum) or '<BUFFER>'
            -- print('Global: ', bufnum, lnum, col, filename)
        end
        filename = vim.fn.fnamemodify(filename, ":.")
        if lnum ~= 0 and col ~= 0 then
            display_line = string.format("(%s) %s:%d:%d (%s)", c, filename, lnum, col, scope)
            print('Display Line: ', display_line)
            meta = {char=c, lnum=lnum, col=col, filename=filename, scope=scope, display=display_line}
            table.insert(marks, meta)
        end
    end
    return marks
end

function editAnnotation()
    local buf = setupQuickWindow()
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
        '-- Enter your annotation here.',
        'Press `<Ctrl-s>` to save and exit --',
    })
    vim.cmd('startinsert')
    vim.cmd('nmap <buffer> <silent> <nowait> <c-s> :lua saveAnnotation()<CR>')
    vim.cmd('imap <buffer> <silent> <nowait> <c-s> :lua saveAnnotation()<CR>')
    vim.cmd('vmap <buffer> <silent> <nowait> <c-s> :lua saveAnnotation()<CR>')
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
    vim.cmd('setlocal buftype=nofile bufhidden=wipe noswapfile nonumber norelativenumber nowrap nocursorline')
    return vim.api.nvim_get_current_buf()
end


-- local function perform_jump(item)
--     -- Close the marks window
--     vim.cmd('close')
    
--     -- Jump
--     if item.filename and item.filename ~= "" then
--         vim.cmd('edit ' .. vim.fn.fnameescape(item.filename))
--     elseif item.bufnr and item.bufnr > 0 then
--         -- Check if buffer is valid
--         if vim.api.nvim_buf_is_valid(item.bufnr) then
--             vim.cmd('buffer ' .. item.bufnr)
--         end
--     end
    
--     vim.api.nvim_win_set_cursor(0, {item.lnum, item.col})
--     vim.cmd('normal! zz')
-- end


print("poc_marks.lua loaded")
