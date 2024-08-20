local wezterm = require("wezterm")

-- local wsl_domains = wezterm.default_wsl_domains()

-- wezterm.on("gui-startup", function(cmd)
--     local _, _, window = wezterm.mux.spawn_window(cmd or {})
--     window:gui_window():toggle_fullscreen()
-- end)

-- for _, domain in ipairs(wsl_domains) do
--     domain.default_cwd = "~"
-- end
return {
	default_domain = "WSL:Ubuntu",
	default_prog = { "C:\\Program Files\\Git\\bin\\bash.exe --cd-to-home" },
	adjust_window_size_when_changing_font_size = false,
	audible_bell = "Disabled",
	background = {
		{
			source = { File = "C:\\Users\\nuq686\\backgrounds\\space-1.jpg" },
			hsb = { brightness = 0.4 },
			-- hsb = { brightness = 0.05 },
			opacity = 1,
		},
	},
	color_scheme = "Tokyo Night",
	disable_default_key_bindings = true,
	exit_behavior = "Close",
	font = wezterm.font_with_fallback({
		{
			family = "DroidSansM Nerd Font",
			weight = "Regular",
			stretch = "Normal",
			style = "Normal",
		},
		{ family = "3270 Nerd Font", scale = 1.0 },
	}),
	font_size = 14,
	force_reverse_video_cursor = true,
	hide_mouse_cursor_when_typing = true,
	hide_tab_bar_if_only_one_tab = true,
	keys = {
		{ action = wezterm.action.ActivateCommandPalette, mods = "CTRL|SHIFT", key = "P" },
		{ action = wezterm.action.CopyTo("Clipboard"), mods = "CTRL|SHIFT", key = "C" },
		{ action = wezterm.action.DecreaseFontSize, mods = "CTRL", key = "-" },
		{ action = wezterm.action.IncreaseFontSize, mods = "CTRL", key = "=" },
		{ action = wezterm.action.Nop, mods = "ALT", key = "Enter" },
		{ action = wezterm.action.PasteFrom("Clipboard"), mods = "CTRL|SHIFT", key = "V" },
		{ action = wezterm.action.ResetFontSize, mods = "CTRL", key = "0" },
		{ action = wezterm.action.ToggleFullScreen, key = "F11" },
	},
	scrollback_lines = 10000,
	show_update_window = true,
	use_dead_keys = false,
	unicode_version = 15,
	macos_window_background_blur = 100,
	window_close_confirmation = "NeverPrompt",
	window_padding = {
		left = 0,
		right = 0,
		top = "0.6cell",
		bottom = 0,
	},
	-- wsl_domains = wsl_domains,
	wezterm.on("user-var-changed", function(window, pane, name, value)
		local overrides = window:get_config_overrides() or {}
		if name == "ZEN_MODE" then
			local incremental = value:find("+")
			local number_value = tonumber(value)
			if incremental ~= nil then
				while number_value > 0 do
					window:perform_action(wezterm.action.IncreaseFontSize, pane)
					number_value = number_value - 1
				end
				overrides.enable_tab_bar = false
			elseif number_value < 0 then
				window:perform_action(wezterm.action.ResetFontSize, pane)
				overrides.font_size = nil
				overrides.enable_tab_bar = true
			else
				overrides.font_size = number_value
				overrides.enable_tab_bar = false
			end
		end
		window:set_config_overrides(overrides)
	end),
}
