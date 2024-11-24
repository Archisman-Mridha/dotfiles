return {
	"nvim-telescope/telescope.nvim",
	opts = function()
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })

		return {
			defaults = {
				layout_config = {
					width = function(_, cols, _)
						return math.floor(cols * 1)
					end,
					height = function(_, rows, _)
						return math.floor(rows * 1)
					end,
					horizontal = {
						preview_cutoff = 0,
					},
				},
			},
		}
	end,
}
