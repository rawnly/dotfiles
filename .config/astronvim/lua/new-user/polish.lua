return function()
  local utils = require "user.utils"

  -- Copy git url
  vim.api.nvim_create_user_command("CopyGitUrl", function() utils.copy_git_url() end, {
    desc = "Copy the current file path and line number to the clipboard",
    nargs = 0,
  })

  -- Enable spell and wrap for text documents
  vim.api.nvim_create_autocmd("FileType", {
    desc = "Enable wrap and spell for text documents",
    group = vim.api.nvim_create_augroup("auto_spell", { clear = true }),
    pattern = { "gitcommit", "text", "plaintext", "markdown" },
    callback = function()
      vim.opt_local.spell = true
      vim.opt_local.wrap = true
    end,
  })

  -- Set markdown syntax for mdx files
  vim.api.nvim_create_autocmd("FileType", {
    desc = "Set markdown sytax for mdx files",
    group = vim.api.nvim_create_augroup("mdx", { clear = true }),
    pattern = { "markdown", "mdx" },
    callback = function() vim.opt_local.filetype = "markdown" end,
  })

  -- create an augroup to easily manage autocommands
  vim.api.nvim_create_augroup("autohidetabline", { clear = true })
  -- create a new autocmd on the "User" event
  vim.api.nvim_create_autocmd("User", {
    desc = "Hide tabline when only one buffer and one tab", -- nice description
    -- triggered when vim.t.bufs is updated
    pattern = "AstroBufsUpdated",                           -- the pattern is the name of our User autocommand events
    group = "autohidetabline",                              -- add the autocmd to the newly created augroup
    callback = function()
      -- if there is more than one buffer in the tab, show the tabline
      -- if there are 0 or 1 buffers in the tab, only show the tabline if there is more than one vim tab
      local new_showtabline = #vim.t.bufs > 1 and 2 or 1
      -- check if the new value is the same as the current value
      if new_showtabline ~= vim.opt.showtabline:get() then
        -- if it is different, then set the new `showtabline` value
        vim.opt.showtabline = new_showtabline
      end
    end,
  })
end
