return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    --@type Flash.Config
    opts = {
      label = {
        rainbow = {
          enabled = true,
        },
      },
      modes = {
        char = {
          enabled = false,
          jump_labels = true,
          autohide = true,
        },
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump {
            search = {
              mode = function(str) return "\\<" .. str end,
            },
          }
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function() require("flash").treesitter() end,
        desc = "Flash Treesitter",
      },
    },
  },
}
