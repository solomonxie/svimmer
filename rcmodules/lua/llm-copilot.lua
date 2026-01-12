require("CopilotChat").setup({
  debug = false,
})

print('Loaded Lua config: ' .. vim.fn.expand('<sfile>:t'))
