local wezterm = require("wezterm")
local config = {}

wezterm.on("gui-startup", function(cmd)
	local _, _, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

config.font = wezterm.font("Iosevka")
config.font_size = 11
config.default_prog = { "/usr/bin/zsh" }
config.window_decorations = "RESIZE"
config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.7,
}
config.use_dead_keys = false
config.use_ime = false
config.scrollback_lines = 5000
config.adjust_window_size_when_changing_font_size = false
config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {
	font = wezterm.font({ family = "Noto Sans", weight = "Regular" }),
}

return config
