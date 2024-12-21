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

vim.keymap.set("n", "<leader>fr", ":Neotree reveal<CR>", {})

require("neogit").setup({})

-- Configure lualine to evil mode.
require("config.lualine")

require("which-key").setup({
	preset = "modern",
})

-- Uses spaces for indenting in YAML files.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*.yaml*",
	callback = function()
		vim.opt_local.tabstop = 2 		 -- A tab is equal to 2 spaces

		vim.opt_local.expandtab = true -- Use spaces instead of tabs
		vim.opt_local.shiftwidth = 2 	 -- Set indentation width to 2 spaces

		vim.opt_local.softtabstop = 2  -- Backspace removes 2 spaces
	end,
})

-- For `no clipboard response from terminal` Neovim issue in an SSH session.
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = "osc52",
    ["*"] = "osc52",
  },
  paste = {
    ["+"] = "osc52",
    ["*"] = "osc52",
  },
}
