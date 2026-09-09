---@type LazySpec
-- lazy.nvim
return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		event = "VeryLazy",
		enabled = true,
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				close_command = function(n)
					Snacks.bufdelete(n)
				end,
				right_mouse_command = function(n)
					Snacks.bufdelete(n)
				end,
				always_show_bufferline = false,
			},
		},
		keys = {
			{ "<S-h>", "<CMD>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
			{ "<S-l>", "<CMD>BufferLineCycleNext<CR>", desc = "Next Buffer" },
			{
				"<leader>c",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete Buffer",
			},
			{ "<leader>bp", "<CMD>BufferLineTogglePin<CR>", desc = "Pin Buffer" },
			{ "<leader>bc", "<CMD>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		enabled = true,
		opts = function()
			return {
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				extensions = {
					"nvim-dap-ui",
					"quickfix",
					"fzf",
					"lazy",
					"oil",
					"trouble",
					"toggleterm",
					"mason",
				},
				options = {
					globalstatus = vim.o.laststatus == 3,
					disabled_filetypes = {
						statusline = {
							"dashboard",
						},
					},
				},
				sections = {
					lualine_a = { "branch" },
					lualine_b = { "filename" },

					lualine_c = {
						-- "filename",
					},

					lualine_x = {
						"diagnostics",
						"oil",
					},

					lualine_y = { "lsp_status" },

					lualine_z = {},
				},
			}
		end,
	},
}
