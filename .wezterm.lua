local wezterm = require("wezterm")

local act = wezterm.action

local wezdir = os.getenv("HOME") .. "/.wezterm"

local config = {
	enable_tab_bar = false,
	default_prog = { "/opt/homebrew/bin/tmux", "new-session", "-A", "-s", "wez-main" },
	font_size = 16,
	color_scheme_dirs = { "~/.config/wezterm/colors" },
	color_scheme = "Gruvbox dark, hard (base16)",
	-- color_scheme = "Poimandres",
	font = wezterm.font_with_fallback({
		"BerkeleyMonoVariable Nerd Font",
		{
			family = "Symbols Nerd Font Mono",
			scale = 0.75,
		},
	}),
	window_background_opacity = 1,
	window_decorations = "RESIZE",
	enable_wayland = false,
	exit_behavior = "Close",
	hyperlink_rules = {
		{ regex = [[\b\w+://[\w.-]+\.[a-z]{2,15}\S*\b]], format = "$0" },
		-- Email addresses:
		{ regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]], format = "mailto:$0" },
		-- file:// URI
		{ regex = [[\bfile://\S*\b]], format = "$0" },
		-- URLs with numeric addresses as hosts
		{ regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]], format = "$0" },
	},
	window_frame = {
		font = wezterm.font({
			family = "Berkeley Mono Variable",
			weight = "Regular",
		}),
	},
	leader = {
		key = "a",
		mods = "CTRL|SHIFT",
		timeout_milliseconds = 2000,
	},
	-- \x01 is the prefix (Ctrl+a)
	keys = {
		{
			key = "P",
			mods = "CMD|SHIFT",
			action = act.ActivateCommandPalette,
		},
		{
			key = "]",
			mods = "CMD|SHIFT",
			action = act.ToggleAlwaysOnTop,
		},
		{
			key = "0",
			mods = "CMD|SHIFT",
			action = act.SetWindowLevel("Normal"),
		},
		{
			key = "[",
			mods = "CMD|SHIFT",
			action = act.ToggleAlwaysOnBottom,
		},
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
		{
			key = "[",
			mods = "CMD",
			action = act({ SendString = "\x01(" }),
		},
		{
			key = "]",
			mods = "CMD",
			action = act({ SendString = "\x01)" }),
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
		{ key = "j", mods = "CMD", action = act({ SendString = "\x01\x54" }) },
		{ key = "o", mods = "CMD", action = act({ SendString = "\x01\x0F" }) },
		{ key = "p", mods = "CMD", action = act({ SendString = "\x01\x10" }) },
	},
}

return config
