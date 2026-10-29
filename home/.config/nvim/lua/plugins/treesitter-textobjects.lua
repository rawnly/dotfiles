---@type LazySpec
return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
			},
			move = {
				set_jumps = true,
			},
		})
	end,
	keys = function()
		local tselect = require("nvim-treesitter-textobjects.select")
		local tswap = require("nvim-treesitter-textobjects.swap")

		return {
			{
				"af",
				function()
					tselect.select_textobject("@function.outer")
				end,
				mode = { "x", "o" },
				desc = "Around function",
			},
			{
				"if",
				function()
					tselect.select_textobject("@function.inner")
				end,
				mode = { "x", "o" },
				desc = "Inside function",
			},
			{
				"ap",
				function()
					require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects")
				end,
				mode = { "x", "o" },
				desc = "Around parameter",
			},
			{
				"ip",
				function()
					require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects")
				end,
				mode = { "x", "o" },
				desc = "Inside parameter",
			},
			{
				"ab",
				function()
					require("nvim-treesitter-textobjects.select").select_textobject("@block.outer", "textobjects")
				end,
				mode = { "x", "o" },
				desc = "Around block",
			},
			{
				"ib",
				function()
					require("nvim-treesitter-textobjects.select").select_textobject("@block.inner", "textobjects")
				end,
				mode = { "x", "o" },
				desc = "Inside block",
			},
			{
				"sl",
				function()
					tswap.swap_next("@parameter.inner")
				end,
				mode = "n",
				desc = "Swap Next",
			},
			{
				"sh",
				function()
					tswap.swap_previous("@parameter.inner")
				end,
				mode = "n",
				desc = "Swap Prev",
			},
			{
				"[p",
				function()
					require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.inner", "textobjects")
				end,
				mode = { "n", "x", "o" },
				desc = "Previous parameter start",
			},
			{
				"[P",
				function()
					require("nvim-treesitter-textobjects.move").goto_previous_end("@parameter.inner", "textobjects")
				end,
				mode = { "n", "x", "o" },
				desc = "Previous parameter end",
			},
			{
				"]p",
				function()
					require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.inner", "textobjects")
				end,
				mode = { "n", "x", "o" },
				desc = "Next parameter start",
			},
			{
				"]P",
				function()
					require("nvim-treesitter-textobjects.move").goto_next_end("@parameter.inner", "textobjects")
				end,
				mode = { "n", "x", "o" },
				desc = "Next parameter end",
			},
			{
				"]]",
				function()
					require("nvim-treesitter-textobjects.move").goto_next_start("@function.inner", "textobjects")
				end,
				mode = { "n", "x", "o" },
				desc = "Next function start",
			},
			{
				"[[",
				function()
					require("nvim-treesitter-textobjects.move").goto_previous_start("@function.inner", "textobjects")
				end,
				mode = { "n", "x", "o" },
				desc = "Previous function start",
			},
			{
				"[]",
				function()
					require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
				end,
				mode = { "n", "x", "o" },
				desc = "Previous function end",
			},
			{
				"][",
				function()
					require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
				end,
				mode = { "n", "x", "o" },
				desc = "Next function end",
			},
		}
	end,
}
