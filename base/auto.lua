local awful = require("awful")
-- local user = require("user")

-- -- handle music shit
-- if user.music_enabled == true then
--   awful.spawn.once("mpd")
--   awful.spawn.once("mpDris2")
-- end

awful.spawn.once("picom")
awful.spawn.once("xsettingsd")
-- awful.spawn.once("xscreensaver")
awful.spawn.once("nm-applet")
-- awful.spawn.once("redshift-gtk")
-- awful.spawn.once("flameshot")
