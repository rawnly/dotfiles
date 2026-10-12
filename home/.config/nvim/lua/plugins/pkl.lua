---@type LazySpec
return {
	"apple/pkl-neovim",
	lazy = true,
	event = "BufReadPre *.pkl",
	ft = "pkl",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		vim.g.pkl_neovim = {
			start_command = { "pkl-lsp" },
		}
	end,
}
