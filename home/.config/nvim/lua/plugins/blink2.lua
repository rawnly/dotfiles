---@module "lazy.nvim"
---@type LazySpec
return {
	"saghen/blink.cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"saghen/blink.lib",
		"rafamadriz/friendly-snippets",
		{
			"L3MON4D3/LuaSnip",
			build = "make install_jsregexp",
			config = function()
				local luasnip = require("luasnip")

				-- Loads all the snippets installed by extensions in vscode.
				-- require('luasnip.loaders.from_vscode').lazy_load()
				require("luasnip.loaders.from_vscode").load({ paths = "~/.config/nvim/snippets" })

				luasnip.config.set_config({
					-- region_check_events = "CursorMoved,CursorMovedI",
					-- delete_check_events = "TextChanged,InsertLeave",
					region_check_events = "InsertEnter",
					delete_check_events = "InsertLeave",
				})

				luasnip.config.setup({})
			end,
		},
	},
	build = function()
		require("blink.cmp").build():pwait()
	end,
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "enter",
			["<C-u>"] = { "scroll_signature_up", "fallback" },
			["<C-d>"] = { "scroll_signature_down", "fallback" },
			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
		},
		signature = {
			enabled = true,
		},
		sources = {
			default = {
				"snippets",
				"lsp",
				"path",
				"buffer",
			},
		},
		snippets = { preset = "luasnip" },
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 250,
				window = {
					border = "rounded",
				},
			},
			ghost_text = {
				enabled = true,
			},
		},
		fuzzy = {
			implementation = "rust",
			sorts = {
				"exact",
				"score",
				"sort_text",
				"kind",
			},
		},
	},
}
