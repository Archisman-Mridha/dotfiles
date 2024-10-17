-- Bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.o.cursorline = false

vim.opt.colorcolumn = "100"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

vim.opt.list = false

vim.g.autoformat = true

vim.lsp.inlay_hint.enable(false)

require("neogit").setup({})

-- Configure lualine to evil mode.
require("config.lualine")

vim.keymap.set("n", "<leader>fr", ":Neotree reveal<CR>", {})
