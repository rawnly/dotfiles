---@module "lazy.nvim"
---@type LazySpec
return {
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		opts = {
			opts = {
				enable_close_on_slash = true,
			},
		},
	},
	-- {
	-- 	"pmizio/typescript-tools.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	-- 	ft = { "javascript", "typescript", "typescriptreact", "javascriptreact", "vue", "svelte" },
	-- 	opts = {
	-- 		---@module "typescript-tools.nvim"
	-- 		---@class Settings
	-- 		settings = {
	-- 			separate_diagnostic_server = true,
	-- 			publish_diagnostic_on = "insert_leave",
	-- 			tsserver_max_memory = 8192,
	-- 			complete_function_calls = false,
	-- 			expose_as_code_action = {},
	-- 			tsserver_file_preferences = {
	-- 				includeInlayParameterNameHints = "literals",
	-- 				includeInlayFunctionParameterTypeHints = false,
	-- 				includeInlayVariableTypeHints = false,
	-- 				includeInlayPropertyDeclarationTypeHints = false,
	-- 				includeInlayFunctionLikeReturnTypeHints = false,
	-- 				includeCompletionsForModuleExports = true,
	-- 			},
	-- 			tsserver_format_options = {
	-- 				allowIncompleteCompletions = false,
	-- 				allowRenameOfImportPath = false,
	-- 			},
	-- 		},
	-- 	},
	-- },
}
