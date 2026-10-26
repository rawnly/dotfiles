---@module "lazy.nvim"
---@type LazySpec
return {
	{
		"rawnly/targetprocess.nvim",
		dev = true,
		enabled = false,
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
		dev = true,
		enabled = vim.env.PROFILE == "work",
		ft = "yaml",
		cmd = "GhActionsVersion",
		opts = {
			trusted_orgs = { "satispay-tech" },
			trust_current_org = true,
		},
	},
	{
		"rawnly/gist.nvim",
		dev = true,
		cmd = { "GistCreate", "GistsList", "GistCreateFromFile" },
		---@type Gist.Config
		opts = {
			platform = "termbin",
		},
	},
	{
		"rawnly/nyx.nvim",
		enabled = false,
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
