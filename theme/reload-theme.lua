local awful = require("awful")
local gfs = require("gears.filesystem")
local naughty = require("naughty")
local beautiful = require("beautiful")

local function reload_theme()
  local path = gfs.get_configuration_dir() .. "theme/desktop.sh " .. beautiful.theme

  awful.spawn.with_shell("bash -e " .. path)

  naughty.notify({
    title = "theme",
    message = "theme set to " .. beautiful.theme .. "!!!",
  })
end

reload_theme()
