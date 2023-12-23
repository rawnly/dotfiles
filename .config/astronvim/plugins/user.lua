return {
  -- zig lang
  "yasuhiroki/github-actions-yaml.vim",
  "nvim-treesitter/nvim-treesitter-context",

  -- zen mode
  {
    "folke/zen-mode.nvim",
    lazy = false,
    opts = {
      window = {
        width = 0.5,
      },
      plugins = {
        tmux = {
          enabled = true,
        },
        wezterm = {
          enabled = true,
          font = "+6",
        },
      },
    },
  },
  "folke/twilight.nvim",

  -- kitty terminal integration
  "fladson/vim-kitty",
  "knubie/vim-kitty-navigator",

  {
    "junegunn/goyo.vim",
    cmd = { "Goyo" },
  },
  ---
  "marilari88/twoslash-queries.nvim",
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
        before_open = function(results, open, jump, _method)
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
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
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
