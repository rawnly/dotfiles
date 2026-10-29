return {
	{
		"ChmaraX/herdr-nvim",
		event = "VeryLazy",
		enabled = vim.env.HERDR_ENV == 1,
		opts = {},
	},
	{
		"rawnly/rex.nvim",
		event = "VeryLazy",
		dev = true,
		opts = {
			agent_scope = "tab",
			preferred_agent = {
				cmd = "pi",
				split = "right",
				ratio = 50,
			},
		},
	},
}
