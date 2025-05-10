local wezterm = require("wezterm")

local weztermConfig = require("config")

weztermConfig.leader = { key = "a", mods = "ALT", timeout_milliseconds = 2000 }
weztermConfig.keys = {
	-- Show tab navigator.
	{ key = "t", mods = "LEADER", action = wezterm.action.ShowTabNavigator },

	-- Rename currently active tab
	{
		key = "e",
		mods = "LEADER",
		action = wezterm.action.PromptInputLine({
			description = "Enter new tab name",
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	-- Toggle tab bar
	{ key = '"', mods = "SHIFT|CTRL", action = wezterm.action.EmitEvent("toggle-tabbar") },

	-- Splits.
	{ key = "%", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = '"', mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- Resize pane.
	{ key = "LeftArrow", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
	{ key = "RightArrow", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
	{ key = "UpArrow", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
	{ key = "DownArrow", mods = "LEADER", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },

	-- Rotate panes.
	{ key = "r", mods = "LEADER", action = wezterm.action.RotatePanes("Clockwise") },

	-- Switching panes.
	{ key = "0", mods = "LEADER", action = wezterm.action.PaneSelect },
}
