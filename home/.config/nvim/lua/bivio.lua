local M = {}

function M.list(limit)
	if not M.is_installed() then
		vim.notify("bvo not installed")
		return
	end

	limit = limit or 10

	local rawjson = vim.fn.system("bvo list --json --limit " .. limit)
	if vim.v.shell_error ~= 0 then
		error("bvo returned an error")
	end

	local ok, data = pcall(vim.json.decode, rawjson)
	if not ok then
		error("invalid json")
	end

	return data
end

function M.is_installed()
	vim.fn.system("command -v bvo &> /dev/null")
	return vim.v.shell_error == 0
end

function M.starter_section(name)
	if not M.is_installed() then
		vim.notify("bvo not installed")
		return
	end

	local function openProject(path)
		return function()
			vim.cmd("cd " .. path)
			require("persistence").load()
			vim.cmd("Outline")
		end
	end

	local all_projects = M.list(3)
	local projects_section = {}
	for i, project in ipairs(all_projects) do
		table.insert(projects_section, i, {
			name = project.name,
			action = openProject(project.path),
			section = name or "Projects",
		})
	end

	return projects_section
end

function M.pick()
	if not M.is_installed() then
		vim.notify("bvo not installed")
		return
	end

	local rawjson = vim.fn.system("bvo list --json")
	if vim.v.shell_error ~= 0 then
		error("bvo returned an error")
	end

	local ok, data = pcall(vim.json.decode, rawjson)
	if not ok then
		error("invalid json")
	end

	Snacks.picker.pick({
		title = "BIVIO",
		finder = function()
			---@type snacks.picker.Item[]
			local items = {}

			for idx, project in ipairs(data) do
				---@type snacks.picker.Item
				local item = {
					text = project.name,
					frecency = project.score,
					file = project.path,
				}

				table.insert(items, idx, item)
			end

			return items
		end,
	})
end

return M
