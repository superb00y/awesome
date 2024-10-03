local awful = require("awful")
local dpi = require("beautiful").xresources.apply_dpi
local user = require("user")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")

return function(s)
  local layout = wibox.widget({
    {
      {
        awful.widget.layoutbox(s),
        id = "icon_layout",
        widget = wibox.container.place,
      },
      id = "icon_margin",
      left = dpi(5),
      right = dpi(5),
      forced_width = dpi(30),
      widget = wibox.container.margin,
    },
    bg = beautiful.bg_light,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 5)
    end,
    widget = wibox.container.background,
    screen = s,
    visible = #user.layouts > 1,
    buttons = {
      awful.button({}, 1, function()
        awful.layout.inc(1)
      end),
      awful.button({}, 3, function()
        awful.layout.inc(-1)
      end),
      awful.button({}, 4, function()
        awful.layout.inc(-1)
      end),
      awful.button({}, 5, function()
        awful.layout.inc(1)
      end),
    },
  })
  return layout
end
