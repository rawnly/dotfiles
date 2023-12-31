local wezterm = require("wezterm")

local function tableMerge(t1, t2)
	for k, v in pairs(t2) do
		if type(v) == "table" then
			if type(t1[k] or false) == "table" then
				tableMerge(t1[k] or {}, t2[k] or {})
			else
				t1[k] = v
			end
		else
			t1[k] = v
		end
	end

	return t1
end

-- Wezterm integration with folke/zen-mode.nvim
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
end)

local act = wezterm.action

local wezdir = os.getenv("HOME") .. "/.config/wezterm"

local fontFamily = "Berkeley Mono Variable"
local fontOptions = {
	front_end = "OpenGL",
	line_height = 1.0,
	freetype_load_target = "Normal",
	freetype_load_flags = "NO_HINTING",
	font = wezterm.font_with_fallback({
		fontFamily,
		{
			family = "Symbols Nerd Font Mono",
			scale = 0.75,
		},
	}),
}

local config = {
	adjust_window_size_when_changing_font_size = false,
	enable_tab_bar = false,
	default_prog = { "/opt/homebrew/bin/tmux", "new-session", "-A", "-s", "wez-main" },
	font_size = 16,
	color_scheme_dirs = { wezdir .. "/colors" },
	color_scheme = "kanagawa-dragon",
	window_background_opacity = 1,
	window_decorations = "RESIZE",
	enable_wayland = false,
	exit_behavior = "Close",
	window_padding = {
		left = "1cell",
		right = "1cell",
		top = "0.5cell",
	},
	window_frame = {
		font = wezterm.font({
			family = fontFamily,
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
			key = "Enter",
			mods = "CMD",
			action = act({ SendString = "\x01%" }),
		},
		{
			key = "Enter",
			mods = "CMD|SHIFT",
			action = act({ SendString = '\x01"' }),
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
			key = "l",
			mods = "CTRL|SHIFT",
			action = act.ClearScrollback("ScrollbackAndViewport"),
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
		{
			key = "p",
			mods = "CMD|SHIFT",
			action = wezterm.action.ToggleFloatingWindow,
		},
	},
}

return tableMerge(config, fontOptions)
