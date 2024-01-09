return {
  on_attach = function(client, bufnr) require("twoslash-queries").attach(client, bufnr) end,
  settings = {
    cmd = { "typescript-language-server", "--stdio" },
    typescript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayParameterNameHints = "all", -- "none" | "literals" | "all",
      },
    },
  },
}
