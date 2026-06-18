-- Options are automatically loaded before lazy.nvim startup
--
-- Default options that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
--
-- Add any additional options here :

-- Neovim 0.11+ has built-in LSP configs that auto-start alongside LazyVim's,
-- causing duplicate clangd instances. Disable the built-in one.
vim.lsp.enable("clangd", false)
