---@module "lazy.nvim"
---@type LazySpec
return {
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		opts = {
			auto_enable = true,
			auto_resize_height = true,
			func_map = {
				split = "<C-s>",
			},
		},
		dependencies = {
			{
				"junegunn/fzf",
				config = function()
					vim.g.fzf_layout = {
						window = {
							width = 0.9,
							height = 0.6,
						},
					}
					vim.g.fzf_preview_window = {
						"right:50%",
						"ctrl-f:preview-half-page-down,ctrl-b:preview-half-page-up",
					}
				end,
			},
		},
	},
	{
		"stevearc/quicker.nvim",
		ft = "qf",
		---@module "quicker"
		---@type quicker.SetupOptions
		opts = {},
	},
}
