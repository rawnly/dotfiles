-- neovim integration
require("smart-splits")

rex.bind("ctrl+a>]", "client.tab.next")
rex.bind("ctrl+a>[", "client.tab.previous")
rex.bind("ctrl+a>x", "client.tab.close")
rex.bind("ctrl+a>r", "session.rename")
rex.bind("ctrl+a>,", "client.tab.rename")
rex.bind("ctrl+a>b", "client.sidebar.toggle")
rex.bind("ctrl+a>w", "session.switch")
rex.bind("ctrl+a>=", "pane.balance")
rex.bind("ctrl+a>ctrl+a", "pane.send_key", {
	key = "ctrl+a",
})
rex.bind("ctrl+a>g", "quick_open", {
	cmd = { "lazygit" },
	ratio = 0.5,
	zoom = false,
})

rex.bind("cmd+shift+r", "client.config.reload")
rex.bind("cmd+enter", "pane.split.right")
rex.bind("alt+enter", "pane.split.auto")
rex.bind("shift+cmd+enter", "pane.split.down")
rex.bind("cmd+/", "pane.zoom")
rex.bind("cmd+s", "client.sidebar.toggle")

rex.bind("alt+shift+h", "move_pane", { direction = "left" }) -- move split to the left
rex.bind("alt+shift+j", "move_pane", { direction = "down" }) -- move split down
rex.bind("alt+shift+k", "move_pane", { direction = "up" }) -- move split up
rex.bind("alt+shift+l", "move_pane", { direction = "right" }) -- move split to the right
