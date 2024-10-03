local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")

return function()
  local clock = {
    {
      {
        format = "<b>%I:%M</b>",
        valign = "center",
        halign = "center",
        widget = wibox.widget.textclock,
        font = beautiful.font .. "11",
      },
      left = dpi(15),
      right = dpi(15),
      bottom = dpi(2),
      top = dpi(2),
      widget = wibox.container.margin,
    },
    fg = beautiful.fg_normal,
    bg = beautiful.bg_normal,
    visible = true,
    shape = helpers.rrect(10),
    widget = wibox.container.background,
  }
  return clock
end
