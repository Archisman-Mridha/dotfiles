-- Bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.cole = 0

vim.o.cursorline = false

vim.opt.colorcolumn = "100"

vim.opt.list = false

-- Enable format on save.
vim.g.autoformat = true

-- Disable inlay hints.
vim.lsp.inlay_hint.enable(false)

require("neogit").setup({})

require("which-key").setup({
  preset = "classic",
})

-- Configure lualine to evil mode.
require("config.lualine")

-- Fix indentation issue.
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.zig",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- Save folds across sessions.
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local save_fold = augroup("Persistent Folds", { clear = true })
autocmd("BufWinLeave", {
  pattern = "*.*",
  callback = function()
    vim.cmd.mkview()
  end,
  group = save_fold,
})
autocmd("BufWinEnter", {
  pattern = "*.*",
  callback = function()
    vim.cmd.loadview({ mods = { emsg_silent = true } })
  end,
  group = save_fold,
})

-- Use clangd binary specified using the CLANGD_PATH environment variable.
-- Otherwise, use the one added by default to PATH.
local lspconfig = require("lspconfig")
local clangd_path = os.getenv("CLANGD_PATH")
lspconfig.clangd.setup({
  cmd = clangd_path and { clangd_path, "--background-index" } or { "clangd", "--background-index" },
})

-- Wezterm doesn't allow querying clipboard when using OSC52.

vim.o.clipboard = "unnamedplus"

local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = paste,
    ["*"] = paste,
  },
}

-- Disable (semantic maybe) syntax highlighting
-- for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
--   vim.api.nvim_set_hl(0, group, {})
-- end

-- Disable Neovim from appending a new file at the end of version.txt file.
-- Otherwise, standard-version errors out.
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "version.txt",
  callback = function()
    vim.opt_local.eol = false
    vim.opt_local.fixeol = false
  end,
})

vim.filetype.add({
  filename = {
    ["Tiltfile"] = "tiltfile",
  },
})
