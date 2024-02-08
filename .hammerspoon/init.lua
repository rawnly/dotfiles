local kbd = require("keyboard.yabai")
--
local homeRow = {
	h = "west",
	l = "east",
	j = "south",
	k = "north",
}

kbd.altCmd("return", "window --toggle zoom-fullscreen")

for key, direction in pairs(homeRow) do
	kbd.altCtrl(key, "window --swap " .. direction)
end
