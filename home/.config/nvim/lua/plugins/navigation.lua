return {
	{
		"mrjones2014/smart-splits.nvim",
		lazy = false,
		build = "./kitty/install-kittens.bash",
		keys = {
			{ "|", ":vsplit<CR>" },
			-- resize splits
			{
				"<A-h>",
				function()
					require("smart-splits").resize_left()
				end,
			},
			{
				"<A-k>",
				function()
					require("smart-splits").resize_up()
				end,
			},
			{
				"<A-j>",
				function()
					require("smart-splits").resize_down()
				end,
			},
			{
				"<A-l>",
				function()
					require("smart-splits").resize_right()
				end,
			},
			-- moving between splits
			{
				"<C-h>",
				function()
					require("smart-splits").move_cursor_left()
				end,
				mode = { "n", "i", "t" },
			},
			{
				"<C-j>",
				function()
					require("smart-splits").move_cursor_down()
				end,
				mode = { "n", "i", "t" },
			},
			{
				"<C-k>",
				function()
					require("smart-splits").move_cursor_up()
				end,
				mode = { "n", "i", "t" },
			},
			{
				"<C-l>",
				function()
					require("smart-splits").move_cursor_right()
				end,
				mode = { "n", "i", "t" },
			},
		},
	},
}
