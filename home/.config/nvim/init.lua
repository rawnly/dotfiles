local colo = require("colo")

-- Paint the final colors immediately, before lazy.nvim scans/loads any
-- plugin spec. This closes the window where nvim's TUI shows the
-- built-in default highlight groups (the visible startup "flash") while
-- config.lazy/colorscheme are still loading.
vim.opt.termguicolors = true
vim.o.background = "dark"

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

vim.cmd.colorscheme(colo.theme)

require("polish")
require("ui")

-- Pack
vim.cmd("packadd nvim.undotree")
vim.keymap.set("n", "<leader>u", require("undotree").open)
