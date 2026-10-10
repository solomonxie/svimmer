# svimmer

Neovim config: vim-plug plugins, LSP via Mason, and one `rcmodules/` file per plugin so each can be toggled from `nvimrc.vim`.

Links the repo to `~/.config/nvim`.

## Install

```sh
git clone https://github.com/solomonxie/svimmer.git ~/.dotfiles/svimmer
~/.dotfiles/svimmer/install.sh
```

Existing symlinks are replaced; real files at a target path are moved to `<path>.bak.<timestamp>`.



## Perfomrance

- `CursorHoldUpdate()` -> `vim-devicons`
- `gitgutter#process_buffer()` -> `gitgutter.vim`
- `<sid>ws_refresh()` -> `airline/extentions/whitespace.vim`
- `s:do_delayed_update()` -> `tagbar.vim`
- `s:AutoUpdate(fnamemodify(expand('<afile>'), ':p'), 0)` -> `tagbar.vim`
