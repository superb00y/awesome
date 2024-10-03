local awful = require("awful")
local naughty = require("naughty")
local user = require("user")
local home = os.getenv("HOME") .. "/"

awesome.connect_signal("screenshot::full", function()
  awful.spawn.easy_async_with_shell(home .. ".config/awesome/scripts/screenshot full ")

  naughty.notify({
    app_name = "awesome",
    title = "Screenshot",
    message = "Saved to " .. user.screenshotdir,
    actions = {},
  })
end)

awesome.connect_signal("screenshot::area", function()
  awful.spawn.easy_async_with_shell(home .. ".config/awesome/scripts/screenshot area ")
end)

awesome.connect_signal("screenshot::areamagick", function()
  awful.spawn.easy_async_with_shell(home .. ".config/awesome/scripts/screenshot areamagick ")
end)

awesome.connect_signal("screenshot::active", function()
  awful.spawn.easy_async_with_shell(home .. ".config/awesome/scripts/screenshot active ")
end)

awesome.connect_signal("screenshot::activemagick", function()
  awful.spawn.easy_async_with_shell(home .. ".config/awesome/scripts/screenshot activemagick ")
end)
