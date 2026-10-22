--- Swap the focused pane with its neighbour in `direction`; focus follows the pane.
rex.action({
	name = "move_pane",
	title = "Move Pane",
	args = {
		type = "object",
		required = { "direction" },
		properties = {
			direction = { type = "string", enum = { "left", "right", "up", "down" } },
		},
	},
	run = function(ctx, args)
		local function focused()
			local view = rex.session.view()
			for _, w in ipairs(view and view.windows or {}) do
				if w.window_id == view.active_window_id then
					return w.focused_block_id
				end
			end
		end

		local cur = ctx.block_id or focused()
		if not cur then
			return
		end
		rex.session.focus_direction({ direction = args.direction })
		local other = focused()
		if other and other ~= cur then
			rex.session.swap_blocks({ block_id = cur, other_block_id = other })
			rex.session.focus_block({ block_id = cur })
		end
	end,
})
