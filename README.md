# vim-for-speed

Neovim config: vim-plug plugins, LSP via Mason, and one `rcmodules/` file per plugin so each can be toggled from `nvimrc.vim`.

Clone straight into `~/.config/nvim`. `install.sh` only matters if you clone it somewhere else; it then links the repo there.

## Install

```sh
git clone https://github.com/solomonxie/vim-for-speed.git ~/.config/nvim
~/.config/nvim/install.sh
```

Existing symlinks are replaced; real files at a target path are moved to `<path>.bak.<timestamp>`.

## Vim

`install.sh [nvim|vim|mini]`, default `nvim`:

- `nvim`: links the repo to `~/.config/nvim`.
- `vim`: links `~/.vimrc` to `vimrc-native.vim`: a standalone single-file replica of the Neovim config minus the Neovim-only parts (Lua, LSP, Treesitter, nvim-cmp). Fetches vim-plug itself; run `:PlugInstall` once.
- `mini`: links `~/.vimrc` to `vimrc-mini.vim`: self-contained, no plugins, for stock Vim on servers. Also works without the repo:

```sh
curl -fsSL https://raw.githubusercontent.com/solomonxie/vim-for-speed/master/vimrc-mini.vim -o ~/.vimrc
```

## Perfomrance

- `CursorHoldUpdate()` -> `vim-devicons`
- `gitgutter#process_buffer()` -> `gitgutter.vim`
- `<sid>ws_refresh()` -> `airline/extentions/whitespace.vim`
- `s:do_delayed_update()` -> `tagbar.vim`
- `s:AutoUpdate(fnamemodify(expand('<afile>'), ':p'), 0)` -> `tagbar.vim`
