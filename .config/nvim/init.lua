-- Bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

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

-- For `no clipboard response from terminal` Neovim issue in an SSH session.
-- REFER : https://www.reddit.com/r/neovim/comments/1e9vllk/neovim_weird_issue_when_copypasting_using_osc_52/.

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
