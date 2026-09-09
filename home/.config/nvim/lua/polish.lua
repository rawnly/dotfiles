vim.filetype.add({
	pattern = {
		[".*/Caddyfile*"] = "caddy",
		[".*/.graphqlrc"] = "json",
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local lsp_keys = require("mappings.lsp")
		local mappings = require("mappings")

		mappings.setup(lsp_keys, args.buf)
	end,
})
