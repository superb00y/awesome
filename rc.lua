pcall(require, "luarocks.loader")

local beautiful = require("beautiful")
local naughty = require("naughty")
local awful = require("awful")

naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification({
    urgency = "critical",
    title = "You fucked up hard" .. (startup and " during startup!" or "!"),
    massage = message,
  })
end)

beautiful.init(require("theme"))

awful.util.shell = "fish"

require("user")
require("base")
require("signals")
require("base.auto") -- autostarts
require("widget")
require("theme.reload-theme") -- theme
