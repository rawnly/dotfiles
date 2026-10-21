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
for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
	rex.bind("alt+" .. key, function(ctx)
		if is_vim(ctx) then
			return false
		end
		rex.client.queue("pane.resize", { direction = direction, amount = 3 })
		return true
	end)
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
