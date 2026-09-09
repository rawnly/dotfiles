-- my own plugins
return {
	{
		"rawnly/targetprocess.nvim",
		dev = true,
		opts = {
			base_url = vim.env.TARGET_PROCESS_API_BASE_URL,
			token = vim.env.TARGET_PROCESS_ACCESS_TOKEN,
		},
		keys = {
			{
				"<leader>tv",
				"<CMD>TargetProcessView<CR>",
				desc = "View",
			},
			{
				"<leader>to",
				"<CMD>TargetProcessOpen<CR>",
				desc = "Open",
			},
		},
	},
	{
		"rawnly/gh-actions-version.nvim",
		enabled = false,
		dev = true,
		opts = {},
	},
	{
		"rawnly/gist.nvim",
		dev = true,
		---@type Gist.Config
		opts = {
			platform = "termbin",
		},
	},
	{
		"rawnly/nyx.nvim",
		dev = true,
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
			styles = {
				keywords = {
					italic = true,
					bold = true,
				},
			},
			dim_inactive = true,
			sidebars = {
				"qf",
				"help",
			},
			plugins = { auto = true },
		},
	},
}
