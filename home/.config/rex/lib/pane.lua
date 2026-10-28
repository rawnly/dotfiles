--- Shared helpers for actions. Pure functions over the `rex` API; no side effects on load.
local M = {}

M.TERM = "com.superlogical.terminal"
M.SHELL = M.TERM .. ".shell"
M.CONFIG_DIR = os.getenv("HOME") .. "/.config/rex"

--- Absolute path of a helper script in `bin/`.
---@param name string
---@return string
function M.bin(name)
	return M.CONFIG_DIR .. "/bin/" .. name
end

--- Unwrap a `(result, err)` pair from the `rex.session.*` API, raising `err` (without a traceback).
---@generic T
---@param result T?
---@param err string?
---@return T
function M.check(result, err)
	if err then
		error(err, 0)
	end
	return result
end

--- Working directory of a pane: the reported `file://` URI, else the foreground process cwd, else $HOME.
---@param ctx { block_id: string }
---@return string
function M.cwd(ctx)
	local r = rex.block.call(M.TERM, "pwd", { block_id = ctx.block_id })
	local uri = r and r.pwd
	local path = uri and uri:match("^file://[^/]*(/.*)$")
	if path then
		return (path:gsub("%%(%x%x)", function(hex)
			return string.char(tonumber(hex, 16))
		end))
	end
	local proc = rex.block.call(M.TERM, "process", { block_id = ctx.block_id })
	return (proc and proc.foreground and proc.foreground.cwd) or os.getenv("HOME")
end

--- Layout node for one shell block. Leave `cmd` out for a plain login shell.
---@param opts { cwd: string, cmd?: string[], label?: string }
function M.shell_layout(opts)
	return rex.layout.block({
		flavor = M.SHELL,
		label = opts.label,
		options = { cwd = opts.cwd, command = opts.cmd },
	})
end

--- Open `layout` in a floating layer on the active window and focus it.
---@param bounds number[] `{ x, y, w, h }` as fractions of the window
---@param layout table
function M.float(bounds, layout)
	return M.check(rex.session.new_layer({ bounds = bounds, focus = true, layout = layout }))
end

return M
