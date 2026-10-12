---@module "lazy.nvim"
---@type LazySpec
return {
	{
		"mrcjkb/rustaceanvim",
		ft = "rust",
		version = "^9", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
}
