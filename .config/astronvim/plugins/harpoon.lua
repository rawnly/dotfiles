local prefix = "<leader><leader>"

return {
  "ThePrimeagen/harpoon",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = { "Harpoon" },
  keys = {
    {
      prefix,
      desc = "Harpoon",
    },
    {
      prefix .. "a",
      function() require("harpoon.mark").add_file() end,
      desc = "Add File",
    },
    {
      prefix .. "c",
      function() require("harpoon.mark").clear_all() end,
      desc = "Clear All Marks",
    },
    {
      prefix .. "d",
      function() require("harpoon.mark").rm_file() end,
      desc = "Remove File",
    },
    {
      prefix .. "e",
      function() require("harpoon.ui").toggle_quick_menu() end,
      desc = "Quick Menu",
    },
    {
      prefix .. "f",
      "<cmd>Telescope harpoon marks<CR>",
      desc = "Find Mark",
    },
    {
      "<C-n>",
      function() require("harpoon.ui").nav_next() end,
      desc = "Go to next mark",
    },
    {
      "<C-p>",
      function() require("harpoon.ui").nav_prev() end,
      desc = "Go to previous mark",
    },
  },
}
