local wibox = require("wibox")
local awful = require("awful")
local user = require("user")
local helpers = require("helpers")
local beautiful = require("beautiful")
local components = require(... .. ".components")
local dpi = beautiful.xresources.apply_dpi

screen.connect_signal("request::desktop_decoration", function(s)
  s.control_center = wibox({
    screen = s,
    width = dpi(450),
    height = s.geometry.height * 0.9,
    shape = user.style == "rounded" and helpers.Rrrect(15) or user.style == "semi-rounded" and helpers.Rrrect(10),
    bg = beautiful.bg_dark,
    ontop = true,
    visible = false,
  })

  s.control_center:setup({
    {
      components.profile(s),
      margins = { top = dpi(20), left = dpi(20), right = dpi(20) },
      widget = wibox.container.margin,
    },
    {
      components.buttons(s),
      margins = { left = dpi(20), right = dpi(20) },
      widget = wibox.container.margin,
    },
    {
      components.volume_slider(s),
      margins = { left = dpi(30), right = dpi(39) },
      widget = wibox.container.margin,
    },
    {
      components.music(s),
      margins = { left = dpi(20), right = dpi(20) },
      widget = wibox.container.margin,
    },
    {
      components.themer(s),
      margins = { left = dpi(20), right = dpi(20) },
      widget = wibox.container.margin,
    },
    expand = "none",
    spacing = dpi(25),
    layout = wibox.layout.fixed.vertical,
  })

  awful.placement.right(s.control_center, {
    margins = { bottom = 90, top = 90 },
  })

  awesome.connect_signal("controlcenter::toggle", function(src)
    if src == s then
      s.control_center.visible = not s.control_center.visible
    end
  end)
end)
