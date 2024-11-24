vim.keymap.set("n", "<leader>zte", ":TwilightEnable<CR>", { desc = "Enable Twilight" })
vim.keymap.set("n", "<leader>ztd", ":TwilightDisable<CR>", { desc = "Disable Twilight" })
vim.keymap.set("n", "<leader>zm", ":TZMinimalist<CR>", { desc = "Toggle minimalist mode" })

return {
	{ "folke/twilight.nvim" },
	{
		"Pocco81/true-zen.nvim",
		config = function()
			require("true-zen").setup({
				integrations = { tmux = true, twilight = true, lualine = true },
			})
		end,
	},
}
