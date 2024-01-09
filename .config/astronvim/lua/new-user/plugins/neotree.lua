return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		config = function()
			require("neo-tree").setup({
				nesting_rules = {
					["go"] = {
						pattern = "(.*)%.go$",
						files = { "%1_test.go" },
					},
					[".env"] = {
						pattern = "^%.env$",
						files = { "*.env", ".env.*", ".envrc", "env.d.ts" },
					},
					["docker"] = {
						pattern = "^dockerfile$",
						ignore_case = true,
						files = { ".dockerignore", "docker-compose.*", "dockerfile*" },
					},
					["ts"] = {
						pattern = "(.+)%.ts$",
						files = { "%1.test.ts", "%1.spec.ts" },
					},
					["js"] = {
						pattern = "(.+)%.js$",
						files = { "%1.js.map", "%1.min.js", "%1.d.ts" },
					},
					["next-config"] = {
						pattern = "next.config.js",
						files = {
							"next-env.d.ts",
							".next",
						},
					},
					["tsconfig"] = {
						pattern = "^tsconfig%.json$",
						files = {
							"tsconfig.*.json",
						},
					},
					["package"] = {
						pattern = "^package%.json$",
						files = {
							"package-lock.json",
							"pnpm*",
							"yarn*",
							".eslint*",
							".prettier*",
							"*.config.json",
							".npm*",
							"bun.lockb",
						},
					},
				},
			})
		end,
	},
}
