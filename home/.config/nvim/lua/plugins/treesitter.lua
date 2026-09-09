---@module "lazy.nvim"
---@type LazySpec
local ensure_installed = {
	"java",
	"kotlin",
	"lua",
	"vim",
	"rust",
	"go",
	"astro",
	"bash",
	"python",
	"fish",
	"zig",
	"tsx",
	"caddy",
	"nginx",
	"yaml",
	"toml",
	"css",
	"html",
	"markdown",
	"markdown_inline",
	"typescript",
	"javascript",
	"kdl",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		branch = "main",
		init = function()
			require("vim.treesitter.query").add_predicate("is-mise?", function(_, _, bufnr, _)
				local filepath = vim.api.nvim_buf_get_name(tonumber(bufnr) or 0)
				local filename = vim.fn.fnamemodify(filepath, ":t")
				return string.match(filename, ".*mise.*%.toml$") ~= nil
			end, { force = true, all = false })
		end,
		opts = {
			ensure_installed = ensure_installed,
		},
		config = function(_, opts)
			require("nvim-treesitter.install").prefer_git = true
			vim.filetype.add({
				extension = {
					grit = "grit",
				},
			})
			vim.treesitter.language.register("gritql", "grit")

			vim.api.nvim_create_autocmd("User", {
				pattern = "TSUpdate",
				callback = function()
					require("nvim-treesitter.parsers").gritql = {
						install_info = {
							url = "https://github.com/biomejs/tree-sitter-gritql",
							queries = "queries",
						},
						tier = 2,
					}
				end,
			})

			require("nvim-treesitter").setup()
			require("nvim-treesitter").install(opts.ensure_installed)

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local buf = args.buf
					local ft = args.match

					local lang = vim.treesitter.language.get_lang(ft) or ft

					if not vim.treesitter.language.add(lang) then
						return
					end

					vim.treesitter.start(buf, lang)
					-- vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}
