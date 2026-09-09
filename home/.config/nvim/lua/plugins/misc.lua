return {
	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"Sebastian-Nielsen/better-type-hover",
		ft = { "typescript", "typescriptreact" },
		config = function()
			require("better-type-hover").setup()
		end,
	},
}
