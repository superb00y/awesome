local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local dpi = beautiful.xresources.apply_dpi

return function()
  local systray = wibox.widget({
    {
      {
        {
          horizontal = true,
          base_size = dpi(21),
          spacing = dpi(9),
          widget = wibox.widget.systray,
        },
        align = "center",
        layout = wibox.container.place,
      },
      left = dpi(15),
      right = dpi(15),
      bottom = dpi(2),
      top = dpi(2),
      widget = wibox.container.margin,
    },
    fg = beautiful.fg_normal,
    bg = beautiful.bg_systray,
    visible = true,
    shape = helpers.rrect(10),
    widget = wibox.container.background,
  })
  return systray
end
