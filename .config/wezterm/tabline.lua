local wezterm = require("wezterm")

local weztermConfig = require("config")

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local tablineConfig = {
	options = {
		icons_enabled = true,
		theme = "Black Metal (base16)",
		color_overrides = {
			normal_mode = {
        a = { fg = "#181825", bg = "#89b4fa" },
        b = { fg = "#89b4fa", bg = "#313244" },
        c = { fg = "#cdd6f4", bg = "#000000" },
      },
      copy_mode = {
        a = { fg = "#181825", bg = "#f9e2af" },
        b = { fg = "#f9e2af", bg = "#313244" },
        c = { fg = "#cdd6f4", bg = "#181825" },
      },
      search_mode = {
        a = { fg = "#181825", bg = "#a6e3a1" },
        b = { fg = "#a6e3a1", bg = "#313244" },
        c = { fg = "#cdd6f4", bg = "#181825" },
      },

      -- Default tab colors
      tab = {
        active = { fg = "#89b4fa", bg = "#000000" },
        inactive = { fg = "#cdd6f4", bg = "#000000" },
        inactive_hover = { fg = "#f5c2e7", bg = "#000000" },
      },
		},

		section_separators = {
			left = wezterm.nerdfonts.ple_right_half_circle_thick,
			right = wezterm.nerdfonts.ple_left_half_circle_thick,
		},
		component_separators = {
			left = wezterm.nerdfonts.ple_right_half_circle_thick,
			right = wezterm.nerdfonts.ple_left_half_circle_thick,
		},
		tab_separators = {
			left = wezterm.nerdfonts.ple_right_half_circle_thick,
			right = wezterm.nerdfonts.ple_left_half_circle_thick,
		},
	},

	sections = {
		tabline_a = {{ "workspace", icon = wezterm.nerdfonts.oct_device_desktop }},
		tabline_b = {{
			"mode",
			-- REFER : https://github.com/michaelbrusegard/tabline.wez/issues/43#issuecomment-2462027573.
			fmt = function(mode, window)
				if window:leader_is_active() then
					return wezterm.nerdfonts.cod_circle_large
				else
					return mode
				end
			end,
		}},
		tabline_c = {},

		tab_active 	 = { { Attribute = { Italic = true } }, "index", { "tab", { max_length = 30 } } },
		tab_inactive = { "index" },

		tabline_x = {},
		tabline_y = {},
		tabline_z = {},
	},

	extensions = {
		"resurrect",
		"smart_workspace_switcher"
	},
}
tabline.setup(tablineConfig)

tabline.apply_to_config(weztermConfig)
