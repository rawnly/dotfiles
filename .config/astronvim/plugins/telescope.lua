return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "kkharji/sqlite.lua" },
    { "nvim-telescope/telescope-smart-history.nvim", requires = { "kkharji/sqlite.lua" } },
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-lua/popup.nvim",
    "jvgrootveld/telescope-zoxide",
  },
  opts = function(_, opts)
    local config = require "telescope.config"
    local fb_actions = require("telescope").extensions.file_browser.actions
    local vimgrep_arguments = {
      unpack(config.values.vimgrep_arguments),
    }

    table.insert(vimgrep_arguments, "--hidden")
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    return require("astronvim.utils").extend_tbl(opts, {
      pickers = {
        find_files = {
          find_command = {
            "rg",
            "--files",
            "--color=never",
            "--smart-case",
            "--trim",
            "--hidden",
            "--glob",
            "!**/.git/*",
          },
        },
      },
      defaults = {
        vimgrep_arguments,
        file_ignore_patterns = {
          "*/node_modules/*",
          "**/.git/*",
          "*/target/*",
          "*/dist/*",
          "*/build/*",
          "*/.next/*",
        },
        -- file_ignore_patterns = { "node_modules", ".next", ".DS_Store", ".git", "target", "dist", "build" },
        history = {
          path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
          limit = 1000,
        },
      },
      extensions = {
        zoxide = {
          prompt_title = "[ Walking on the moon ]",
        },
        fzf = {
          fuzzy = true,
        },
        file_browser = {
          mappings = {
            n = {
              ["<BS>"] = fb_actions.goto_parent_dir,
              ["H"] = fb_actions.toggle_hidden,
            },
            i = {
              ["<C-BS>"] = fb_actions.goto_parent_dir,
              ["<C-a>"] = fb_actions.create_from_prompt,
            },
          },
        },
      },
    })
  end,
  config = function(...)
    require "plugins.configs.telescope"(...)

    local telescope = require "telescope"
    telescope.load_extension "file_browser"
    telescope.load_extension "zoxide"
    -- telescope.load_extension "software-licenses"
  end,
}
