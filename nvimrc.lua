--REF: https://github.com/nanotee/nvim-lua-guide
--REF: https://github.com/wbthomason/packer.nvim

local fn = vim.fn
-- local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
-- if fn.empty(fn.glob(install_path)) > 0 then
--   packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
-- end

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'ap/vim-buftabline'

    -- luafile "~/.config/nvim/luamodule/perf_profiling.lua"
    -- luafile "~/.config/nvim/luamodule/nvim_provider.lua"
    -- luafile "~/.config/nvim/luamodule/basic.lua"
    -- luafile "~/.config/nvim/luamodule/hop.lua"
    -- luafile "~/.config/nvim/luamodule/indent_line.lua"
    -- luafile "~/.config/nvim/luamodule/buftabline.lua"
    -- luafile "~/.config/nvim/luamodule/lightline.lua"
    -- luafile "~/.config/nvim/luamodule/nerdtree.lua"
    -- luafile "~/.config/nvim/luamodule/netrw.lua"
    -- luafile "~/.config/nvim/luamodule/semshi.lua"
    -- luafile "~/.config/nvim/luamodule/tagbar.lua"
    -- luafile "~/.config/nvim/luamodule/fzf.lua"
    -- luafile "~/.config/nvim/luamodule/ultisnips.lua"
    -- luafile "~/.config/nvim/luamodule/anyjump.lua"
    -- luafile "~/.config/nvim/luamodule/autopairs.lua"
    -- luafile "~/.config/nvim/luamodule/nvim_lspconfig.lua"
    -- luafile "~/.config/nvim/luamodule/nvim_compe.lua"
    -- luafile "~/.config/nvim/luamodule/tig.lua"
    -- luafile "~/.config/nvim/luamodule/gitgutter.lua"
    -- luafile "~/.config/nvim/luamodule/blame.lua"

    -- BUILT-IN SETTINGS
    vim.cmd('source ~/.config/nvim/vimrc-functions.vim')
    vim.cmd('source ~/.config/nvim/vimrc-commands.vim')
    vim.cmd('source ~/.config/nvim/vimrc-keymappings.vim')
    vim.cmd('source ~/.config/nvim/vimrc-ui.vim')

    --------------------------------------------------------------------
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
    --------------------------------------------------------------------
end)
