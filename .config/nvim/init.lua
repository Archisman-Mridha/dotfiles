-- Bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.colorcolumn = "100"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

vim.g.autoformat = true
vim.g.rust_recommended_style = false

require("config.auto-session")
require("neogit").setup {}

-- Configure lualine to evil mode.
require("config.lualine")

vim.cmd[[
  highlight NeoTreeGitConflict gui=bold
  highlight NeoTreeGitUntracked gui=none
  highlight NeoTreeRootName gui=bold
]]

vim.keymap.set('n', '<leader>fr', ':Neotree reveal<CR>', {})
