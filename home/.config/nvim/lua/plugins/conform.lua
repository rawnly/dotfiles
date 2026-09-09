return {
	"stevearc/conform.nvim",
	opts = {
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end

			return {
				timeout_ms = 500,
				lsp_format = "fallback",
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "biome", "biome-organize-imports" },
			javascriptreact = { "biome", "biome-organize-imports" },
			typescript = { "biome", "biome-organize-imports" },
			typescriptreact = { "biome", "biome-organize-imports" },
			go = { "goimports", "gofmt" },
			rust = { "rustfmt" },
			markdown = { "pruner" },
			python = { "isort", "black" },
			yaml = { "prettierd", "prettier", stop_after_first = true },
			graphql = { "prettierd", "prettier", stop_after_first = true },
			sql = { "pg_format" },
			json = { "biome", "prettierd", "prettier", stop_after_first = true },
		},
		formatters = {
			pruner = {
				command = "pruner",
				args = function(_, ctx)
					local args = { "format" }

					local textwidth = vim.api.nvim_get_option_value("textwidth", { buf = ctx.buf })

					if textwidth and textwidth > 0 then
						table.insert(args, "--print-width=" .. textwidth)
					end

					local filetype = vim.api.nvim_get_option_value("filetype", { buf = ctx.buf })
					if filetype then
						table.insert(args, "--lang=" .. filetype)
					end

					return args
				end,
			},
		},
	},
}
