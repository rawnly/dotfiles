vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable wrap and spell for text documents",
  group = vim.api.nvim_create_augroup("auto_spell", { clear = true }),
  pattern = { "gitcommit", "text", "plaintext", "markdown" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.wrap = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Set markdown sytax for mdx files",
  group = vim.api.nvim_create_augroup("mdx", { clear = true }),
  pattern = { "markdown", "mdx" },
  callback = function() vim.opt_local.filetype = "markdown" end,
})
