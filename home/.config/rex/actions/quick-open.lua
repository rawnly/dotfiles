local pane = require("lib.pane")

--- Run `cmd` beside the focused pane (split) or on top of it (floating), in the pane's cwd.
rex.action({
	name = "quick_open",
	title = "Quick Open",
	args = {
		type = "object",
		required = { "cmd" },
		properties = {
			cmd = { type = "array", items = { type = "string" } },
			cwd = { type = "string" },
			-- floating
			floating = { type = "boolean" },
			bounds = { type = "array", items = { type = "number" } },
			-- split
			ratio = { type = "number" },
			direction = { type = "string" },
			side = { type = "string" },
			zoom = { type = "boolean" },
		},
	},
	run = function(ctx, args)
		local layout = pane.shell_layout({ cwd = args.cwd or pane.cwd(ctx), cmd = args.cmd })

		if args.floating then
			return pane.float(args.bounds or { 0.1, 0.1, 0.8, 0.8 }, layout)
		end

		local ratio = args.ratio or 0.5
		if ratio <= 0 or ratio >= 1 then
			error("ratio must be above 0 and below 1", 0)
		end

		local result = pane.check(rex.session.new_split({
			direction = args.direction or "horizontal",
			side = args.side or "after",
			ratio = ratio,
			focus = true,
			layout = layout,
		}))

		local new_block = result and result.block_ids and result.block_ids[1]
		if args.zoom and new_block then
			pane.check(rex.session.zoom_block({ block_id = new_block, zoom = true }))
		end
		return result
	end,
})
