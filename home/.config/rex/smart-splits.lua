-- ctrl+hjkl: pass the key to neovim when it is the foreground process, so smart-splits.nvim can move between
-- its own splits and hand off to Rex at the edge. Otherwise move focus between Rex panes.
local function is_vim(ctx)
	local proc = rex.block.call("com.superlogical.terminal", "process", { block_id = ctx.block_id })
	local fg = proc and proc.foreground
	if not fg then
		return false
	end
	for _, s in ipairs({ fg.name or "", (fg.argv0 or ""):match("[^/]*$") }) do
		if s:match("^n?vim") then
			return true
		end
	end
	return false
end

-- alt+hjkl to resize

rex.action({
	name = "smart_splits_resize",
	title = "Smart Splits: Resize Pane",
	run = function(ctx, args)
		if is_vim(ctx) then
			rex.client.queue("pane.send_key", { key = args.key })
		else
			rex.client.queue("pane.resize", { direction = args.direction, amount = 3 })
		end
	end,
})

for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
	rex.bind("alt+" .. key, "smart_splits_resize", { key = "alt+" .. key, direction = direction })
end

-- ctrl+hjkl to move
for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
	rex.bind("ctrl+" .. key, function(ctx)
		if is_vim(ctx) then
			return false
		end
		rex.session.focus_direction({ direction = direction })
		return true
	end)
end
