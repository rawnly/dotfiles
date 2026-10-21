-- neovim integration
require("smart-splits")

rex.unbind("cmd+d", "pane.split.right")
rex.unbind("cmd+enter", "pane.split.auto")
rex.unbind("shift+cmd+d", "pane.split.down")
rex.unbind("shift+cmd+enter", "pane.zoom")
rex.unbind("cmd+/", "client.sidebar.toggle")

rex.bind("ctrl+a>]", "client.tab.next")
rex.bind("ctrl+a>[", "client.tab.previous")
rex.bind("cmd+enter", "pane.split.right")
rex.bind("shift+cmd+enter", "pane.split.down")
rex.bind("cmd+/", "pane.zoom")
rex.bind("cmd+s", "client.sidebar.toggle")
