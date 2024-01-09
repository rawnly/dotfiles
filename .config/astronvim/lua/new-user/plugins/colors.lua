return {
  "rileytwo/kiss",
  "sainnhe/everforest",
  "wuelnerdotexe/vim-enfocado",
  { "chriskempson/base16-vim", lazy = false },
  "folke/tokyonight.nvim",
  "sainnhe/gruvbox-material",
  "nyoom-engineering/oxocarbon.nvim",
  "ellisonleao/gruvbox.nvim",
  "lunacookies/vim-substrata",
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("bamboo").setup {}
      require("bamboo").load()
    end,
  },
  {

    "xero/miasma.nvim",
    lazy = false,
    priority = 1000,
  },
  "mcchrish/zenbones.nvim",
  "rktjmp/lush.nvim", -- required by zenbons
  {
    "olivercederborg/poimandres.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("poimandres").setup {
        -- leave this setup function empty for default config
        -- or refer to the configuration section
        -- for configuration options
      }
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      local c = require("kanagawa.colors").setup({ theme = "dragon" }).palette

      local BG = c.dragonBlack3
      local ALMOST_BG = c.dragonBlack4
      local WHITE = "#9da2af"
      local GRAY = "#80838f"
      local FADED_GRAY = "#33373a"
      local STRONG_FADED_GRAY = "#2a2d30"

      return {
        compile = true,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
        overrides = function(colors)
          local overrides = {
            -- bufferline
            BufferLineFill = { bg = BG },
            BufferLineBackground = { bg = BG, fg = FADED_GRAY }, -- unactive tabs to faded gray
            BufferLineSeparator = { fg = BG },
            BufferLineModified = { fg = BG },
            BufferlineBufferSelected = { fg = GRAY }, -- active tabs to gray
            BufferlineBufferVisible = { fg = GRAY },  -- active tabs to gray
            BufferLineIndicatorVisible = { fg = BG },

            -- indentline
            IndentBlanklineChar = { fg = ALMOST_BG },

            -- GitSigns
            GitSignsAdd = { fg = c.oniViolet },
            GitSignsAddNr = { fg = c.oniViolet },
            GitSignsAddLn = { fg = c.oniViolet },
            GitSignsChange = { fg = c.oniViolet },
            GitSignsChangeNr = { fg = c.oniViolet },
            GitSignsChangeLn = { fg = c.oniViolet },
            GitSignsCurrentLineBlame = { fg = FADED_GRAY },

            -- NvimTree
            NvimTreeGitDirty = { fg = c.oniViolet },
            NvimTreeGitStaged = { fg = c.oniViolet },
            NvimTreeGitMerge = { fg = c.oniViolet },
            NvimTreeGitRenamed = { fg = c.oniViolet },
            NvimTreeGitNew = { fg = c.oniViolet },
            NvimTreeGitDeleted = { fg = c.oniViolet },
            NvimTreeFolderName = { fg = WHITE },
            NvimTreeOpenedFolderName = { fg = WHITE },
            NvimTreeEmptyFolderName = { fg = WHITE },
            NvimTreeRootFolder = { fg = GRAY },
            NvimTreeSpecialFile = { fg = WHITE, bold = true },
            NvimTreeNormalFloat = { bg = BG },
            NvimTreeCursorLine = { bg = ALMOST_BG },
            NvimTreeIndentMarker = { fg = STRONG_FADED_GRAY },
            NvimTreeImageFile = { fg = WHITE },
            NvimTreeFolderIcon = { fg = GRAY },
            NvimTreeFolderIconOpen = { fg = GRAY },
            NvimTreeFolderSymlink = { fg = GRAY },
            NvimTreeDefault = { fg = GRAY },
            NvimTreeSymlink = { fg = GRAY },
            NvimTreeBookmark = { fg = GRAY },
          }
          return overrides
        end,
      }
    end,
    -- { "srcery-colors/srcery-vim", as = "srcery" },
    -- "jaredgorski/SpaceCamp",
    -- "Shatur/neovim-ayu",
    -- "cocopon/iceberg.vim",
    -- "nikolvs/vim-sunbather",
    -- "Mofiqul/adwaita.nvim",
    -- {
    --   "marko-cerovac/material.nvim",
    --   opts = {
    --     plugins = {
    --       "telescope",
    --       "dap",
    --       "which-key",
    --     },
    --   },
    -- },
    -- {
    --   "AlexvZyl/nordic.nvim",
    --   lazy = false,
    --   priority = 1000,
    --   config = function() require("nordic").load() end,
    -- },
  },
}
