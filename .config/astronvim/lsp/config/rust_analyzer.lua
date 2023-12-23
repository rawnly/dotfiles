return {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        -- default `cargo check`
        command = "clippy",
      },
      inlayHints = {
        lifetimeElisionHints = {
          enable = true,
          useParameterNames = true,
        },
      },
      files = {
        excludeDirs = {
          ".git",
          "node_modules",
          "dist",
        },
      },
    },
  },
}
