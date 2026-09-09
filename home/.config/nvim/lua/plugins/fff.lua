---@type
return {
	"dmtrKovalenko/fff.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	build = function()
		require("fff.download").download_or_build_binary()
	end,
	opts = {
		prompt = "> ",
		layout = {
			preview_position = "top",
			prompt_position = "top",
			width = 0.9,
			height = 0.9,
		},
		debug = {
			enabled = false,
			show_scores = false,
		},
		keymaps = {
			move_up = { "<C-k>", "<Up>", "<C-p>" },
			move_down = { "<C-j>", "<Down>", "<C-n>" },
		},
		git = {
			status_text_color = true,
		},
	},
	lazy = false,
	keys = {
		{
			"<leader>ff",
			function()
				require("fff").find_files()
			end,
			desc = "FFFind files",
		},
		{
			"<leader>fF",
			function()
				local git_root = vim.fn.system("git rev-parse --show-toplevel")
				require("fff").find_files_in_dir(git_root)
			end,
			desc = "FFFind files",
		},
		{
			"<leader>fw",
			function()
				require("fff").live_grep()
			end,
			desc = "FFFuzzy grep",
		},
		{
			"<leader>fc",
			function()
				require("fff").live_grep({
					query = vim.fn.expand("<cword>"),
				})
			end,
			desc = "Search current word",
		},
		{
			"ff",
			function()
				require("fff").find_files()
			end,
			desc = "FFFind files",
		},
	},
}
