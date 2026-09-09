---@type Terminal
local lazygit

local script_terms = {}

local notified_no_repo = false
local notified_no_manifest = false
local notified_no_lockfile = false

local function should_notify()
	if vim.g.silent then
		return false
	end
	if vim.g.toggleterm_notify == false then
		return false
	end
	return true
end

local function close_on_q(bufnr)
	vim.keymap.set("n", "q", "<cmd>close<cr>", {
		buffer = bufnr,
		noremap = true,
		silent = true,
	})
	vim.keymap.set("t", "q", [[<C-\\><C-n><cmd>close<cr>]], {
		buffer = bufnr,
		noremap = true,
		silent = true,
	})
	vim.keymap.set("t", "Q", function()
		local job_id = vim.b.terminal_job_id
		if job_id then
			vim.fn.jobstop(job_id)
		end
	end, {
		buffer = bufnr,
		noremap = true,
		silent = true,
	})
	vim.keymap.set("t", "<esc><esc>", [[<C-\\><C-n><cmd>close<cr>]], {
		buffer = bufnr,
		noremap = true,
		silent = true,
	})
end

local function setup_script_buffer(bufnr)
	close_on_q(bufnr)
	vim.bo[bufnr].modifiable = false
	vim.bo[bufnr].readonly = true
	vim.keymap.set("n", "i", "<nop>", { buffer = bufnr, silent = true })
	vim.keymap.set("n", "a", "<nop>", { buffer = bufnr, silent = true })
	vim.keymap.set("n", "I", "<nop>", { buffer = bufnr, silent = true })
	vim.keymap.set("n", "A", "<nop>", { buffer = bufnr, silent = true })
	vim.keymap.set("n", "o", "<nop>", { buffer = bufnr, silent = true })
	vim.keymap.set("n", "O", "<nop>", { buffer = bufnr, silent = true })
	vim.cmd("stopinsert")
end

local function get_lazygit()
	if not lazygit then
		local Terminal = require("toggleterm.terminal").Terminal
		lazygit = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			direction = "float",
			dir = "git_dir",
			display_name = "Lazygit",
			float_opts = {
				border = "double",
			},
			on_open = function(t)
				vim.cmd("startinsert!")
				close_on_q(t.bufnr)
			end,
		})
	end

	return lazygit
end

local function get_script_terminal(cmd)
	if script_terms[cmd] then
		return script_terms[cmd]
	end

	local Terminal = require("toggleterm.terminal").Terminal
	script_terms[cmd] = Terminal:new({
		cmd = cmd,
		hidden = true,
		close_on_exit = true,
		auto_scroll = true,
		start_in_insert = false,
		direction = "float",
		float_opts = {
			border = "double",
		},
		on_open = function(t)
			setup_script_buffer(t.bufnr)
		end,
		on_exit = function()
			script_terms[cmd] = nil
		end,
	})

	return script_terms[cmd]
end

local function get_runner()
	local node = require("utils.node")
	if node.manifest() == nil then
		if should_notify() and not notified_no_manifest then
			notified_no_manifest = true
			vim.notify("No package manifest found", vim.log.levels.INFO)
		end
		return nil
	end

	local fname = node.lockfile()
	if fname == nil then
		if should_notify() and not notified_no_lockfile then
			notified_no_lockfile = true
			vim.notify("No lockfile found", vim.log.levels.INFO)
		end
		return nil
	end

	if fname:match("pnpm") then
		return "pnpm"
	end
	if fname:match("bun") then
		return "bun"
	end
	if fname:match("yarn") then
		return "yarn"
	end

	return "npm"
end

local function build_runner_items(prefix, names, to_cmd, items)
	for _, name in ipairs(names) do
		local cmd = to_cmd(name)
		local running = script_terms[cmd] ~= nil
		table.insert(items, { label = prefix .. name, cmd = cmd, running = running })
	end
end

local function build_script_items(runner)
	local script_utils = require("utils.script")
	local scripts = script_utils.package_scripts() or {}
	local make_targets = script_utils.make_targets() or {}
	local just_recipes = script_utils.just_recipes() or {}
	if runner == nil then
		scripts = {}
	end

	local sources = 0
	if #scripts > 0 then
		sources = sources + 1
	end
	if #make_targets > 0 then
		sources = sources + 1
	end
	if #just_recipes > 0 then
		sources = sources + 1
	end
	if sources == 0 then
		return nil
	end

	local show_prefix = sources > 1
	local items = {}
	if runner ~= nil then
		local prefix = show_prefix and (runner .. ":") or ""
		build_runner_items(prefix, scripts, function(name)
			return runner .. " run " .. name
		end, items)
	end

	local make_prefix = show_prefix and "make:" or ""
	build_runner_items(make_prefix, make_targets, function(name)
		return "make " .. name
	end, items)

	local just_prefix = show_prefix and "just:" or ""
	build_runner_items(just_prefix, just_recipes, function(name)
		return "just " .. name
	end, items)

	table.sort(items, function(a, b)
		return a.label < b.label
	end)

	return items
end

---@type LazySpec
return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			open_mapping = [[<c-\>]], -- or { [[<c-\>]], [[<c-¥>]] } if you also use a Japanese keyboard.
			autochdir = true,
			direction = "horizontal",
			size = function(t)
				if t.direction == "horizontal" then
					return 20
				elseif t.direction == "vertical" then
					return vim.o.columns * 0.3
				end
			end,
		},
		keys = {
			{
				"<leader>rl",
				mode = "n",
				function()
					local git = require("utils.git")
					if not git.is_repo() then
						if not notified_no_repo and should_notify() then
							notified_no_repo = true
							vim.notify("Not a git repo", vim.log.levels.INFO)
						end
						return
					end
					get_lazygit():toggle()
				end,
				desc = "lazygit",
			},
			{
				"<leader>rs",
				mode = "n",
				function()
					local runner = get_runner()
					local items = build_script_items(runner)
					if items == nil then
						if should_notify() then
							if runner == nil then
								vim.notify("No scripts found", vim.log.levels.INFO)
							else
								vim.notify("No package scripts found", vim.log.levels.INFO)
							end
						end
						return
					end

					vim.ui.select(items, {
						prompt = "Run script",
						format_item = function(item)
							local mark = item.running and "[x]" or "[ ]"
							return mark .. " " .. item.label
						end,
					}, function(choice)
						if choice == nil then
							return
						end
						get_script_terminal(choice.cmd):toggle()
					end)
				end,
				desc = "pick script",
			},
			{
				"<c-\\>",
				function()
					require("toggleterm").toggle()
				end,
				desc = "Terminal",
			},
			{
				"gt",
				mode = "n",
				function()
					require("toggleterm").send_lines_to_terminal("single_line", true, {
						args = vim.v.count,
					})
				end,
				desc = "Send line to terminal",
			},
			{
				"<c-\\>",
				mode = "v",
				function()
					require("toggleterm").send_lines_to_terminal("visual_selection", true, {
						args = vim.v.count,
					})
				end,
				desc = "Send selection to terminal",
			},
		},
	},
}
