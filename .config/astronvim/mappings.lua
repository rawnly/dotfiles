-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    ["<CR>"] = { "ciw" },
    ["<BS>"] = { "cw" },
    ["<leader>uz"] = { "<cmd>ZenMode<CR>", desc = "Toggle Zen Mode" },
    ["<leader>b"] = { name = "Buffers" },
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- quick save
    ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command
    ["<C-q>"] = { ":q<cr>", desc = "Quit buffer" }, -- change description but the same command
    -- Sneak
    -- ["f"] = { "<cmd>call sneak#wrap('', 1, 0, 1, 1)<CR>" }, -- cmd
    -- ["F"] = { "<cmd>call sneak#wrap('', 1, 1, 1, 1)<CR>" }, -- cmd
    -- ["<leader><leader>"] = { "<cmd>Telescope frecency<CR>", desc = "Frecency" },
    ["<leader>e"] = { "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "File Browser" },
    ["<leader>lR"] = { "<cmd>Telescope lsp_references<CR>", desc = "References" },
    ["<leader>fe"] = { "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "File Browser" },
    ["<leader>fz"] = { "<cmd>Telescope zoxide list<CR>", desc = "Zoxide" },
    ["<leader>r"] = { name = "Rust" },
    ["<leader>rr"] = { "<cmd>RustRunnables<CR>", desc = "Runnables" },
    ["<leader>rd"] = { "<cmd>RustDebuggables<CR>", desc = "Debuggables" },
    ["<leader>ra"] = { "<cmd>RustCodeAction<CR>", desc = "Code Actions" },
    ["<leader>rc"] = { "<cmd>RustOpenCargo<CR>", desc = "Open Cargo" },
    -- ["<leader>fl"] = { "<cmd>Telescope software-licenses find<CR>", desc = "Find licenses" },
    L = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    H = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
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
