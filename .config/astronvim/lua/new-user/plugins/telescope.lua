return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "kkharji/sqlite.lua" },
		{ "nvim-telescope/telescope-smart-history.nvim", requires = { "kkharji/sqlite.lua" } },
		"nvim-lua/popup.nvim",
		"jvgrootveld/telescope-zoxide",
	},
	opts = function(_, opts)
		local config = require("telescope.config")
		local vimgrep_arguments = {
			unpack(config.values.vimgrep_arguments),
		}

		table.insert(vimgrep_arguments, "--hidden")
		table.insert(vimgrep_arguments, "--glob")
		table.insert(vimgrep_arguments, "!**/.git/*")

		return require("astronvim.utils").extend_tbl(opts, {
			pickers = {
				find_files = {
					find_command = {
						"rg",
						"--files",
						"--color=never",
						"--smart-case",
						"--trim",
						"--hidden",
						"--glob",
						"!**/.git/*",
					},
				},
			},
			defaults = {
				vimgrep_arguments,
				file_ignore_patterns = {
					"*/node_modules/*",
					"**/.git/*",
					"*/target/*",
					"*/dist/*",
					"*/build/*",
					"*/.next/*",
				},
				history = {
					path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
					limit = 1000,
				},
			},
			extensions = {
				zoxide = {
					prompt_title = "[ Walking on the moon ]",
				},
				fzf = {
					fuzzy = true,
				},
			},
		})
	end,
	config = function(...)
		require("plugins.configs.telescope")(...)

		local telescope = require("telescope")
		telescope.load_extension("zoxide")
		-- telescope.load_extension "software-licenses"
	end,
}
