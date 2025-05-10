vim.keymap.set("n", "<leader>zm", ":TZMinimalist<CR>", { desc = "Toggle minimalist mode" })

return {
	"Pocco81/true-zen.nvim",
	config = function()
		require("true-zen").setup({
			integrations = {
				tmux = true,
				lualine = true,
			},
		})
	end,
}
