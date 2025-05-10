return {
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
							smart_rename = "<leader>rf",
						},
					},
				},

				ensure_installed = {
					"gleam",
					"haskell",
					"odin",
					"nix",
					"cue",
					"http",
					"graphql",
					"hcl",
				},

				highlight = {
					enable = {},
				},
			})
		end,
	},
}
