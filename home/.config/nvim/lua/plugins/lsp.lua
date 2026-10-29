---@module "lazy.nvim"
---@type LazySpec
return {
	"b0o/schemastore.nvim",
	{
		"folke/trouble.nvim",
		-- for default options, refer to the configuration section for custom setup.
		opts = {},
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>xl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"DNLHC/glance.nvim",
		cmd = "Glance",
		opts = {
			border = {
				enable = true,
			},
			hooks = {
				-- jump to definition if the result is just 1
				before_open = function(results, open, jump)
					if #results == 1 then
						jump(results[1])
					else
						open(results)
					end
				end,
			},
		},
		keys = {
			{ "gr", "<CMD>Glance references<CR>", desc = "Go to references" },
			{ "gd", "<CMD>Glance definitions<CR>", desc = "Go to definitions" },
			{ "gt", "<CMD>Glance type_definitions<CR>", desc = "Go to type-definitions" },
			{ "gR", "<CMD>Glance resume<CR>", desc = "Resume goto" },
		},
	},
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			{
				"<leader>lS",
				"<cmd>Outline!<CR>",
				desc = "Show Outline",
			},
		},
		config = function()
			local icons = require("icons")

			require("outline").setup({
				outline_window = {
					wrap = false,
					position = "right",
					auto_jump = true,
				},
				preview_window = {
					border = "solid",
					winblend = 2,
				},
				symbols = {
					icons = {
						File = { icon = icons.lsp.File, hl = "Identifier" },
						Module = { icon = icons.lsp.Module, hl = "Include" },
						Namespace = { icon = icons.lsp.Namespace, hl = "Include" },
						Package = { icon = icons.lsp.Package, hl = "Include" },
						Class = { icon = icons.lsp.Class, hl = "Type" },
						Method = { icon = icons.lsp.Method, hl = "Function" },
						Property = { icon = icons.lsp.Property, hl = "Identifier" },
						Field = { icon = icons.lsp.Field, hl = "Identifier" },
						Constructor = { icon = icons.lsp.Constructor, hl = "Special" },
						Enum = { icon = icons.lsp.Enum, hl = "Type" },
						Interface = { icon = icons.lsp.Interface, hl = "Type" },
						Function = { icon = icons.lsp.Function, hl = "Function" },
						Variable = { icon = icons.lsp.Variable, hl = "Constant" },
						Constant = { icon = icons.lsp.Constant, hl = "Constant" },
						String = { icon = icons.lsp.String, hl = "String" },
						Number = { icon = icons.lsp.Number, hl = "Number" },
						Boolean = { icon = icons.lsp.Boolean, hl = "Boolean" },
						Array = { icon = icons.lsp.Array, hl = "Constant" },
						Object = { icon = icons.lsp.Object, hl = "Type" },
						Key = { icon = icons.lsp.Keyword, hl = "Type" },
						Null = { icon = icons.lsp.Null, hl = "Type" },
						EnumMember = { icon = icons.lsp.EnumMember, hl = "Identifier" },
						Struct = { icon = icons.lsp.Struct, hl = "Structure" },
						Event = { icon = icons.lsp.Event, hl = "Type" },
						Operator = { icon = icons.lsp.Operator, hl = "Identifier" },
						TypeParameter = { icon = icons.lsp.TypeParameter, hl = "Identifier" },
						Component = { icon = icons.lsp.Component, hl = "Function" },
						Fragment = { icon = icons.lsp.Fragment, hl = "Constant" },
						TypeAlias = { icon = icons.lsp.TypeParameter, hl = "Type" },
						Parameter = { icon = icons.lsp.Field, hl = "Identifier" },
						StaticMethod = { icon = icons.lsp.Method, hl = "Function" },
						Macro = { icon = icons.lsp.Text, hl = "Function" },
					},
				},
			})
		end,
	},
	{
		"folke/which-key.nvim",
		keys = {
			{ "<leader>lr", vim.lsp.buf.rename, desc = "Rename" },
			{
				"<leader>lf",
				function()
					require("conform").format({
						async = true,
						lsp_format = "fallback",
					})
				end,
				desc = "Format",
			},
			{ "<leader>la", vim.lsp.buf.code_action, desc = "Code Actions" },
			{ "<leader>ld", vim.diagnostic.open_float, desc = "Hover Diagnostics" },
			{
				"<leader>lh",
				function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
				end,
				desc = "Toggle inlay hints",
			},
		},
	},
}
