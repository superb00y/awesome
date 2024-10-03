----------------------------------
-- This is the layoutbox widget --
----------------------------------

-- Awesome Libs
local awful = require("awful")
local color = require("src.theme.colors")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")
require("src.core.signals")

-- Returns the layoutbox widget
return function(s)
  local layout = wibox.widget({
    {
      {
        awful.widget.layoutbox(s),
        id = "icon_layout",
        widget = wibox.container.place,
      },
      id = "icon_margin",
      left = dpi(3),
      right = dpi(3),
      top = dpi(4),
      bottom = dpi(4),
      forced_width = dpi(40),
      widget = wibox.container.margin,
    },
    bg = color["colorL"],
    fg = color["tokyo3"],
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 5)
    end,
    widget = wibox.container.background,
    screen = s,
  })

  layout:connect_signal("button::press", function()
    awful.layout.inc(-1, s)
  end)

  return layout
end
