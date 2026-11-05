local pane = require("lib.pane")

--- The window holding `block_id`, else the active one.
local function current_window(view, block_id)
	for _, w in ipairs(view.windows or {}) do
		for _, l in ipairs(w.layers or {}) do
			for _, b in ipairs(l.blocks or {}) do
				if b.block_id == block_id then
					return w
				end
			end
		end
	end
	for _, w in ipairs(view.windows or {}) do
		if w.window_id == view.active_window_id then
			return w
		end
	end
end

--- Type `text` + Enter into every tiled terminal pane of the current tab (floats, like the prompt, are skipped).
--- Without `text`, open a floating prompt that broadcasts each line you enter.
rex.action({
	name = "broadcast",
	title = "Broadcast to Panes",
	args = { text = "string?" },
	run = function(ctx, args)
		if args.text == nil then
			return pane.float(
				{ 0.2, 0.4, 0.6, 0.2 },
				pane.shell_layout({ cwd = pane.cwd(ctx), cmd = { "sh", pane.bin("broadcast.sh") } })
			)
		end

		local w = current_window(pane.check(rex.session.view({})), ctx.block_id)
		local sent = 0
		for _, l in ipairs(w and w.layers or {}) do
			if l.kind == "tiled" then
				for _, b in ipairs(l.blocks or {}) do
					if b.creator_name == pane.TERM then
						pane.check(rex.block.call(pane.TERM, "write", { block_id = b.block_id, data = args.text .. "\r" }))
						sent = sent + 1
					end
				end
			end
		end
		return { sent = sent }
	end,
})
