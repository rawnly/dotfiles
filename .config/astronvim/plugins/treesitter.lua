return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = { "lua", "rust", "typescript", "tsx", "vim", "javascript", "go", "zig" },
    swap = {
      enabled = true,
      swap_next = {
        ["<leader>sn"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>sp"] = "@parameter.inner",
      },
    },
  },
}
