-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
local options = {
	tabstop = 2,
	smartindent = true,
	shiftwidth = 2,
	expandtab = true,
	number = true,
	termguicolors = true,
	clipboard = "unnamedplus",
	foldmethod = "expr",
	foldexpr = "v:lua.vim.treesitter.foldexpr()",
	foldcolumn = "0",
	foldtext = "",
	foldlevel = 99,
	foldlevelstart = 99,
	foldnestmax = 4,
	guifont = "Berkeley Mono Variable",
	autoindent = true,
	-- search
	hlsearch = false,
	ignorecase = true,
	smartcase = true,

	-- files
	undofile = true,
	autoread = true,
	undodir = vim.fn.expand("~/.vim/undodir"),

	-- split
	splitbelow = true,
	splitright = true,

	-- floats
	winborder = "rounded",
}

for option, value in pairs(options) do
	vim.opt[option] = value
end

local globals = {
	mapleader = " ",
	maplocalleader = "\\",
}

for opt, value in pairs(globals) do
	vim.g[opt] = value
end

require("config.lazy")

vim.cmd.colorscheme("0x96f")

local theme = vim.trim(vim.fn.system("defaults read -g AppleInterfaceStyle"))

if theme ~= "Dark" then
	vim.o.background = "light"
else
	vim.o.background = "dark"
end

-- let theme = vim.system('defaults read -g AppleInterfaceStyle')
-- if theme ~= 'Dark'
-- else
-- endif

-- vim.o.background = vim.env.NVIM_BACKGROUND or "dark"

require("polish")
require("ui")

-- Pack
vim.cmd("packadd nvim.undotree")
vim.keymap.set("n", "<leader>u", require("undotree").open)
