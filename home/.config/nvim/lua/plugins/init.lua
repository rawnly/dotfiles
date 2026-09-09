---@module "lazy.nvim"
---@type LazySpec
return {
  "b0o/schemastore.nvim",
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
}
