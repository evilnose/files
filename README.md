# Do
Put .vimrc and init.lua in the neovim config directory. Has neovide config in init.lua as well.

# Prereqs
* Need to install `rg` for global search
* Need to install `clangd` for C++ lsp
* Don't use tree-sitter. It's too much work to set up for what it's worth. Wait for Neovim to officially support parsers

# Notes
* Neovide has some trouble with fullscreen on Mac. Can't toggle fullscreen either, except by clicking the top-left green button. Have to manually do this for now.
See https://github.com/neovide/neovide/issues/1675. Note that setting fullscreen in the config doesn't work either.
* Use the `svim` script to run neovide on a remote SSH nvim.
