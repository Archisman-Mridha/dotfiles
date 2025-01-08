-- Bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.o.cursorline = false

vim.opt.colorcolumn = "100"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

-- Use spaces for indenting in YAML files.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*.yaml*",
	callback = function()
		vim.opt_local.expandtab = true -- Use spaces instead of tabs
		vim.opt_local.softtabstop = 2 -- Backspace removes 2 spaces
	end,
})

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

-- Show italic comments.
-- vim.cmd([[
--         highlight Comment cterm=italic gui=italic
--       ]])
