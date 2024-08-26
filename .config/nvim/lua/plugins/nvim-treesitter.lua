-- Provides a simple and easy way to use the interface for Treesitter (used for parser generation
-- and an incremental parsing).
return {
	"nvim-treesitter/nvim-treesitter",
	opts = function(_, opts)
		if type(opts.ensure_installed) == "table" then
			require("nvim-treesitter").setup({
				ensure_installed = {
					"ron",
					"rust",
					"toml",

					"go",
					"gomod",
					"gowork",
					"gosum",

					"c",

					"lua",

					"typescript",
					"tsx",

					"terraform",
					"hcl",
					"yaml",
					"dockerfile",
					"json",
					"json5",
					"jsonc",
					"markdown",
					"markdown_inline",
					"vim",
					"vimdoc",
					"query",
					"norg",

					"nix",
				},
				highlight = { enable = true },
			})
		end
	end,
}
