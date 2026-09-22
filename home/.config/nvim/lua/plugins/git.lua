---@module "lazy.nvim"
---@type LazySpec
return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
		lazy = true,
		keys = {
			-- hunk
			{
				"<leader>gsh",
				function()
					require("gitsigns").stage_hunk()
				end,
				desc = "Stage Hunk",
			},
			{
				"<leader>grh",
				function()
					require("gitsigns").reset_hunk()
				end,
				desc = "Reset Hunk",
			},
			{
				mode = "v",
				"<leader>gsh",
				function()
					require("gitsigns").stage_hunk({
						vim.fn.line("."),
						vim.fn.line("v"),
					})
				end,
				desc = "Stage Hunk",
			},
			{
				mode = "v",
				"<leader>grh",
				function()
					require("gitsigns").reset_hunk({
						vim.fn.line("."),
						vim.fn.line("v"),
					})
				end,
				desc = "Reset Hunk",
			},
			{
				"<leader>gph",
				function()
					require("gitsigns").preview_hunk_inline()
				end,
				desc = "Preview hunk",
			},
			{
				"<leader>gsb",
				function()
					require("gitsigns").stage_buffer()
				end,
				desc = "Stage Buffer",
			},
			{
				"<leader>grb",
				function()
					require("gitsigns").reset_buffer()
				end,
				desc = "Reset Buffer",
			},
			{
				"<leader>gb",
				function()
					require("gitsigns").blame_line()
				end,
				desc = "Blame Line",
			},
			{
				"<leader>gB",
				function()
					require("gitsigns").blame()
				end,
				desc = "Toggle Blame",
			},
		},
	},
}
