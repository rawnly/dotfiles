return {
  "nvim-treesitter/nvim-treesitter-context",
  "yasuhiroki/github-actions-yaml.vim",
  "folke/neodev.nvim",
  {
    "rest-nvim/rest.nvim",
    lazy = false,
    dependencies = {
      {
        "nvim-lua/plenary.nvim",
      },
    },
    config = function()
      require("rest-nvim").setup {
        highlight = {
          enabled = true,
        },
      }
    end,
  },
  {
    "wfxr/minimap.vim",
    lazy = false,
  },
  {
    "nacro90/numb.nvim",
    lazy = false,
    opts = {
      show_numbers = true,
      show_cursorline = true,
    },
  },
  {
    "wakatime/vim-wakatime",
    lazy = false,
  },
  {
    "dnlhc/glance.nvim",
    cmd = { "Glance" },
    opts = {
      hooks = {
        before_open = function(results, open, jump)
          if #results == 1 then
            jump(results[1])
          else
            open(results)
          end
        end,
      },
    },
  },
  {
    "samjwill/nvim-unception",
    lazy = false,
    init = function() vim.g.unception_block_while_host_edits = true end,
  },
  {
    "mvllow/modes.nvim",
    as = "modes",
    lazy = false,
    opts = function()
      return {
        line_opacity = 0.25,
      }
    end,
  },
}
