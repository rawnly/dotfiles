-- Key bindings. Prefix is `ctrl+a`; actions live in `actions/`, helpers in `lib/`.
local pane = require("lib.pane")
local prefix_str = "ctrl+a"

local function prefix(key)
	return prefix_str .. ">" .. key
end

-- Floating pane geometry: { x, y, w, h } as fractions of the window.
local BOUNDS = {
	-- full = { 0.05, 0.05, 0.9, 0.9 },
	full = { 0.05, 0.05, 0.9, 0.9 },
	picker = { 0.2, 0.15, 0.6, 0.7 },

	right = function(size)
		local w = size ~= nil and size or 0.5
		local padding = 0.5 + (0.5 - w)

		return { padding, 0, w, 1 }
	end,
	left = function(size)
		local w = size ~= nil and size or 0.5

		return { 0, 0, w, 1 }
	end,
}

---------------------------------------------------------------------------
-- Tabs, sessions, layout
---------------------------------------------------------------------------
rex.bind(prefix(","), "client.tab.rename")
rex.bind(prefix("="), "pane.balance")
rex.bind(prefix("X"), "client.tab.close")
rex.bind(prefix("["), "client.tab.previous")
rex.bind(prefix("]"), "client.tab.next")
rex.bind(prefix("ctrl+a"), "pane.send_key", { key = "ctrl+a" }) -- send a literal ctrl+a
rex.bind(prefix("r"), "client.tab.rename")
rex.bind(prefix("shift+r"), "session.rename")
rex.bind(prefix("x"), "pane.close")

rex.bind("cmd+s", "client.sidebar.toggle")
rex.bind("cmd+/", "pane.zoom")
rex.bind("cmd+enter", "pane.split.right")
rex.bind("shift+cmd+enter", "pane.split.down")
rex.bind("alt+enter", "pane.float")
rex.bind("alt+shift+enter", "pane.minimize_floating")
rex.bind("cmd+shift+r", "client.config.reload")

---------------------------------------------------------------------------
-- Moving between panes
---------------------------------------------------------------------------
-- Swap the focused split with its neighbour.
for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
	rex.bind("alt+shift+" .. key, "pane.move." .. direction)
end

-- smart-splits: focus (ctrl+hjkl) and resize (alt+hjkl), nvim-aware.
for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
	rex.bind("ctrl+" .. key, "smart_splits_focus", { direction = direction, key = "ctrl+" .. key })
	rex.bind("alt+" .. key, "smart_splits_resize", { direction = direction, key = "alt+" .. key })
end

---------------------------------------------------------------------------
-- Popups (floating panes that keep running when hidden)
---------------------------------------------------------------------------
local scratch = { name = "shell", bounds = BOUNDS.full }
rex.bind(prefix("d"), "popup", scratch)
rex.bind("f12", "popup", scratch)

rex.bind(prefix("g"), "client.mode.enter", {
	name = "git",
	once = true,
})

rex.bind("git/g", "popup", {
	name = "lazygit",
	cmd = { "lazygit" },
	bounds = BOUNDS.full,
})
rex.bind("git/shift+g", "quick_open", {
	cmd = { "lazygit" },
	floating = true,
	bounds = BOUNDS.right(1 / 2.3),
})

---------------------------------------------------------------------------
-- One-shot floats
---------------------------------------------------------------------------
rex.bind(prefix("i"), "quick_open", {
	cmd = { "sh", pane.bin("pick-file.sh") }, -- bracco, then edit the pick in a new tab
	floating = true,
	bounds = BOUNDS.picker,
})
rex.bind(prefix("e"), "edit_scrollback")
rex.bind(prefix("b"), "broadcast") -- type into every pane of this tab

---------------------------------------------------------------------------
-- AMBER
---------------------------------------------------------------------------
rex.bind(prefix("shift+p"), "client.mode.enter", {
	name = "amber",
	once = true,
	exclusive = true,
})

rex.bind("amber/i", "amber_install")
rex.bind("amber/u", "amber_update")
rex.bind("amber/r", "amber_restore")
