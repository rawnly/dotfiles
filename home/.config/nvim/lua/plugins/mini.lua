return {
	{
		"nvim-mini/mini.basics",
		version = "*",
		opts = {},
	},
	{
		"nvim-mini/mini.surround",
		version = "*",
		opts = {},
	},
	{
		"nvim-mini/mini.comment",
		version = "*",
		opts = {},
	},
	{
		"nvim-mini/mini.pairs",
		version = "*",
		opts = {},
	},
	{
		"nvim-mini/mini.starter",
		enabled = false,
		version = "*",
		config = function()
			local starter = require("mini.starter")
			local bivio = require("bivio")

			local function openProject(path)
				return function()
					vim.cmd("cd " .. path)
					require("persistence").load()
					vim.cmd("Outline")
				end
			end

			starter.setup({
				autoopen = true,
				evaluate_single = true,
				items = {
					{ name = "Edit new buffer", action = "enew", section = "Builtin actions" },
					{ name = "Quit Neovim", action = "qall", section = "Builtin actions" },

					{ name = "nvim", action = "e ~/.config/nvim/init.lua", section = "Config" },
					{ name = "ghostty", action = "e ~/.config/ghostty/config", section = "Config" },
					{ name = "fish", action = "e ~/.config/fish/config.fish", section = "Config" },

					require("bivio").starter_section(),
				},
				content_hooks = {
					starter.gen_hook.adding_bullet(),
					starter.gen_hook.aligning("center", "center"),
				},
				header = table.concat({
					"                       .-.              ",
					"                      |_:_|             ",
					"                     /(_Y_)\\            ",
					".                   ( \\/M\\/ )           ",
					" '.               _.'-/'-'\\-'._         ",
					"   ':           _/.--'[[[[]'--.\\_       ",
					"     ':        /_'  : |::\"| :  '.\\      ",
					"       ':     //   ./ |oUU| \\.'  :\\     ",
					"         ':  _:'..' \\_|___|_/ :   :|    ",
					"           ':.  .'  |_[___]_|  :.':\\    ",
					"            [::\\ |  :  | |  :   ; : \\   ",
					"             '-'   \\/'.| |.' \\  .;.' |  ",
				}, "\n"),
			})
		end,
	},
}
