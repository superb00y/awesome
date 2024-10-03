local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")

return function()
  local clock_widget = wibox.widget({
    {
      {
        {
          id = "label",
          align = "center",
          valign = "center",
          format = "%H:%M",
          widget = wibox.widget.textclock,
        },
        id = "clock_layout",
        layout = wibox.layout.fixed.horizontal,
      },
      id = "container",
      left = dpi(8),
      right = dpi(8),
      widget = wibox.container.margin,
    },
    fg = beautiful.red,
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 5)
    end,
    widget = wibox.container.background,
  })

  return clock_widget
end
