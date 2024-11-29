local wezterm = require("wezterm")

local config = {
	front_end = "WebGpu",

	font = wezterm.font({
		family = "MonacoLigaturized",
		stretch = "Expanded",
		weight = "Regular",
	}),
	font_size = 18.0,

	color_scheme = "Github Dark",

	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	show_new_tab_button_in_tab_bar = false,

	window_padding = {
		top = 0,
		bottom = 0,
		left = 0,
		right = 0,
	},

	window_background_opacity = 0.75,
	macos_window_background_blur = 20,

	underline_position = 0,
	underline_thickness = 2.5,

	window_close_confirmation = "NeverPrompt",

	window_decorations = "RESIZE",

	keys = {
		{ key = "'", mods = "CTRL", action = wezterm.action.EmitEvent("toggle-tabbar") },
	},
}

wezterm.on("gui-startup", function()
	local tab, pane, window = wezterm.mux.spawn_window({})
	window:gui_window():maximize()
end)

wezterm.on("toggle-tabbar", function(window, _)
	local overrides = window:get_config_overrides() or {}
	if overrides.enable_tab_bar == false then
		wezterm.log_info("tab bar shown")
		overrides.enable_tab_bar = true
	else
		wezterm.log_info("tab bar hidden")
		overrides.enable_tab_bar = false
	end
	window:set_config_overrides(overrides)
end)

return config
