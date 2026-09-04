" Syntax for the nvim-lsp-tagbar buffer (filetype 'lsptagbar').
" Labels match KIND_LABEL in rcmodules/lua/nvim-lsp-tagbar.lua.

if exists('b:current_syntax')
  finish
endif

syntax match lsptagbarClass  "\<CLASS\>"
syntax match lsptagbarMethod "\<METHOD\>"
syntax match lsptagbarFunc   "\<FUNC\>"
syntax match lsptagbarConst  "\<CONST\>"
syntax match lsptagbarStruct "\<STRUCT\>"

highlight default link lsptagbarClass  Type
highlight default link lsptagbarMethod Function
highlight default link lsptagbarFunc   Function
highlight default link lsptagbarConst  Constant
highlight default link lsptagbarStruct Structure

let b:current_syntax = 'lsptagbar'
