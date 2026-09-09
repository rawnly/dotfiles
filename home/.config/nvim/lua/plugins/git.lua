---@type LazySpec
return {
	-- { "akinsho/git-conflict.nvim", version = "*", config = true },
	-- {
	-- 	"HarshK97/diffmantic.nvim",
	-- 	version = "*",
	-- 	config = function()
	-- 		require("diffmantic").setup()
	-- 	end,
	-- },
	-- { "sindrets/diffview.nvim", enabled = false, config = true },
	-- {
	-- 	"NeogitOrg/neogit",
	-- 	enabled = false,
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"sindrets/diffview.nvim",
	-- 	},
	-- },
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
		lazy = false,
		keys = function()
			local gitsigns = require("gitsigns")

			return {
				-- hunk
				{
					"<leader>gsh",
					gitsigns.stage_hunk,
					desc = "Stage Hunk",
				},
				{
					"<leader>grh",
					gitsigns.reset_hunk,
					desc = "Reset Hunk",
				},
				{
					mode = "v",
					"<leader>gsh",
					function()
						gitsigns.stage_hunk({
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
						gitsigns.reset_hunk({
							vim.fn.line("."),
							vim.fn.line("v"),
						})
					end,
					desc = "Reset Hunk",
				},
				{
					"<leader>gph",
					gitsigns.preview_hunk_inline,
					desc = "Preview hunk",
				},
				{
					"<leader>gsb",
					gitsigns.stage_buffer,
					desc = "Stage Buffer",
				},
				{
					"<leader>grb",
					gitsigns.reset_buffer,
					desc = "Reset Buffer",
				},
				{
					"<leader>gb",
					gitsigns.blame_line,
					desc = "Blame Line",
				},
				{
					"<leader>gB",
					gitsigns.blame,
					desc = "Toggle Blame",
				},
			}
		end,
	},
}
