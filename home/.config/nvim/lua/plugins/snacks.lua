utils = require("utils")

---@param bufnr integer
---@param extension string
function get_tmp_file(bufnr, extension)
	local filename = string.format("%s.%s", os.tmpname(), extension)
	local content = table.concat(utils.read_buffer(bufnr), "\n")

	local file = io.open(filename, "w+")

	if file == nil then
		return
	end

	file:write(content)
	file:close()

	return filename
end

---@param bufnr integer
---@param extension string
---@param cmd string
function execute_buffer(bufnr, extension, cmd)
	local filename = get_tmp_file(bufnr, extension)
	if not filename then
		return
	end

	local out = utils.exec(string.format("%s %s", cmd, filename))
	if not out then
		return
	end

	Snacks.notifier.notify(out, "debug")
	os.remove(filename)
end

---@module "lazy.nvim"
---@type LazySpec
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- Your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		dashboard = { enabled = false },
		zen = { enabled = false },
		explorer = { enabled = false },
		indent = { enabled = true },
		input = { enabled = true },
		picker = { enabled = true },
		notifier = { enabled = false },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = false },
		statuscolumn = { enabled = true },
		-- handle LSP References
		words = { enabled = true },
		scratch = { enabled = false },
	},
	keys = {
		{
			"<leader>go",
			function()
				Snacks.gitbrowse.open({ what = "permalink", notify = false })
			end,
			desc = "View on github",
		},
		{
			"<leader>gy",
			function()
				Snacks.gitbrowse.open({
					what = "permalink",
					notify = true,
					open = function(url)
						vim.fn.setreg("+", url)
					end,
				})
			end,
			desc = "Copy git permalink",
		},
		{
			"<leader>ft",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "Search Themes",
		},
		{
			"<leader>fp",
			function()
				local function openProject(path)
					vim.cmd("cd " .. path)
					require("persistence").load()
					vim.cmd("Outline")
				end

				Snacks.picker.projects({
					finder = "recent_projects",
					format = "file",
					dev = {
						"~/Developer/satispay",
						"~/Developer/RUST",
						"~/Developer/Go",
						"~/Developer/nvim-plugins/rawnly",
					},
					patterns = { ".git", "go.mod", "Cargo.toml", "package.json", "mise.toml", "Makefile", "justfile" },
					confirm = function(picker, item)
						picker:close()
						openProject(item.text)
					end,
					matcher = {
						frecency = true,
						sort_empty = true,
						cwd_bonus = false,
					},
					sort = { fields = { "score:desc", "idx" } },
				})
			end,
			desc = "Switch Project",
		},
	},
}
