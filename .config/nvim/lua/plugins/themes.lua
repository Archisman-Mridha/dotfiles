return {
	-- Color scheme.
	{
		"LazyVim/LazyVim",
		opts = {
			-- colorscheme = "catppuccin-mocha",
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		enabled = false,
		config = function()
			require("catppuccin").setup({
				styles = {
					comments = { "italic" },
				},
			})

			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	{
		"sainnhe/sonokai",
		lazy = false,
		priority = 1000,
		enabled = false,
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.sonokai_enable_italic = true
			vim.g.sonokai_transparent_background = "2"
			vim.cmd.colorscheme("sonokai")
		end,
	},
	{
		"folke/tokyonight.nvim",
		enabled = true,
		opts = {
			--- You can override specific color groups to use other groups or a hex color
			--- function will be called with a ColorScheme table
			---@param colors ColorScheme
			on_colors = function(colors)
				colors.bg = "#000000"
			end,

			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",

				comments = { italic = false },
				keywords = { italic = false },
			},
			on_highlights = function(hl, c)
				hl.Comment = { fg = "#928374", italic = false } -- Customize comment color
			end,
		},
	},

	-- File icon theme
	{ "echasnovski/mini.icons", enabled = false },
	{
		"nvim-tree/nvim-web-devicons",
		enabled = true,
		opts = function()
			return {
				override = {
					rs = {
						icon = "🦀",
					},

					cue = {
						icon = "🐚",
					},
				},
			}
		end,
	},
}
