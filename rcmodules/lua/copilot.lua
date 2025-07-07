
if not string.find(vim.o['runtimepath'], 'copilot')  then
    return
end

if not string.find(vim.o['runtimepath'], 'CopilotChat')  then
    return
end
require("CopilotChat").setup({
  debug = false,
})
