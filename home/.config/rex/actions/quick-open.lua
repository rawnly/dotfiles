local TERM = "com.superlogical.terminal"

local function pane_cwd(ctx)
	local r = rex.block.call(TERM, "pwd", {
		block_id = ctx.block_id,
	})

	local uri = r and r.pwd
	local path = uri and uri:match("^file://[^/]*(/.*)$")

	if path then
		return (path:gsub("%%(%x%x)", function(hex)
			return string.char(tonumber(hex, 16))
		end))
	end

	local proc = rex.block.call(TERM, "process", {
		block_id = ctx.block_id,
	})

	return (proc and proc.foreground and proc.foreground.cwd) or os.getenv("HOME")
end

rex.action({
	name = "bivio",
	title = "Open Bivio",
	run = function(ctx)
		local result, err = rex.session.new_layer({
			bounds = { 0.1, 0.1, 0.8, 0.8 },
			focus = true,
			layout = rex.layout.block({
				flavor = TERM .. ".shell",
				options = {
					cwd = pane_cwd(ctx),
					command = {
						"/bin/bash",
						os.getenv("HOME") .. "/.config/rex/actions/bivio-session.sh",
						ctx.client_id or "",
					},
					exit = { on_completion = true, quick_exit_threshold_ms = 0 },
				},
			}),
		})
		if err then
			error(err, 0)
		end
		return result
	end,
})

--- Spawn `cmd` in a new split beside the focused block.
rex.action({
	name = "quick_open",
	title = "Quick Open",
	args = {
		type = "object",
		required = { "cmd" },
		properties = {
			cmd = { type = "array", items = { type = "string" } },
			ratio = { type = "number" },
			zoom = { type = "boolean" },
			cwd = { type = "string" },
			direction = { type = "string" },
			side = { type = "string" },
		},
	},
	run = function(ctx, args)
		local ratio = args.ratio or 0.5
		if ratio <= 0 or ratio >= 1 then
			error("ratio must be above 0 and below 1", 0)
		end

		local result, err = rex.session.new_split({
			direction = args.direction or "horizontal",
			side = args.side or "after",
			ratio = ratio,
			focus = true,
			layout = rex.layout.block({
				flavor = TERM .. ".shell",
				options = {
					cwd = args.cwd or pane_cwd(ctx),
					command = args.cmd,
				},
			}),
		})
		if err then
			error(err, 0)
		end

		if args.zoom and result and result.block_ids and result.block_ids[1] then
			local _, zerr = rex.session.zoom_block({ block_id = result.block_ids[1], zoom = true })
			if zerr then
				error(zerr, 0)
			end
		end
		return result
	end,
})
