local wezterm = require("wezterm")

-- REFER : https://github.com/wez/wezterm/issues/284#issuecomment-1239337823
wezterm.on("gui-startup", function()
	local tab, pane, window = wezterm.mux.spawn_window({})
	window:gui_window():maximize()
end)

-- REFER : https://github.com/wez/wezterm/issues/4625#issuecomment-1948077841
wezterm.on("toggle-tabbar", function(window, _)
	local overrides = window:get_config_overrides() or {}
	if overrides.enable_tab_bar == false then
		overrides.enable_tab_bar = true
	else
		overrides.enable_tab_bar = false
	end
	window:set_config_overrides(overrides)
end)
