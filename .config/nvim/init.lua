-- Bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.colorcolumn = "100"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

vim.g.autoformat = false
vim.g.rust_recommended_style = false

-- Configure lualine to evil mode.
require("config.lualine")