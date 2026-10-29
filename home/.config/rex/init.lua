-- Entry point. Order matters: plugins, then actions, then the keys that bind them.
local amber_path = os.getenv("HOME") .. "/.local/share/rex/amber/amber.lua"
local dev_amber_path = os.getenv("HOME") .. "/Developer/projects/amber/amber.lua"

local use_dev = false

local amber = dofile(use_dev and dev_amber_path or amber_path)

amber.setup({
	plugins = {
		{ "rawnly/smart-splits-backend-rex", main = "smart-splits-rex", opts = { resize_amount = 3 } },
		{ "rawnly/bracco", main = "bracco", version = "feature/rex_plugin", opts = {} },
		{ "rawnly/pooh", main = "pooh", opts = { key = "ctrl+a>o", args = { "--vim" } } },
	},
})

for _, action in ipairs({ "quick-open", "popup", "edit-scrollback" }) do
	require("actions." .. action)
end

require("keys")
