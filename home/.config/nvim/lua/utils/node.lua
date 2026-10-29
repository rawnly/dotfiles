local M = {}

function M.manifest()
	local root = vim.fs.find("package.json", { upward = true })[1]
	if not root then
		return nil
	end
	return root
end

function M.root_manifest()
	local git = require("utils.git")
	local git_root = git.root()
	if not git_root then
		return nil
	end

	local root = vim.fs.find("package.json", { upward = true, path = git_root })[1]
	if not root then
		return nil
	end
	return root
end

---@return string|nil
function M.lockfile()
	local root_dir = vim.fs.dirname(M.root_manifest() or "")
	if not root_dir then
		return nil
	end

	local f = vim.fs.find({
		"pnpm-lock.yaml",
		"yarn.lock",
		"pnpm-lock.yml",
		"bun.lock",
		"package-lock.json",
	}, {
		type = "file",
		path = root_dir,
		limit = math.huge,
	})

	return f[1] -- Lua is 1-based
end

return M
