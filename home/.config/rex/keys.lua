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
}

---------------------------------------------------------------------------
-- Tabs, sessions, layout
---------------------------------------------------------------------------
rex.bind(prefix("]"), "client.tab.next")
rex.bind(prefix("["), "client.tab.previous")
rex.bind(prefix("x"), "client.tab.close")
rex.bind(prefix(","), "client.tab.rename")
rex.bind(prefix("R"), "session.rename")
rex.bind(prefix("r"), "client.tab.rename")
rex.bind(prefix("="), "pane.balance")
rex.bind(prefix("ctrl+a"), "pane.send_key", { key = "ctrl+a" }) -- send a literal ctrl+a

rex.bind("cmd+s", "client.sidebar.toggle")
rex.bind("cmd+/", "pane.zoom")
rex.bind("cmd+enter", "pane.split.right")
rex.bind("shift+cmd+enter", "pane.split.down")
rex.bind("alt+enter", "pane.split.auto")
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

rex.bind("git/g", "popup", { name = "lazygit", cmd = { "lazygit" }, bounds = BOUNDS.full })

rex.bind("git/shift+g", "quick_open", { cmd = { "lazygit" }, ratio = 0.5 }) -- as a split

---------------------------------------------------------------------------
-- One-shot floats
---------------------------------------------------------------------------
rex.bind(prefix("i"), "quick_open", {
	cmd = { "sh", pane.bin("pick-file.sh") }, -- bracco, then edit the pick in a new tab
	floating = true,
	bounds = BOUNDS.picker,
})
rex.bind(prefix("e"), "edit_scrollback")
