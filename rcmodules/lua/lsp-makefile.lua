-- REF: https://github.com/Freed-Wu/autotools-language-server
-- Goto Definition, Find References, Diagnostics, Hover, Completion for
-- Makefile / Makefile.am / configure.ac. Not in Mason: pip install it into
-- any venv on PATH.

vim.lsp.config('autotools_ls', {
  cmd = { 'autotools-language-server' },
  filetypes = { 'make', 'automake', 'config' },
  root_markers = { 'Makefile', 'configure.ac', '.git' },
})
vim.lsp.enable('autotools_ls')
