-- POC namespace for extmarks
local ns_id = vim.api.nvim_create_namespace("poc_marks")

-- Table to store extmark IDs for easy reference
local marks = {}

-- 1. Add an extmark at current line
function AddMark()
  local bufnr = vim.api.nvim_get_current_buf()
  local row = vim.api.nvim_win_get_cursor(0)[1] - 1  -- 0-indexed
  local col = 0
  local mark_id = vim.api.nvim_buf_set_extmark(bufnr, ns_id, row, col, {})
  marks[mark_id] = {bufnr = bufnr}
  print("Added extmark id:", mark_id, "at line:", row+1)
end


function AddMarkBoth()
  local bufnr = vim.api.nvim_get_current_buf()
  local row = vim.api.nvim_win_get_cursor(0)[1] - 1
  local col = 0

  -- 1. Extmark
  local ns_id = vim.api.nvim_create_namespace("poc_marks")
  local mark_id = vim.api.nvim_buf_set_extmark(bufnr, ns_id, row, col, {})
  print("Extmark added, id:", mark_id)

  -- 2. Native mark (use a fixed mark, e.g., 'a')
  vim.api.nvim_buf_set_mark(bufnr, "a", row, col, {})
  print("Native mark 'a set at line", row+1, "'")
end

-- 2. Print all extmarks and their current line/content
function PrintMarks()
  local bufnr = vim.api.nvim_get_current_buf()
  local extmarks = vim.api.nvim_buf_get_extmarks(bufnr, ns_id, 0, -1, {})
  for _, mark in ipairs(extmarks) do
    local id, row, col = mark[1], mark[2], mark[3]
    local line = vim.api.nvim_buf_get_lines(bufnr, row, row+1, false)[1]
    print(string.format("id: %d, line#: %d, content: %s", id, row+1, line))
  end
end

-- 4. Add sign/highlight for all marks
function HighlightMarks()
  local bufnr = vim.api.nvim_get_current_buf()
  local extmarks = vim.api.nvim_buf_get_extmarks(bufnr, ns_id, 0, -1, {})
  for _, mark in ipairs(extmarks) do
    local row = mark[2]
    -- add a highlight
    vim.api.nvim_buf_add_highlight(bufnr, ns_id, "Visual", row, 0, -1)
    -- add a sign using virtual text (since native signs need sign defs)
    vim.api.nvim_buf_set_extmark(bufnr, ns_id, row, 0, {
      virt_text={{"← mark", "WarningMsg"}},
      virt_text_pos="overlay",
    })
  end
end
