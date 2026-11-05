-- Entry point. Order matters: plugins, then actions, then the keys that bind them.
local HOME = os.getenv("HOME")
local amber_path = HOME .. "/.local/share/rex/amber/amber.lua"
local dev_amber_path = HOME .. "/Developer/projects/amber/amber.lua"

local use_dev = false

local amber = dofile(use_dev and dev_amber_path or amber_path)


amber.setup({
  plugins = {
    { "rawnly/sex",                      main = "sex",              opts = { host = "layer", bin = HOME .. "/.local/share/mise/installs/go/1.27.3/bin/sex",  },      version = "feature/amber" },
    { "rawnly/smart-splits-backend-rex", main = "smart-splits-rex", opts = { resize_amount = 3 } },
    { "rawnly/bracco",                   main = "bracco",           version = "feature/rex_plugin", opts = {} },
    {
      "rawnly/pooh",
      main = "pooh",
      opts = { key = "ctrl+a>o" },
    },
  },
})

for _, action in ipairs({ "quick-open", "popup", "edit-scrollback", "pane-float", "pane-minimize", "broadcast" }) do
  require("actions." .. action)
end

rex.bind("ctrl+a>p", "sex_pick")

require("keys")
