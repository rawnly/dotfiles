local M = {}
local bin = "/opt/homebrew/bin/yabai"

local function yabai(commands)
	if type(commands) == "string" then
		os.execute(bin .. " -m " .. commands)
	else
		for _, cmd in ipairs(commands) do
			os.execute(bin .. " -m " .. cmd)
		end
	end
end

function M.super(key, commands)
	hs.hotkey.bind({ "alt", "shift", "cmd", "ctrl" }, key, function()
		yabai(commands)
	end)
end

function M.alt(key, commands)
	hs.hotkey.bind({ "alt" }, key, function()
		yabai(commands)
	end)
end

function M.altShift(key, commands)
	hs.hotkey.bind({ "alt", "shift" }, key, function()
		yabai(commands)
	end)
end

function M.altCtrl(key, commands)
	hs.hotkey.bind({ "alt", "ctrl" }, key, function()
		yabai(commands)
	end)
end

function M.altCmd(key, commands)
	hs.hotkey.bind({ "alt", "cmd" }, key, function()
		yabai(commands)
	end)
end

return M
