local pane = require("lib.pane")

--- Find the layer holding `block_id`: its kind plus another tiled block in the same window to dock beside.
---@param block_id string
---@return { kind: string, anchor: string? }?
local function locate(block_id)
	local view = pane.check(rex.session.view())
	for _, win in ipairs(view.windows or {}) do
		local found, anchor
		for _, layer in ipairs(win.layers or {}) do
			for _, b in ipairs(layer.blocks or {}) do
				if b.block_id == block_id then
					found = layer.kind
				end
				if layer.kind == "tiled" and not anchor and b.block_id ~= block_id then
					anchor = b.block_id
				end
			end
		end
		if found then
			return { kind = found, anchor = anchor }
		end
	end
end

--- Toggle the focused pane between tiled (docked) and floating.
rex.action({
	name = "pane_float",
	title = "Float / Dock Pane",
	args = {
		type = "object",
		properties = {
			bounds = { type = "array", items = { type = "number" } },
			direction = { type = "string" },
			side = { type = "string" },
			ratio = { type = "number" },
		},
	},
	run = function(ctx, args)
		local info = locate(ctx.block_id)
		if not info then
			error("focused pane not found in any window", 0)
		end

		if info.kind == "tiled" then
			pane.check(rex.session.float_block({
				block_id = ctx.block_id,
				bounds = args.bounds or { 0.1, 0.1, 0.8, 0.8 },
			}))
		else
			if not info.anchor then
				error("no tiled pane to dock beside", 0)
			end
			pane.check(rex.session.move_block({
				block_id = ctx.block_id,
				anchor_block_id = info.anchor,
				direction = args.direction or "horizontal",
				side = args.side or "after",
				ratio = args.ratio or 0.5,
			}))
		end
		pane.check(rex.session.focus_block({ block_id = ctx.block_id }))
	end,
})
