---@class KeyMapping
---@field lhs string        The key sequence
---@field icon string       The icon
---@field fn fun(bufnr: integer) # Function to execute, receives buffer number
---@field desc string       Description for which-key / documentation

---@class MappingsModule
---@field setup fun(keys: KeyMapping[], bufnr: integer) Sets up buffer-local mappings
local M = {}

---@param keys KeyMapping[]
---@param bufnr integer
function M.setup(keys, bufnr)
	for _, mapping in ipairs(keys) do
		local fn
		if type(mapping[2]) == "function" then
			-- wrap function to pass bufnr
			fn = function()
				mapping[2](bufnr)
			end
		else
			fn = mapping[2]
		end

		vim.keymap.set("n", mapping[1], fn, {
			desc = mapping.desc,
			buffer = bufnr,
		})
	end

	register_icons(keys, bufnr)
end

---@param keys KeyMapping[]
---@param bufnr integer
function register_icons(keys, bufnr)
	local wk = require("which-key")

	for _, mapping in ipairs(keys) do
		if mapping.icon then
			wk.add({
				[mapping[1]] = {
					icon = mapping.icon,
				},
			}, { buffer = bufnr })
		end
	end
end

return M
