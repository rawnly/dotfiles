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

-- Working directory of the pane: decode the reported file:// URI, fall back to the foreground process cwd.
local function pane_cwd(ctx)
	local TERM = "com.superlogical.terminal"
	local r = rex.block.call(TERM, "pwd", { block_id = ctx.block_id })
	local uri = r and r.pwd
	local path = uri and uri:match("^file://[^/]*(/.*)$")
	if path then
		return (path:gsub("%%(%x%x)", function(hex)
			return string.char(tonumber(hex, 16))
		end))
	end
	local proc = rex.block.call(TERM, "process", { block_id = ctx.block_id })
	return (proc and proc.foreground and proc.foreground.cwd) or os.getenv("HOME")
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
		local before = rex.session.view and rex.session.view()
		local after = rex.session.focus_direction({ direction = direction })
		local at_edge = before and after and before.revision == after.revision

		if at_edge then
			-- nothing lay in that direction: you're at the edge
			-- right \ left => horizontal
			-- up \ down => vertical
			local split_direction = (direction == "right" or direction == "left") and "horizontal" or "vertical"
			local cwd = pane_cwd(ctx)
			local _, err = rex.session.new_split({
				direction = split_direction,
				side = (direction == "right" or direction == "down") and "after" or "before",
				focus = true,
				layout = rex.layout.block({
					flavor = "com.superlogical.terminal.shell",
					options = { cwd = cwd },
				}),
			})
			if err then
				rex.log("error", "smart-splits: new_split failed: " .. err)
			end
		end
		return true
	end)
end
