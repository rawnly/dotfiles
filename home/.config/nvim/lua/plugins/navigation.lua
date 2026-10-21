return {
	{
		"aimdevlee/herdr-nvim-nav",
		event = "VeryLazy",
		dependencies = { "christoomey/vim-tmux-navigator" }, -- omit if with_tmux = false
		enabled = vim.env.HERDR_ENV == 1,
		config = function()
			require("herdr-nvim-nav").setup()
		end,
	},
	{
		"mrjones2014/smart-splits.nvim",
		version = "^3.0.0",
		dependencies = {
			{
				"rawnly/smart-splits-backend-rex",
				dev = true,
				opts = {},
			},
		},
		opts = {
			mux = {
				backend = "smart-splits-backend-rex",
			},
		},
		keys = function()
			local ss = require("smart-splits")

			return {
				{ "|", ":vsplit<CR>" },
				{ "-", ":split<CR>" },
				-- resize splits
				{ "<A-h>", ss.resize_left },
				{ "<A-k>", ss.resize_up },
				{ "<A-j>", ss.resize_down },
				{ "<A-l>", ss.resize_right },
				-- moving between splits
				{
					"<C-h>",
					function()
						ss.move_cursor_left({
							at_edge = "split",
						})
					end,
				},
				{
					"<C-l>",
					function()
						ss.move_cursor_right({
							at_edge = "split",
						})
					end,
				},
				{ "<C-j>", ss.move_cursor_down },
				{ "<C-k>", ss.move_cursor_up },
			}
		end,
	},
}
