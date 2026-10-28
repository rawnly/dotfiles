local pane = require("lib.pane")

--- Open the focused pane's screen and scrollback in a read-only neovim float.
--- The helper script gets the origin block id, since `$REX_BLOCK` inside the float is the float itself.
rex.action({
	name = "edit_scrollback",
	title = "Edit Scrollback",
	run = function(ctx)
		pane.float(
			{ 0.03, 0.03, 0.94, 0.94 },
			pane.shell_layout({
				cwd = pane.cwd(ctx),
				cmd = { "sh", pane.bin("edit-scrollback.sh"), ctx.block_id },
			})
		)
	end,
})
