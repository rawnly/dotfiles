local pane = require("lib.pane")

--- Toggle floating panes via `session.set_layer_state`.
---
--- Focused pane is in a floating layer: minimize that layer (its blocks keep running).
--- Otherwise: restore the most recently minimized layer in the window and focus it.
rex.action({
	name = "pane_minimize",
	title = "Minimize / Restore Floating Pane",
	---@param ctx rex.Context
	run = function(ctx)
		local view = pane.check(rex.session.view())
		local minimized

		for _, win in ipairs(view.windows or {}) do
			for _, layer in ipairs(win.layers or {}) do
				if layer.kind == "floating" then
					if layer.state == "minimized" then
						if win.window_id == view.active_window_id then
							minimized = layer
						end
					else
						for _, b in ipairs(layer.blocks or {}) do
							if b.block_id == ctx.block_id then
								return pane.check(rex.session.set_layer_state({
									layer_id = layer.layer_id,
									state = "minimized",
								}))
							end
						end
					end
				end
			end
		end

		if not minimized then
			error("no floating pane to minimize or restore", 0)
		end
		return pane.check(rex.session.set_layer_state({
			layer_id = minimized.layer_id,
			state = "normal",
			focus = true,
		}))
	end,
})
