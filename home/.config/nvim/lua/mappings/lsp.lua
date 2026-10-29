---@type KeyMapping[]
return {
	{
		"<leader>lr",
		function()
			vim.lsp.buf.rename()
		end,
		desc = "Rename",
	},
	{
		"<leader>lf",
		function(bufnr)
			require("conform").format({
				async = true,
				bufnr = bufnr,
				lsp_format = "fallback",
			})
		end,
		desc = "Format",
	},
	{
		"<leader>la",
		function()
			vim.lsp.buf.code_action()
		end,
		desc = "Code Actions",
	},
	{
		"<leader>ld",
		function(bufnr)
			vim.diagnostic.open_float({
				bufnr = bufnr,
			})
		end,
		desc = "Hover Diagnostics",
	},
	{
		"<leader>lh",
		function(bufnr)
			local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
			vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = bufnr })
		end,
		desc = "Toggle Inlay Hints",
	},
}
