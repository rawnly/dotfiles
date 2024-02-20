local wezterm = require("wezterm")
local config = wezterm.config_builder()

local act = wezterm.action

-- updates
config.check_for_updates = true
config.check_for_updates_interval_seconds = 3600 * 6 -- 6hrs

-- handled by tmux
config.enable_tab_bar = false

-- set tmux as default program.
-- new windows will have a new tmux session initialized
config.default_prog = { "/opt/homebrew/bin/tmux", "new-session", "-A", "-s", "main" }

-- font
config.font_size = 14
config.font = wezterm.font_with_fallback({
	-- "BerkeleyMonoVariable Nerd Font",
	"JetbrainsMonoNL Nerd Font Mono",
	{
		family = "Symbols Nerd Font Mono",
		scale = 0.75,
	},
})

-- color scheme
config.color_scheme_dirs = { "~/.config/wezterm/colors" }
config.color_scheme = "Gruvbox dark, hard (base16)"

-- window style
config.window_background_opacity = 1
config.window_decorations = "RESIZE"
config.window_frame = {
	font = wezterm.font({
		family = "Berkeley Mono Variable",
		weight = "Regular",
	}),
}

-- stuff
config.scrollback_lines = 5000
config.exit_behavior = "Close"

config.hyperlink_rules = {
	{ regex = [[\b\w+://[\w.-]+\.[a-z]{2,15}\S*\b]], format = "$0" },
	-- Email addresses:
	{ regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]], format = "mailto:$0" },
	-- file:// URI
	{ regex = [[\bfile://\S*\b]], format = "$0" },
	-- URLs with numeric addresses as hosts
	{ regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]], format = "$0" },
	-- localhost url
	{ regex = [[\b\w+://localhost:\d{2,4}\b]], format = "$0" },
}

-- keymaps
config.disable_default_key_bindings = true
config.leader = {
	key = "a",
	mods = "CTRL|SHIFT",
	timeout_milliseconds = 2000,
}

local function tmux_prefixed(char)
	local prefix = "\x01"
	return act({ SendString = prefix .. char })
end

-- \x01 is the prefix (Ctrl(\x)+a(01))
config.keys = {
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.ToggleFullScreen,
	},

	{ key = "q", mods = "CMD", action = wezterm.action.QuitApplication },
	{
		key = "n",
		mods = "CMD",
		action = wezterm.action.SpawnCommandInNewWindow({
			args = { "/opt/homebrew/bin/tmux", "new-session" },
		}),
	},
	{
		key = "v",
		mods = "CMD",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	{
		key = "c",
		mods = "CMD",
		action = wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
	},
	{
		key = "p",
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
		mods = "CMD",
		-- split H
		action = tmux_prefixed("|"),
	},
	{
		key = "Enter",
		mods = "CMD|SHIFT",
		-- split V
		action = tmux_prefixed("-"),
	},
	{
		key = "w",
		mods = "CMD",
		-- close tab
		action = tmux_prefixed("x"),
	},
	{
		key = "t",
		mods = "CMD",
		-- new tab
		action = tmux_prefixed("c"),
	},
	{
		key = "[",
		mods = "CMD",
		-- previous session
		action = tmux_prefixed("("),
	},
	{
		key = "]",
		mods = "CMD",
		-- next session
		action = tmux_prefixed(")"),
	},
	{
		key = "l",
		mods = "CMD|SHIFT",
		-- resize RIGHT
		action = tmux_prefixed("L"),
	},
	{
		key = "h",
		mods = "CMD|SHIFT",
		-- resize LEFT
		action = tmux_prefixed("H"),
	},
	{
		key = "j",
		mods = "CMD|SHIFT",
		-- resize DOWN
		action = tmux_prefixed("J"),
	},
	{
		key = "k",
		mods = "CMD|SHIFT",
		-- resize UP
		action = tmux_prefixed("K"),
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
}

return config
