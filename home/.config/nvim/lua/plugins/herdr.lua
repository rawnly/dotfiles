return {
	{
		"ChmaraX/herdr-nvim",
		event = "VeryLazy",
		enabled = vim.env.HERDR_ENV == 1,
		opts = {},
	},
	{
		"rawnly/rex-nvim",
		opts = {},
		event = "VeryLazy",
		dev = true,
	},
}
