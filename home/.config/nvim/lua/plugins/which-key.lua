icons = require("icons")

return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		---@class wk.Opts
		opts = {
			preset = "helix",
			delay = 0,
			spec = {
				{ "<leader>w", proxy = "<c-w>", group = "windows" },
				{ "<leader>l", icon = icons.lsp.Event, group = "LSP" },
				{ "<leader>f", icon = icons.file.files, group = "Pickers" },
				{ "<leader>h", icon = icons.git.commit, group = "Hunk" },
				{ "<leader>g", icon = icons.git.github, group = "Git" },
				{ "<leader>gp", icon = icons.git.github, group = "Preview" },
				{ "<leader>gr", icon = icons.git.github, group = "Reset" },
				{ "<leader>gs", icon = icons.git.staged, group = "Stage" },
				{ "<leader>n", icon = icons.braces, group = "Test" },
				{ "<leader>d", icon = icons.dap.breakpoint, group = "DAP" },
				{ "<leader>x", icon = icons.diagnostics.bug, group = "Trouble" },
				{ "<leader>s", icon = icons.globe, group = "Search & Replace" },
				{ "<leader>b", icon = icons.file.files, group = "Buffers" },
				{ "<leader>t", icon = icons.prism, group = "TargetProcess" },
				{ "<leader>r", icon = icons.lightning, group = "Run" },
			},
			plugins = {
				presets = {
					motions = true,
					nav = true,
					operators = true,
					windows = true,
					text_objects = true,
				},
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
			{ "<C-q>", "<CMD>q!<CR><ESC>" },
			{ "<C-s>", "<cmd>w!<cr><esc>", desc = "Save File", mode = { "i", "x", "n", "s" } },
			{
				"<cr>",
				function()
					if vim.bo.modifiable then
						return "ciw"
					else
						return "<cr>"
					end
				end,
				desc = "Clear cursor word",
				mode = "n",
				expr = true,
			},
		},
	},
}
