local pane = require("lib.pane")

--- Find a block by label, or nil.
local function find_block(label)
	local list = rex.session.list_blocks()
	for _, b in ipairs(list and list.blocks or {}) do
		if b.label == label then
			return b
		end
	end
end

--- tmux-popup-style toggle: a floating pane whose process survives being hidden.
---
--- 1st call: start `cmd` (or a plain shell) in a floating layer.
--- Visible:  detach the block (hidden, still running).
--- Hidden:   re-place it beside the focused pane, float it, focus it.
--- One popup per (name, cwd), found by block label.
rex.action({
	name = "popup",
	title = "Toggle Popup",
	-- Argument types: see `config.PopupArgs` in types/rex.lua.
	args = {
		type = "object",
		properties = {
			name = { type = "string" },
			cmd = { type = "array", items = { type = "string" } },
			bounds = { type = "array", items = { type = "number" } },
			cwd = { type = "string" },
		},
	},
	---@param ctx rex.Context
	---@param args config.PopupArgs
	run = function(ctx, args)
		local bounds = args.bounds or { 0.1, 0.1, 0.8, 0.8 }
		local cwd = args.cwd or pane.cwd(ctx)
		local name = args.name or (args.cmd and args.cmd[1]) or "shell"
		local label = ("popup:%s:%s"):format(name, cwd)

		local block = find_block(label)

		if not block then
			return pane.float(bounds, pane.shell_layout({ cwd = cwd, cmd = args.cmd, label = label }))
		end

		if block.placement == "placed" then
			return pane.check(rex.session.detach_block({ block_id = block.block_id }))
		end

		-- Hidden: there is no "place as floating" call, so go through a split first.
		pane.check(rex.session.move_block({ block_id = block.block_id, anchor_block_id = ctx.block_id }))
		pane.check(rex.session.float_block({ block_id = block.block_id, bounds = bounds }))
		pane.check(rex.session.focus_block({ block_id = block.block_id }))
	end,
})
