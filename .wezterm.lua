local wezterm = require("wezterm")

local act = wezterm.action

local wezdir = os.getenv("HOME") .. "/.wezterm"

local config = {
	enable_tab_bar = false,
	default_prog = { "/opt/homebrew/bin/tmux", "new-session", "-A", "-s", "wez-main" },
	font_size = 16,
	color_scheme_dirs = { "$HOME/.config/wezterm/colors" },
	color_scheme = "Gruvbox Material (Gogh)",
	font = wezterm.font_with_fallback({
		"JetBrains Mono",
		{
			family = "Symbols Nerd Font Mono",
			scale = 0.75,
		},
	}),
	window_background_opacity = 1,
	window_decorations = "RESIZE",
	enable_wayland = false,
	exit_behavior = "Close",
	-- background = {
	-- 	{
	-- 		source = {
	-- 			Gradient = {
	-- 				orientation = "Horizontal",
	-- 				colors = {
	-- 					"#00000C",
	-- 					"#000026",
	-- 					"#00000C",
	-- 				},
	-- 				interpolation = "CatmullRom",
	-- 				blend = "Rgb",
	-- 				noise = 0,
	-- 			},
	-- 		},
	-- 		width = "100%",
	-- 		height = "100%",
	-- 		opacity = 0.95,
	-- 	},
	-- },
	window_frame = {
		font = wezterm.font({
			family = "Jetbrains Mono Nerd Font",
			weight = "Regular",
		}),
	},
	leader = {
		key = "a",
		mods = "CTRL|SHIFT",
		timeout_milliseconds = 2000,
	},
	keys = {
		{
			key = "Enter",
			mods = "CMD|SHIFT",
			action = act({ SendString = '\x01"' }),
		},
		{
			key = "Enter",
			mods = "CMD",
			action = act({ SendString = "\x01%" }),
		},
		{
			key = "w",
			mods = "CMD",
			action = act({ SendString = "\x01x" }),
		},
		{
			key = "t",
			mods = "CMD",
			action = act({ SendString = "\x01c" }),
		},
		{ key = "0", mods = "CMD", action = act({ SendString = "\x010" }) },
		{ key = "1", mods = "CMD", action = act({ SendString = "\x011" }) },
		{ key = "2", mods = "CMD", action = act({ SendString = "\x012" }) },
		{ key = "3", mods = "CMD", action = act({ SendString = "\x013" }) },
		{ key = "4", mods = "CMD", action = act({ SendString = "\x014" }) },
		{ key = "5", mods = "CMD", action = act({ SendString = "\x015" }) },
		{ key = "6", mods = "CMD", action = act({ SendString = "\x016" }) },
		{ key = "7", mods = "CMD", action = act({ SendString = "\x017" }) },
		{ key = "8", mods = "CMD", action = act({ SendString = "\x018" }) },
		{ key = "9", mods = "CMD", action = act({ SendString = "\x019" }) },
	},
}

config.color_scheme = "Gruvbox Material (Gogh)"

return config
