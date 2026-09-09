---@type vim.lsp.Config
return {
	settings = {
		yaml = {
			schemaStore = {
				enable = true,
				url = "",
			},
			schemas = require("schemastore").yaml.schemas(),
			validate = { enable = true },
		},
	},
}
