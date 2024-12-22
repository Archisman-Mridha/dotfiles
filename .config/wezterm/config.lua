local wezterm = require("wezterm")

return {
	front_end = "WebGpu",
	max_fps = 240,

	font = wezterm.font({
		family = "MonacoLigaturized",
		stretch = "Expanded",
		weight = "Regular",
	}),
	font_size = 18.0,

	color_scheme = "GitHub Dark",

	underline_position = 0,
	underline_thickness = 2.5,

	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = false,
	show_new_tab_button_in_tab_bar = false,

	window_decorations = "RESIZE",
	window_padding = { top = 0, bottom = 0, left = 0, right = 0 },
	window_background_opacity = 0.75,
	macos_window_background_blur = 25,

	window_close_confirmation = "NeverPrompt",
}