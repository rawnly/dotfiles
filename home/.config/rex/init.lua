local home = os.getenv("HOME")

local rpm = dofile(home .. "/Developer/projects/rex-plugin-manager/rex_plugin_manager.lua")

rpm.setup({
	plugins = {
		{
			"rawnly/smart-splits-backend-rex",
			main = "smart-splits-rex",
			opts = {},
		},
	},
})

require("actions.quick-open")
require("actions.move-pane")
require("keys")
