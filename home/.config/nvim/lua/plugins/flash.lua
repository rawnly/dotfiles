return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      modes = {
        char = {
          jump_labels = true,
        },
        search = {
          enabled = true,
          highlight = { backdrop = false },
          jump = { history = true, register = true, nohlsearch = true },
        },
      },
      jump = {
        autojump = true,
      },
      label = {
        style = "overlay",
        rainbow = {
          enabled = true,
          shade = 4,
        },
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "<leader>R",
        mode = "n",
        desc = "Remote Replace Character",
        function()
          local flash = require("flash")
          local state = {
            win = vim.api.nvim_get_current_win(),
            pos = vim.api.nvim_win_get_cursor(0),
          }

          flash.jump({
            action = function(match)
              -- Move to the target
              vim.api.nvim_win_set_cursor(match.win, match.pos)

              -- Feed "r" to start the native replace
              vim.api.nvim_feedkeys("r", "n", true)

              -- Set a one-time autocmd to jump back after the next character is typed
              vim.api.nvim_create_autocmd("LspTokenUpdate", { -- Using a generic event or ModeChanged
                once = true,
                callback = function()
                  -- This is a bit hacky, so we use a timer to ensure the 'r' finishes
                  vim.schedule(function()
                    if vim.api.nvim_win_is_valid(state.win) then
                      vim.api.nvim_set_current_win(state.win)
                      vim.api.nvim_win_set_cursor(state.win, state.pos)
                    end
                  end)
                end,
              })

              -- Fallback: If the autocmd is too complex, we use a simpler ModeChanged
              vim.api.nvim_create_autocmd("ModeChanged", {
                pattern = "r:n", -- When moving from 'replace' mode back to 'normal'
                once = true,
                callback = function()
                  vim.schedule(function()
                    vim.api.nvim_win_set_cursor(state.win, state.pos)
                  end)
                end,
              })
            end,
          })
        end,
      },
    },
  },
}
