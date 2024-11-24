return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			enable = false,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-refactor",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				refactor = {
					smart_rename = {
						enable = true,
						keymaps = {
							smart_rename = "grr",
						},
					},
				},
			})
		end,
		opts = {
			ensure_installed = { "http", "graphql" },
		},
	},
}
