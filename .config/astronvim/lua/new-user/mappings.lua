-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    ["<leader>h"] = { name = "HTTP" },
    ["<leader>hx"] = { "<Plug>RestNvim", desc = "execute request" },
    ["<leader>hp"] = { "<Plug>RestNvimPreview", desc = "preview request" },
    ["<leader>he"] = { "<cmd>RestSelectEnv .env<cr>", desc = "load current dot-env" },

    ["<CR>"] = { "ciw" },
    ["<BS>"] = { "cw" },

    ["<leader>uz"] = { "<cmd>ZenMode<CR>", desc = "Toggle Zen Mode" },
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New Buffer" },

    ["<leader>o"] = {
      "<cmd>Neotree reveal<CR>",
    },

    -- quick save
    ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command
    ["<C-q>"] = { ":q<cr>", desc = "Quit buffer" }, -- change description but the same command

    ["<leader>lR"] = { "<cmd>Telescope lsp_references<CR>", desc = "References" },
    ["<leader>fz"] = { "<cmd>Telescope zoxide list<CR>", desc = "Zoxide" },

    -- Rust
    ["<leader>r"] = { name = "Rust" },
    ["<leader>rr"] = { "<cmd>RustRunnables<CR>", desc = "Runnables" },
    ["<leader>rd"] = { "<cmd>RustDebuggables<CR>", desc = "Debuggables" },
    ["<leader>ra"] = { "<cmd>RustCodeAction<CR>", desc = "Code Actions" },
    ["<leader>rc"] = { "<cmd>RustOpenCargo<CR>", desc = "Open Cargo" },

    -- Buffer Movement
    L = {
      function()
        require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1)
      end,
      desc = "Next buffer",
    },
    H = {
      function()
        require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1))
      end,
      desc = "Previous buffer",
    },

    -- Use Glance
    ["gd"] = {
      "<cmd>Glance definitions<CR>",
      desc = "Glance definitions",
    },
    ["gr"] = {
      "<cmd>Glance references<CR>",
      desc = "Glance references",
    },
    ["gm"] = {
      "<cmd>Glance implementations<CR>",
      desc = "Glance implementations",
    },
    ["gy"] = {
      "<cmd>Glance type_definitions<CR>",
      desc = "Glance type_definitions",
    },
  },
}
