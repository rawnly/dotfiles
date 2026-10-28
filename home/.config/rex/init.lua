-- Entry point. Order matters: plugins, then actions, then the keys that bind them.
local rpm = dofile(os.getenv("HOME") .. "/.local/share/rex/rpm/rex_plugin_manager.lua")

rpm.setup({
	plugins = {
		{ "rawnly/smart-splits-backend-rex", main = "smart-splits-rex", opts = { resize_amount = 3 } },
	},
})

for _, action in ipairs({ "quick-open", "move-pane", "popup", "edit-scrollback" }) do
	require("actions." .. action)
end

require("keys")
