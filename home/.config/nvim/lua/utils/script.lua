local M = {}

local function run_cmd(args, cwd)
	if vim.system then
		local result = vim.system(args, { cwd = cwd, text = true }):wait()
		if result.code ~= 0 then
			return nil
		end
		local out = result.stdout or ""
		if out == "" then
			return nil
		end
		return vim.split(out, "\n", { trimempty = true })
	end

	local escaped = vim.tbl_map(vim.fn.shellescape, args)
	local cmd = table.concat(escaped, " ")
	if cwd then
		cmd = "cd " .. vim.fn.shellescape(cwd) .. " && " .. cmd
	end
	local lines = vim.fn.systemlist(cmd)
	if vim.v.shell_error ~= 0 then
		return nil
	end
	return lines
end

---@return string[]|nil
function M.package_scripts()
	local node = require("utils.node")
	local manifest = node.manifest()
	if manifest == nil then
		return nil
	end

	local ok, lines = pcall(vim.fn.readfile, manifest)
	if not ok or not lines then
		return nil
	end

	local ok_json, data = pcall(vim.fn.json_decode, table.concat(lines, "\n"))
	if not ok_json or not data or type(data.scripts) ~= "table" then
		return nil
	end

	local scripts = {}
	for name, _ in pairs(data.scripts) do
		table.insert(scripts, name)
	end
	if #scripts == 0 then
		return nil
	end

	table.sort(scripts)
	return scripts
end

---@return string[]|nil
function M.make_targets()
	local makefile = vim.fs.find({ "Makefile", "makefile" }, { upward = true })[1]
	if not makefile then
		return nil
	end

	local dir = vim.fs.dirname(makefile)
	local lines = run_cmd({ "make", "-qp", "-f", makefile }, dir)
	if not lines then
		local ok, file_lines = pcall(vim.fn.readfile, makefile)
		if not ok or not file_lines then
			return nil
		end
		lines = file_lines
	end

	local targets = {}
	for _, line in ipairs(lines) do
		local name = line:match("^([%w%._%-]+)%s*:")
		if name and not name:match("^%.") and not name:match("^#") then
			if not name:match("%$") then
				targets[name] = true
			end
		end
	end

	local out = {}
	for name, _ in pairs(targets) do
		table.insert(out, name)
	end
	if #out == 0 then
		return nil
	end

	table.sort(out)
	return out
end

---@return string[]|nil
function M.just_recipes()
	local justfile = vim.fs.find({ "justfile", "Justfile" }, { upward = true })[1]
	if not justfile then
		return nil
	end

	local dir = vim.fs.dirname(justfile)
	local lines = run_cmd({ "just", "--list", "--unsorted" }, dir)
	if not lines then
		local ok, file_lines = pcall(vim.fn.readfile, justfile)
		if not ok or not file_lines then
			return nil
		end
		lines = file_lines
	end

	local recipes = {}
	for _, line in ipairs(lines) do
		local name = line:match("^([%w%._%-]+)%s*:%s*")
		if name and not name:match("^%.") then
			recipes[name] = true
		end
	end

	local out = {}
	for name, _ in pairs(recipes) do
		table.insert(out, name)
	end
	if #out == 0 then
		return nil
	end

	table.sort(out)
	return out
end

return M
