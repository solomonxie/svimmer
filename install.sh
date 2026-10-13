#!/usr/bin/env bash
# Symlink this repo into place. Existing symlinks are replaced; real files are moved to <path>.bak.<timestamp>.
set -euo pipefail
here=$(cd "$(dirname "$0")" && pwd)

link() {  # link <path in repo, empty = repo root> <dest>
  local src=$here${1:+/$1} dest=$2
  [ "$src" -ef "$dest" ] && return
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then mv "$dest" "$dest.bak.$(date +%Y%m%d%H%M%S)"; fi
  ln -sfn "$src" "$dest"
  echo "linked $dest -> $src"
}

# install.sh [nvim]  Neovim: the full config at ~/.config/nvim
# install.sh vim     Vim: ~/.vimrc -> vimrc-native.vim, standalone replica of nvimrc minus Neovim-only parts
# install.sh mini    plain Vim (e.g. a Linux server): ~/.vimrc -> vimrc-mini.vim, no plugins
case "${1:-nvim}" in
  nvim) link "" ~/.config/nvim ;;
  vim)  link vimrc-native.vim ~/.vimrc ;;
  mini) link vimrc-mini.vim ~/.vimrc ;;
  *) echo "usage: $0 [nvim|vim|mini]" >&2; exit 1 ;;
esac
