return {
	{
		"ChmaraX/herdr-nvim",
		event = "VeryLazy",
		enabled = vim.env.HERDR_ENV == 1,
		opts = {},
	},
	{
		"rawnly/rex.nvim",
		dir = "~/Developer/nvim-plugins/rawnly/rex-nvim",
		event = "VeryLazy",
		enabled = vim.env.REX_SERVER ~= nil,
		opts = {
			agent_scope = "tab",
			preferred_agent = {
				cmd = "claude",
				split = "right",
				float = true,
				submit = true,
				ratio = 30,
			},
		},
	},
}
