# Do
Put .vimrc and init.lua in the neovim config directory. Has neovide config in init.lua as well.

# Caution
Don't enable treesitter for C, lua, or .gitignore. C and lua tree-sitter integration comes with vim 8.0 so there'd be
conflict. .gitignore has some unknown problems I forgot.

# Prereqs
* Need to install `rg` for global search
* Need to install `clangd` for C++ lsp
* Need git installed for tree-sitter

# Notes
* Neovide has some trouble with fullscreen on Mac. Can't toggle fullscreen either, except by clicking the top-left green button. Have to manually do this for now.
See https://github.com/neovide/neovide/issues/1675. Note that setting fullscreen in the config doesn't work either.
* Use the `svim` script to run neovide on a remote SSH nvim.
