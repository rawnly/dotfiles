local M = {}

-- Return the Git root directory, or nil if not in a repo
function M.root()
	local root = vim.fs.root(0, ".git")
	if root and #root > 0 then
		return root
	end
	return nil
end

-- Return true if current directory is in a Git repo
function M.is_repo()
	return M.root() ~= nil
end

return M
