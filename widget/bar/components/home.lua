local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")

return function()
  local home = wibox.widget({
    {
      {
        {
          {
            image = beautiful.aweicon,
            halign = "center",
            valign = "center",
            widget = wibox.widget.imagebox,
          },
          margins = dpi(5),
          widget = wibox.container.margin,
        },
        align = "center",
        widget = wibox.container.place,
      },
      forced_width = dpi(50),
      widget = wibox.container.margin,
    },
    bg = beautiful.bg_normal,
    shape = helpers.rrect(5),
    widget = wibox.container.background,
    buttons = {
      awful.button({}, 1, function()
        require("widget.bar.promptbar"):toggle()
      end),
    },
  })

  helpers.hoverCursor(home)

  return home
end
