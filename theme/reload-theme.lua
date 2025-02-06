local awful = require("awful")
local gfs = require("gears.filesystem")
local beautiful = require("beautiful")

local function reload_theme()
	-- local path = gfs.get_configuration_dir() .. "theme/desktop.sh " .. "theme"
	-- awful.spawn.with_shell("bash -e " .. path)
end

reload_theme()
