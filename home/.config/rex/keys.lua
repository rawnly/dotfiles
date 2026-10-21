-- neovim integration
require("smart-splits")

rex.unbind("cmd+d", "pane.split.right")
rex.unbind("cmd+enter", "pane.split.auto")
rex.unbind("shift+cmd+d", "pane.split.down")
rex.unbind("shift+cmd+enter", "pane.zoom")
rex.unbind("cmd+/", "client.sidebar.toggle")

rex.bind("ctrl+a>]", "client.tab.next")
rex.bind("ctrl+a>[", "client.tab.previous")
rex.bind("ctrl+a>x", "client.tab.close")
rex.bind("ctrl+a>r", "session.rename")
rex.bind("ctrl+a>,", "client.tab.rename")

rex.bind("cmd+shift+r", "client.config.reload")
rex.bind("cmd+enter", "pane.split.right")
rex.bind("alt+enter", "pane.split.auto")
rex.bind("shift+cmd+enter", "pane.split.down")
rex.bind("cmd+/", "pane.zoom")
rex.bind("cmd+s", "client.sidebar.toggle")
