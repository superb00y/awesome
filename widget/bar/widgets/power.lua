--------------------------------
-- This is the power widget --
--------------------------------

-- Awesome Libs
local awful = require("awful")
local color = require("src.theme.colors")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")
require("src.core.signals")

-- Icon directory path
local icondir = awful.util.getdir("config") .. "src/assets/icons/power/"

return function()
  local power_widget = wibox.widget({
    {
      {
        {
          {
            id = "icon",
            image = gears.color.recolor_image(icondir .. "power.svg", color["Pink50"]),
            widget = wibox.widget.imagebox,
            resize = true,
          },
          id = "icon_layout",
          widget = wibox.container.place,
        },
        id = "icon_margin",
        top = dpi(2),
        bottom = dpi(2),
        widget = wibox.container.margin,
      },
      id = "power_layout",
      layout = wibox.layout.fixed.horizontal,
    },
    id = "container",
    left = dpi(9),
    right = dpi(8),
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 5)
    end,
    widget = wibox.container.margin,
  })

  power_widget:connect_signal("button::release", function()
    awesome.emit_signal("module::powermenu:show")
  end)

  return power_widget
end
