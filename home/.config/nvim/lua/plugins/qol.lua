---@module "lazy.nvim"
---@type LazySpec
return {
	"nvim-tree/nvim-web-devicons",
	{
		"folke/lazydev.nvim",
		ft = "lua",
		dependencies = { "DrKJeff16/wezterm-types" },
		opts = {
			library = {
				{ path = "snacks.nvim", words = { "Snacks" } },
				{ path = "lazy.nvim", words = { "LazyVim", "LazySpec" } },
				{ path = "tabby", words = { "TabbyConfig" } },
				{ path = "wezterm-types", mods = { "wezterm" } },
			},
		},
	},
	{
		"mvllow/modes.nvim",
		event = "VeryLazy",
		opts = {},
	},
	-- {
	--   "gelguy/wilder.nvim",
	--   lazy = false,
	--   opts = {
	--     modes = { ":", "?", "/" },
	--   },
	-- },
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		opts = {},
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		opts = {
			provider_selector = function()
				return { "treesitter", "indent" }
			end,
		},
		keys = {
			{
				"zR",
				function()
					require("ufo").openAllFolds()
				end,
				desc = "open all folds",
			},
			{
				"zM",
				function()
					require("ufo").closeAllFolds()
				end,
				desc = "close all folds",
			},
		},
	},
}
