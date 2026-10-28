---@type LazySpec
return {
	{
		"rawnly/0x96f.nvim",
		priority = 1000,
		opts = { transparent = true },
		dev = true,
	},
	{
		"ThorstenRhau/token",
		enabled = false,
		version = "*",
		opts = {
			plugins = {
				all = true,
			},
		},
	},
	{
		"RRethy/base16-nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function() end,
	},
	{
		"Aejkatappaja/sora",
		enabled = false,
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"wtfox/luna.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		enabled = true,
		opts = {
			options = {
				transparent = false,
				styles = {
					comments = "italic",
					keywords = "bold",
					types = "italic,bold",
				},
			},
		},
	},
	{
		"rebelot/kanagawa.nvim",
		enabled = false,
		opts = {},
	},
	{
		"jpwol/thorn.nvim",
		enabled = false,
		priority = 1000,
		opts = {},
	},
	{
		"ember-theme/nvim",
		name = "ember",
		enabled = false,
		priority = 1000,
		opts = { variant = "ember" },
	},
	{
		"scottmckendry/cyberdream.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		opts = {
			variant = "auto",
			transparent = true,
		},
	},
	{
		"0xleodevv/oc-2.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
	},
	{
		"oskarnurm/koda.nvim",
		enabled = true,
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		opts = {},
	},
	{
		"folke/tokyonight.nvim",
		lazy = true,
		priority = 1000,
		enabled = true,
		opts = {
			style = "night",
			transparent = true,
			styles = {
				keywords = {
					italic = true,
					bold = true,
				},
			},
			dim_inactive = true,
		}, -- Or 'day'/'moon'
	},
}
