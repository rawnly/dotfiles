return {
	{
		"mfussenegger/nvim-lint",
		optional = true,
		opts = {
			linters_by_ft = {
				["dockerfile"] = { "hadolint" },
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		event = "VeryLazy",
		opts = {
			automatic_enable = {
				exclude = {
					-- TypeScript 7's native LSP is configured as `tsc` below.
					"ts_ls",
					"vtsls",
					"tsgo",
					-- nvim-java and rustaceanvim own their language-server setup.
					"jdtls",
					"rust_analyzer",
				},
			},
			ensure_installed = {
				"gopls",
				"zls",
				"biome",
				"jsonls",
				"yamlls",
				"tombi",
				"docker_compose_language_service",
				"lua_ls",
				"tsc",
				-- "docker-language-server",
				-- "fish-lsp",
				-- "css-lsp",
				-- "rust-analyzer",
				-- "ty",
				-- "uv",
				-- "rustywind",
				-- "shellcheck",
				-- "pyright",
				"jdtls",
				"ruff",
				"ty",
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
			"b0o/schemastore.nvim",
		},
	},
}
